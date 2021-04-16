/*

Script      : CL3 ( = CLCL CLone ) - AutoHotkey 1.1+ (Ansi and Unicode)
Version     : 1.99.1
Author      : hi5
Purpose     : A lightweight clone of the CLCL clipboard caching utility which can be found at
              http://www.nakka.com/soft/clcl/index_eng.html written in AutoHotkey 
Source      : https://github.com/hi5/CL3

Features:
- Captures text only
- Limited history (18 items+26 items in secondary menu)
  (does remember more entries in XML history file though)
- Delete entries from history
- No duplicate entries in clipboard (automatically removed)
- Templates: simply textfiles which are read at start up
- Plugins: AutoHotkey functions (scripts) defined in seperate files
  v1.2: Search and Slots for quick pasting
  v1.3: Cycle through clipboard history, paste current clipboard as plain text
  v1.4: AutoReplace define find/replace rules to modify clipboard before adding it the clipboard
  v1.5: ClipChain cycle through a predefined clipboard history
  v1.6: Compact (reduce size of History) and delete from search search results
  v1.7: FIFO Paste back in the order in which the entries were added to the clipboard history
  v1.8: Edit entries in History (via search). Cycle through plugins
  v1.9: Folder structure for Templates\
  v1.9.x: sort, api, settings etc see changelog.md

See readme.md for more info and documentation on plugins and templates.

*/
; General script settings
#SingleInstance, Force
SetBatchlines, -1
SendMode, Input
SetWorkingDir, %A_ScriptDir%
AutoTrim, off
StringCaseSense, On
name:="CL3 "
version:="v1.99.1"
CycleFormat:=0
Templates:={}
Global CyclePlugins,History,SettingsObj,Slots,ClipChainData ; CyclePlugins v1.72+, others v1.9.4 for API access
Error:=0
CoordMode, Menu, Screen
ListLines, Off
PasteTime:=A_TickCount
CyclePluginsToolTipLine := "`n" StrReplace( Format( "{:020}", "" ), 0, Chr(0x2014) ) "`n"
ClipboardHistoryToggle:=0
TemplateClip:=0
;CyclePluginClip:=0

iconlist:="a,c,s,t,x,y,z"
loop, parse, iconlist, CSV
	icon%A_LoopField%:="icon-" A_LoopField ".ico"

Pause, Off
Suspend, Off

Settings()
Settings_Hotkeys()

; tray menu
Menu, Tray, Icon, res\cl3.ico, , 1
Menu, tray, Tip , %name% %version% 
Menu, tray, NoStandard
Menu, tray, Add, %name% %version%     , DoubleTrayClick
Menu, tray, Icon, %name% %version%    , res\cl3.ico
Menu, tray, Default, %name% %version% 
Menu, tray, Click, 1 ; this will show the tray menu because we send {rbutton} at the DoubleTrayClick label
Menu, tray, Add, 
Menu, tray, Add, &AutoReplace Active  , TrayMenuHandler
Menu, tray, Add, &FIFO Active         , TrayMenuHandler
Menu, tray, Add, 
Menu, tray, Add, &Usage statistics    , TrayMenuHandler
Menu, tray, Icon,&Usage statistics    , shell32.dll, 278
Menu, tray, Add, 
Menu, tray, Add, &Settings            , TrayMenuHandler
Menu, tray, Icon,&Settings            , dsuiext.dll, 36
Menu, tray, Add, 
Menu, tray, Add, &Reload this script  , TrayMenuHandler
Menu, tray, Icon,&Reload this script  , shell32.dll, 239
Menu, tray, Add, &Edit this script    , TrayMenuHandler
Menu, tray, Icon,&Edit this script    , comres.dll, 7
Menu, tray, Add, 
Menu, tray, Add, &Suspend Hotkeys     , TrayMenuHandler
Menu, tray, Icon,&Suspend Hotkeys     , %A_AhkPath%, 3
Menu, tray, Add, &Pause Script        , TrayMenuHandler
Menu, tray, Icon,&Pause Script        , %A_AhkPath%, 4
Menu, tray, Add, 
Menu, tray, Add, &Pause clipboard history, TrayMenuHandler
Menu, tray, Add, 
Menu, tray, Add, Exit                 , SaveSettings
Menu, tray, Icon, %MenuPadding%Exit   , shell32.dll, 132

Menu, ClipMenu, Add, TempText, MenuHandler
Menu, SubMenu1, Add, TempText, MenuHandler
Menu, SubMenu2, Add, TempText, MenuHandler
Menu, SubMenu3, Add, TempText, MenuHandler
Menu, SubMenu4, Add, TempText, MenuHandler

; load clipboard history and templates
IfNotExist, %A_ScriptDir%\ClipData\History\History.xml
	Error:=1

if (XA_Load( A_ScriptDir "\ClipData\History\History.xml") = 1) ; the name of the variable containing the array is returned OR the value 1 in case of error
	Error:=1

If (Error = 1)
{
	 FileCopy, res\history.bak.txt, %A_ScriptDir%\ClipData\History\History.xml, 1
	 History:=[]
	 XA_Load(A_ScriptDir "\ClipData\History\History.xml") ; the name of the variable containing the array is returned OR the value 1 in case of error
	}

OnExit, SaveSettings

If !FileExist("templates\*.txt")
	FileCopy, res\01_Example.txt, templates\01_Example.txt, 0

; get templates in root folder first
Loop, templates\*.txt
	templatefilelist .= A_LoopFileName "|"
templatefilelist:=Trim(templatefilelist,"|")
Sort, templatefilelist, D|

Loop, parse, templatefilelist, |
	{
	 FileRead, a, templates\%A_LoopField%
	 Templates["submenu2",A_Index]:=a
	 a:=""
	}

; now check for folders for possible sub-submenus
Loop, Files, templates\*.*, D
	templatesfolderlist .= A_LoopFileName "|"
templatesfolderlist:=Trim(templatesfolderlist,"|")
Sort, templatesfolderlist, D|
StringUpper, templatesfolderlist, templatesfolderlist

OnClipboardChange("FuncOnClipboardChange")

If ActivateBackup
	SetTimer, Backup, % BackupTimer*60000 ; minutes

/*
FILE_NOTIFY_CHANGE_FILE_NAME   = 1   (0x00000001) : Notify about renaming, creating, or deleting a file.
FILE_NOTIFY_CHANGE_DIR_NAME    = 2   (0x00000002) : Notify about creating or deleting a directory.
FILE_NOTIFY_CHANGE_SIZE        = 8   (0x00000008) : Notify about any file-size change.
FILE_NOTIFY_CHANGE_LAST_WRITE  = 16  (0x00000010) : Notify about any change to the last write-time of files.
                               = 27
*/
WatchFolder("templates\", "UpdateTemplate", true, 27) ; just a shortcut to reload the template menu to avoid manual reload

If ActivateApi
	ObjRegisterActive(CL3API, "{01DA04FA-790F-40B6-9FB7-CE6C1D53DC38}")

#Include %A_ScriptDir%\plugins\plugins.ahk

UpdateTemplate(folder,Changes)                        ; WatchFolder() above
	{
	 Reload
	 Sleep 1000
	 ExitApp
	}

~^x::
~^c::
WinGet, IconExe, ProcessPath , A
Sleep 100
ClipText:=Clipboard
Return

hk_BypassAutoReplace:
OnClipboardChange("FuncOnClipboardChange", 0)
Clipboard:=ClipboardByPass
Sleep 100
Send ^v
Sleep 100
Clipboard:=""
Clipboard:=History[1].text
OnClipboardChange("FuncOnClipboardChange", 1)
Return

; show clipboard history menu

;!^v::
hk_menu:
Gosub, FifoInit
BuildMenuFromFifo:
Gosub, BuildMenuHistory
Gosub, BuildMenuPluginTemplate
WinGetPos, MenuX, MenuY, , , A
MenuX+=A_CaretX
MenuX+=20
MenuY+=A_CaretY
MenuY+=10
If (A_CaretX <> "")
	Menu, ClipMenu, Show, %MenuX%, %MenuY%
Else
 {
;	TrayTip, TrayMenu, CL3Coords2, 2 ; debug
	Menu, ClipMenu, Show
 }
Return

; 1x paste as plain text
;^+v::
hk_plaintext:
If (Clipboard = "") ; probably image format in Clipboard
	Clipboard:=History[1].text
Clipboard:=Trim(Clipboard,"`n`r`t ")
PasteIt()
Return

$^v:: ; v1.91, $ for v1.95 (due to clipchain updates)
hk_clipchainpaste_defaultpaste:
If !WinExist("CL3ClipChain ahk_class AutoHotkeyGUI") or ClipChainPause
	{
	 PasteIt("normal")
	 Return
	}
If WinExist("CL3ClipChain ahk_class AutoHotkeyGUI")
	{
	 If (hk_clipchainpaste <> "^v") or ClipChainPause ; exception so user can use ^v as clipchain hotkey if they wish
		PasteIt()
	 else
		Gosub, ClipChainPasteDoubleClick
	}
else
	Gosub, ClipChainPasteDoubleClick
Return

; Cycle through clipboard history
;#v::
hk_cyclebackward:
If !ActiveWindowID
	WinGet, ActiveWindowID, ID, A
cyclebackward:=1
PreviousClipCycleCounter:=0 ; 13/10/2017 test
ClipCycleCounter:=1
ClipCycleFirst:=1
While GetKeyState(hk_cyclemodkey,"D") and cyclebackward
	{
;	 If !(PreviousClipCycleCounter = ClipCycleCounter) and (oldttext <> ttext)
	 Indicator:=""
	 If (ClipCycleCounter = 1) and (ClipboardPrivate = 1)
		Indicator:="*"
	 If (ClipCycleCounter <> 0)
		ttext:=% Chr(96+ClipCycleCounter) Indicator " : " DispToolTipText(History[ClipCycleCounter].text)
	 else
		ttext:="[cancelled]"
	 If (oldttext <> ttext)
		{
		 ToolTip, % ttext, %A_CaretX%, %A_CaretY%
		 oldttext:=ttext
		}
	 Sleep 100
	 KeyWait, %hk_cyclebackward% ; This prevents the keyboard's auto-repeat feature from interfering.
	}
ToolTip	
If (ClipCycleCounter > 0) ; If zero we've cancelled it
	{
	 ClipText:=History[ClipCycleCounter].text
	 ;MenuItemPos:=ClipCycleCounter ; ClipboardHandler will handle deleting it from the chosen position in History
	 Gosub, ClipboardHandler
	 stats.cyclepaste++
	 ClipCycleCounter:=1
	}
Return

;#v up::
hk_cyclebackward_up:
PreviousClipCycleCounter:=ClipCycleCounter
If (ClipCycleFirst = 0)
	ClipCycleCounter++
ClipCycleFirst:=0
Return

;#c::
hk_cycleforward:
If !ActiveWindowID
	WinGet, ActiveWindowID, ID, A
cycleforward:=1
ClipCycleBackCounter:=1
If (ClipCycleCounter=1) or (ClipCycleCounter=0)
	Return
ClipCycleCounter--
If (ClipCycleCounter < 1)
	ClipCycleCounter:=1
While GetKeyState(hk_cyclemodkey,"D") and cycleforward
	{
;	 If !(PreviousClipCycleCounter = ClipCycleCounter) and (oldttext <> ttext)
	 Indicator:=""
	 If (ClipCycleCounter = 1) and (ClipboardPrivate = 1)
		Indicator:="*"
	 If (ClipCycleCounter <> 0)
		ttext:=% Chr(96+ClipCycleCounter) Indicator " : " DispToolTipText(History[ClipCycleCounter].text)
	 else
		ttext:="[cancelled]"
	 If (oldttext <> ttext)
		{
		 ToolTip, % ttext, %A_CaretX%, %A_CaretY%
		 oldttext:=ttext
		}
	 Sleep 100
	 KeyWait, %hk_cycleforward% ; This prevents the keyboard's auto-repeat feature from interfering.
	}
ToolTip
Return

;#c up::
hk_cycleforward_up:
PreviousClipCycleCounter:=""
If (ClipCycleBackCounter=0)
	ClipCycleCounter--
If (ClipCycleCounter < 1)
	ClipCycleCounter:=1
ClipCycleBackCounter:=0
Return

; Cancel Cycle pasting
;#x up::
hk_cyclecancel:
ToolTip
ClipCycleCounter:=0
oldttext:="", ttext:="", ActiveWindowID:=""
Return

; use #f to cycle through formats (defined in settings.ini / [plugins])
; #If ClipCycleCounter
;#f::
hk_cycleplugins:
If !ActiveWindowID
	WinGet, ActiveWindowID, ID, A
cycleforward:=0, cyclebackward:=0	
CycleFormat:=0
If (ClipCycleCounter = 0) or (ClipCycleCounter = "")
	ClipCycleCounter:=1
While GetKeyState(hk_cyclemodkey,"D")
	{
	 If (ClipCycleCounter <> 0)
		ttext:=% "Plugin: " ((CyclePlugins.HasKey(CycleFormat) = "0") ? "[none]" : CyclePlugins[CycleFormat]) CyclePluginsToolTipLine DispToolTipText(History[ClipCycleCounter].text,CycleFormat)
	 else
		ttext:="Plugin: [cancelled]" CyclePluginsToolTipLine
	 If (oldttext <> ttext)
		{
		 ToolTip, % ttext, %A_CaretX%, %A_CaretY%
		 oldttext:=ttext
		}

	 Sleep 100
	 KeyWait, %hk_cycleplugins% ; This prevents the keyboard's auto-repeat feature from interfering.
	}
ToolTip
If (ClipCycleCounter > 0) ; If zero we've cancelled it
	{
	 ClipText:=DispToolTipText(History[ClipCycleCounter].text,CycleFormat)
;	 CyclePluginClip:=1
;	 MenuItemPos:=ClipCycleCounter
	 Gosub, ClipboardHandler
	 stats.cycleplugins++
	 ClipCycleCounter:=0
;	 CyclePluginClip:=0
	}
Return

;#f up::
hk_cycleplugins_up:
if (CycleFormat > CyclePlugins.MaxIndex())
	CycleFormat:=0
CycleFormat++
Sleep 100
Return	

BuildMenuHistory:
Menu, ClipMenu, Delete
Try
	Menu, SubMenu1, Delete
Try
	Menu, SubMenu2, Delete
Try
	Menu, SubMenu3, Delete
Try
	Menu, SubMenu4, Delete

for k, v in History
	{
	 text:=v.text
	 icon:=v.icon
	 lines:=v.lines
	 Indicator:=""
	 if (icon = "")
		icon:="res\" iconA
	 If (A_Index=1) and (ClipboardPrivate = 1) ; indicate to user clipboard has different data as first entry in history (excluded programs)
		Indicator:="*"
	 key:=% "&" Chr(96+A_Index) Indicator ". " DispMenuText(SubStr(text,1,500),lines)
	 Menu, ClipMenu, Add, %key%, MenuHandler
	 if (k = 1)
		Menu, ClipMenu, Default, %key%
	 If (A_Index = 1)
		 Menu, ClipMenu, Icon, %key%, res\%iconC%, , 16
	 Else
		Try
			Menu, ClipMenu, Icon, %key%, % icon
		Catch
			Menu, ClipMenu, Icon, %key%, res\%iconA%, , 16

	 If (A_Index = 18)
		Break
	}
Return

BuildMenuPluginTemplate:

Menu, ClipMenu, Add

If !FIFOACTIVE
	{
	 pluginlist:=pluginlistClip "|#" MyPluginlistFunc "|#" pluginlistFunc
	 loop, parse, pluginlist, |
		{
		 if (SubStr(A_LoopField,1,1) = "#")
			{
			 If (StrLen(A_LoopField) = 1)
				continue
			 Menu, Submenu1, Add
			}
		 key:=% "&" Chr(96+A_Index) ". " ; %
		 StringTrimRight,MenuText,A_LoopField,4
		 MenuText:=Trim(MenuText,"#")
		 MenuTextClean:=Trim(MenuText,"#")
		 MenuText:=key RegExReplace(MenuText, "m)([A-Z]+)" , " $1")
		 Menu, Submenu1, Add, %MenuText%, SpecialMenuHandler
		 Menu, Submenu1, Icon, %MenuText%, res\%iconS%,,16
		 If IsObject(%MenuTextClean%Menu)
			{
			 Menu, Submenu1, Add, %MenuText%, :%MenuTextClean%Menu
			 Menu, Submenu1, Icon, %MenuText%, res\%iconS%,,16
			}
		}
Menu, ClipMenu, Add, &s. Special, :Submenu1
Menu, ClipMenu, Icon, &s. Special, res\%iconS%,,16

If (templatefilelist <> "")
	{
	 Loop, Parse, templatefilelist, |
		{
		 key:=% "&" Chr(96+A_Index) ". " ; %
		 MenuText:=key SubStr(A_LoopField, InStr(A_LoopField,"_")+1)
		 StringTrimRight,MenuText,MenuText,4
		 Menu, Submenu2, Add, %MenuText%, TemplateMenuHandler
		 Menu, Submenu2, Icon, %MenuText%, res\%iconT%,,16
		}
	 Menu, Submenu2, Add, &0. Open templates folder, TemplateMenuHandler
	 Menu, Submenu2, Icon, &0. Open templates folder, res\%iconT%,,16

	If (templatesfolderlist <> "")
		{
		 Loop, Parse, templatesfolderlist, |
		 {

			templatefolder:=A_LoopField
			Loop, files, templates\%A_LoopField%\*.txt
				{
				 templatefolderFiles .= A_LoopFileName "|"
				 Sort, templatefolderFiles, D|
				}
			templatefolderFiles:=Trim(templatefolderFiles,"|")
			Loop, parse, templatefolderFiles, |
				{
				 FileRead, a, templates\%templatefolder%\%A_LoopField%
				 Templates[templatefolder,A_Index]:=a
				 key:=% "&" Chr(96+A_Index) ". " ; %
				 MenuText:=key SubStr(A_LoopField, InStr(A_LoopField,"_")+1)
				 Menu, %templatefolder%, Add, %MenuText%, TemplateMenuHandler
				 Menu, %templatefolder%, Icon, %MenuText%, res\%iconT%,,16
				 a:=""
				}
			templatefolderFiles:=""
		 }

		 Loop, parse, templatesfolderlist, |
			{
			 Menu, SubMenu2, Add, &%A_LoopField%, :%A_LoopField%
			 try
				Menu, SubMenu2, Icon, &%A_LoopField%, templates\%A_LoopField%\favicon.ico,,16
			 catch
				Menu, SubMenu2, Icon, &%A_LoopField%, res\%iconT%,,16
			}
		}
	}
Else
	Menu, Submenu2, Add, "No templates", TemplateMenuHandler
Menu, ClipMenu, Add, &t. Templates, :Submenu2
Menu, ClipMenu, Icon, &t. Templates, res\%iconT%,,16
Loop 18
	Menu, Submenu3, Add, % "&" Chr(96+A_Index) ".", MenuHandler
}

; More history... (alt-z)

If (History.MaxIndex() > 20)
	{
	 for k, v in History
		{
		 text:=v.text
		 icon:=v.icon
		 lines:=v.lines
		 If (A_Index < 19)
			Continue
		 If (A_Index < 45)
			 key:=% "&" Chr(96-18+A_Index) ". " DispMenuText(SubStr(text,1,500),lines)
		 Else
			 key:=% "  " DispMenuText(SubStr(text,1,500),lines)
		 Menu, SubMenu4, Add, %key%, MenuHandler
		 Try
			Menu, SubMenu4, Icon, %key%, % icon
		 Catch
			Menu, SubMenu4, Icon, %key%, res\%iconA%, , 16
		 If (A_Index > 43)
			Break
		} 
	}
Else
	{
	 Menu, SubMenu4, Add, No entries ..., MenuHandler
	 Menu, SubMenu4, Icon, No entries ..., res\%iconA%, , 16
	}

If !FIFOACTIVE
	{
	 Menu, ClipMenu, Add, &y. Yank entry, :Submenu3
	 Menu, ClipMenu, Icon, &y. Yank entry, res\%iconY%,,16
	}
Menu, ClipMenu, Add, &z. More history, :Submenu4
Menu, ClipMenu, Icon, &z. More history, res\%iconZ%,,16
Menu, ClipMenu, Add
Menu, ClipMenu, Add, E&xit (Close menu), MenuHandler
Menu, ClipMenu, Icon, E&xit (Close menu), res\%iconX%,,16
Return

DispMenuText(TextIn,lines="1")
	{
	 global MenuWidth,ShowLines,LineTextFormat
	 if (lines=1)
		linetext:=LineTextFormat[1]
	 else
		linetext:=LineTextFormat[2]
	 TextOut:=RegExReplace(TextIn,"m)^\s*")
	 TextOut:=RegExReplace(TextOut, "\s+", " ")
	 StringReplace,	TextOut, TextOut, &amp;amp;, &, All
	 StringReplace, TextOut, TextOut, &, &&, All
	 If StrLen(TextOut) > 60
		{
		 TextOut:=SubStr(TextOut,1,MenuWidth) " " Chr(8230) " " SubStr(RTrim(TextOut,".`n"),-10) ; 8230 ...	
		}
	 TextOut .= " " Chr(171)
	 if ShowLines
		TextOut .= StrReplace(linetext,"\l",lines)
	 Return LTRIM(TextOut," `t")
	}

DispToolTipText(TextIn,Format=0)
	{
	 TextOut:=RegExReplace(TextIn,"^\s*")
	 TextOut:=SubStr(TextOut,1,750)
	 ;StringReplace,TextOut,TextOut,`;,``;,All
	 FormatFunc:=StrReplace(CyclePlugins[Format]," ")
	 If IsFunc(FormatFunc)
		TextOut:=%FormatFunc%(TextOut)
	 Return TextOut
	}

PasteIt(source="")
	{
	 global StartTime,PasteTime,ActiveWindowID,oldttext,ttext,ClipboardOwnerProcessName,ClipboardPrivate
	 StartTime:=A_TickCount
	 If ((StartTime - PasteTime) < 75) ; to prevent double paste after using #f/#v in combination
		Return
	 #Include *i %A_ScriptDir%\plugins\PastePrivateRules.ahk
	 WinActivate, ahk_id %ActiveWindowID%
	 If PasteDelay
		Sleep % PasteDelay
	 Send ^v
	 PasteTime := A_TickCount
	 oldttext:="", ttext:="", ActiveWindowID:="",ClipboardOwnerProcessName:=""

	 If (source <> "normal")
		ClipboardPrivate:=0
	}


; various menu handlers

MenuHandler:
If (Trim(A_ThisMenuItem) = "E&xit (Close menu)")
	{
	 If !FIFOACTIVE:=0
		Return
	 FIFOACTIVE:=0
	 Gosub, FifoInit
	 Gosub, FifoActiveMenu
	 Return
	}

; Yank entry (e.g. delete from history)
If (RegExMatch(Trim(A_ThisMenuItem),"^&[a-r]\.$"))
	{
	 YankItemNo:=Asc(SubStr(Trim(A_ThisMenuItem),2,1))-96
	 History.Remove(YankItemNo)
	 If FIFOACTIVE
		{
		 Gosub, FifoInit
		 Gosub, FifoActiveMenu
		}
	 Return
	}

; secondary history menu (z)
If (A_ThisMenu = "ClipMenu")
	MenuItemPos:=A_ThisMenuItemPos
else
	MenuItemPos:=A_ThisMenuItemPos+18

; debug	
; MsgBox % "A_ThisMenu-" A_ThisMenu " : A_ThisMenuItem-" A_ThisMenuItemPos " : MenuItemPost-" MenuItemPos

If FIFOACTIVE
	{
	 FIFOID:=MenuItemPos
	 Gosub, FifoActiveMenu
	 TrayTip, FIFO, FIFO Paste Mode Activated, 2, 1
	 Return
	}

ClipText:=History[MenuItemPos].text
Gosub, ClipboardHandler
stats.menu++
Return

SpecialMenuHandler:
SpecialFunc:=(SubStr(A_ThisMenuItem,4))
StringReplace, SpecialFunc, SpecialFunc, %A_Space%,,All
If (SpecialFunc = "AutoReplace")	
	{
	 Gosub, AutoReplace
	 Return
	}
If IsFunc(SpecialFunc)
	ClipText:=%SpecialFunc%(History[1].text)
Else
	if (SpecialFunc = "Slots")
		Gosub, hk_slots
Else
	if (SpecialFunc = "Search")	
		Gosub, hk_search
Else
	if (SpecialFunc = "ClipChain")
		Gosub, hk_clipchain
Else
	If (SpecialFunc = "DumpHistory")
		Return
Else
	If (SpecialFunc = "Compact")
		Gosub, Compact
Else
	If (SpecialFunc = "Fifo")
		Gosub, hk_fifo
Gosub, ClipboardHandler
Return

TemplateMenuHandler:
If (A_ThisMenuItem = "&0. Open templates folder")
	{
	 IfWinExist, ahk_exe TOTALCMD.EXE
		Run, c:\totalcmd\TOTALCMD.EXE /O /T %A_ScriptDir%\templates\
	 else
		Run, %A_ScriptDir%\templates\
	 Return
	}

ClipText:=Templates[A_ThisMenu,A_ThisMenuItemPos]
TemplateClip:=1
Gosub, ClipboardHandler
stats.templates++
TemplateClip:=0
Return

ClipBoardHandler:
oldttext:="", ttext:="", ActiveWindowID:=""
If (ClipText <> Clipboard)
	{
	 StrReplace(ClipText,"`n", "`n", Count)
	 If !TemplateClip
		{
		 If History[MenuItemPos].HasKey("Icon")
			IconExe:=History[MenuItemPos,"Icon"]
		 else
			WinGet, IconExe, ProcessPath , A
		}
	 else
		IconExe:="res\" iconT
	 History.Insert(1,{"text":ClipText,"icon": IconExe,"lines": Count+1})
	}
OnClipboardChange("FuncOnClipboardChange", 0)
Clipboard:=ClipText
OnClipboardChange("FuncOnClipboardChange", 1)
PasteIt()
Gosub, CheckHistory
MenuItemPos:=0
Return

FuncOnClipboardChange() {
 global

; The built-in variable A_EventInfo contains:
; 0 if the clipboard is now empty;
; 1 if it contains something that can be expressed as text (this includes files copied from an Explorer window);
; 2 if it contains something entirely non-text such as a picture.

If (A_EventInfo <> 1)
	Return

;ProcesshWnd:=DllCall("GetClipboardOwner", Ptr) ; may not work for all Executables
WinGet, ClipboardOwnerProcessName, ProcessName, % "ahk_id " DllCall("GetClipboardOwner", Ptr)

If (ClipboardOwnerProcessName = "")
	WinGet, ClipboardOwnerProcessName, ProcessName, A

StringLower, ClipboardOwnerProcessName, ClipboardOwnerProcessName ; just in case process has mixed case "KeePass.exe" - Exclude is set to lowercase after IniRead (lib\settings.ahk)

if ClipboardOwnerProcessName in %Exclude%
	{
	 ClipboardOwnerProcessName:="",ClipboardPrivate:=1
	 Return
	}
else
	ClipboardOwnerProcessName:="", ClipboardPrivate:=0

If CopyDelay
	Sleep % CopyDelay

WinGet, IconExe, ProcessPath , A
If ((History.MaxIndex() = 0) or (History.MaxIndex() = "")) ; just make sure we have the History Object and add "some" text
	History.Insert(1,{"text":"Text","icon": IconExe,"lines": 1})

History_Save:=1

; no longer used v1.95
;If !WinExist("CL3ClipChain ahk_class AutoHotkeyGUI")
;	ScriptClipClipChain:=0

;CF_METAFILEPICT := 0x3 ; IsClipboardFormatAvailable

; Skipping Excel.exe +
; Skipping CF_METAFILEPICT avoids "This picture is too large and will be truncated" error MsgBox in Excel it seems
; this allows the various formats to be stored (temporarily) so we can paste the formatted text which may have been changed by AutoReplace - this avoids the need to turn AR on/off to get something to paste
If !WinActive("ahk_exe excel.exe")
	{
	 If (hk_BypassAutoReplace <> "")
		{
		 ClipboardByPass:=ClipboardAll
		}
	}
else ; Excel is active; check CF_METAFILEPICT, if not present we can safely store ClipboardAll
	If (DllCall("IsClipboardFormatAvailable", "Uint", 3) = 0)
		ClipboardByPass:=ClipboardAll

if (Clipboard = "") ; or (ScriptClipClipChain = 1) ; avoid empty entries or changes made by script which you don't want to keep
	Return

AutoReplace()

If (Clipboard == History[1].text) ; v1.95
	{
	 ClipText:=""
	 Return
	}

ClipText=%Clipboard%

StrReplace(ClipText, "`n", "`n", Count)

History.Insert(1,{"text":ClipText,"icon": IconExe,"lines": Count+1})

Gosub, CheckHistory

stats.copieditems++

ClipText:=""

Return
}

CheckHistory: ; check for duplicate entries

newhistory:=[]
for k, v in History
	{
	 check:=v.text
	 icon:=v.icon
	 lines:=v.lines
	 new:=true
	 for p, q in newhistory
		{
		 if (check == q.text)
			{
			 new:=false
			}
		}
	 if new
		newhistory.push({"text":check,"icon":icon,"lines":lines})
	 if (A_Index >= MaxHistory)
		break
	}

History:=newhistory

check:="", new:="", icon:="", lines:=""

newhistory:=[]

Return

; If the tray icon is double click we do not actually want to do anything
DoubleTrayClick: 
Send {rbutton}
Return

TrayMenuHandler:
; Easy & Quick options first
If (A_ThisMenuItem = "&Reload this script")
	{
	 Reload
	 Return
	}
Else If (A_ThisMenuItem = "&Edit this script")
	{
	 Run Edit %A_ScriptName%
	 Return
	}
Else If (A_ThisMenuItem = "&Suspend Hotkeys")
	{
	 Menu, tray, ToggleCheck, &Suspend Hotkeys
	 Suspend
	 Return
	}
Else If (A_ThisMenuItem = "&Pause Script")
	{
	 Menu, tray, ToggleCheck, &Pause Script
	 Pause
	 Return
	}
Else If (A_ThisMenuItem = "&Pause clipboard history")
	{
	 CL3Api_State(ClipboardHistoryToggle)
	 Menu, tray, ToggleCheck, &Pause clipboard history
	 If ClipboardHistoryToggle
		Menu, Tray, Icon, res\cl3.ico
	 else
		Menu, Tray, Icon, res\cl3_clipboard_history_paused.ico
	 ClipboardHistoryToggle:=!ClipboardHistoryToggle
	}
Else If (A_ThisMenuItem = "&AutoReplace Active")
	{
	 If AutoReplace.Settings.Active
		AutoReplace.Settings.Active:=0
	 else
		AutoReplace.Settings.Active:=1
	 XA_Save("AutoReplace", A_ScriptDir "\ClipData\AutoReplace\AutoReplace.xml")
	 Gosub, AutoReplaceMenu
	}
Else If (A_ThisMenuItem = "&FIFO Active")
	{
	 Gosub, FifoActiveMenu
	}
Else If (A_ThisMenuItem = "&settings")
	{
	 Gosub, Settings_menu
	}
Else If (A_ThisMenuItem = "&Usage statistics")
	{
	; s .= Format("|{:-10}|`r`n|{:10}|`r`n", "Left", "Right")
	 show_stats:="CL3 Usage statistics`n___________________________`n"
	 stats_total:=0
	 for k, v in stats
		{
		 if (k = "copieditems")
			continue
		 show_stats .= Format("{:-20}",k) A_Tab v "`n"
		 stats_total += v
		}
	 show_stats.="___________________________`n" Format("{:-20}","Total (pasted)") A_Tab stats_total "`n" Format("{:-20}","Total (copied)") A_Tab stats.copieditems "`n"
	 MsgBox, 64, 	CL3 Usage statistics - %version%, %show_stats%
	}

; Settings menu

Else If (Trim(A_ThisMenuItem) = "Exit")
	ExitApp

Return

SaveSettings:
SetTimer, Backup, Off

;If (A_TimeIdle > BackupTimer*60000) ; no need to backup if there was no input
;	Return

While (History.MaxIndex() > MaxHistory)
	History.remove(History.MaxIndex())

XA_Save("History", A_ScriptDir "\ClipData\History\History.xml") ; put variable name in quotes
XA_Save("stats", A_ScriptDir "\stats.xml")

;XA_Save("Slots", A_ScriptDir "\ClipData\Slots\Slots.xml")
;XA_Save("ClipChainData", A_ScriptDir "\ClipData\ClipChain\ClipChain.xml")
;XA_Save("AutoReplace", A_ScriptDir "\ClipData\AutoReplace\AutoReplace.xml")

If ActivateApi
	ObjRegisterActive(CL3API, "")

Sleep 100

ExitApp

XMLSave(savelist,id="")
	{
	 global
	 local keeplist,objectname,objectfile,ext

	 If !ActivateBackup and (id <> "")
		Return
	 if id
		ext:=".xml.bak"
	 else
		ext:=".xml"

	 Loop, parse, savelist, CSV
		{
		 If (A_LoopField = "stats")
			{
			 XA_Save("stats", A_ScriptDir "\stats.xml")
			 Continue
			}
		 If (A_LoopField = "ClipChainData")
			{
			 objectname:="ClipChainData"
			 objectfile:="ClipChain" id ext
			}
		 else
			{
			 objectname:=A_LoopField
			 objectfile:=A_LoopField id ext
			}
		 If (objectname = "ClipChainData")
			XA_Save(objectname, A_ScriptDir "\ClipData\ClipChain\" objectfile)
		 else
			XA_Save(objectname, A_ScriptDir "\ClipData\" objectname "\" objectfile)
		}

		; keep only the 5 most recent backups
		Loop, parse, % "History,Slots,ClipChain,AutoReplace", CSV
			{
			 keeplist:=""
			 Loop, Files, %A_ScriptDir%\ClipData\%A_LoopField%\*.bak
				keeplist .= A_LoopFileFullPath "`n"
			 Sort, keeplist, RN
			 ;MsgBox, %keeplist% ; debug
			 Loop, parse, keeplist, `n, `r
				{
				 If (A_Index < 6)
					continue
				 FileDelete, %A_LoopField%
				 ;MsgBox, %A_LoopField% ; debug
				}
			}
	}

Backup:
;If (A_TimeIdle > BackupTimer*60000) ; no need to backup if there was no input
;	Return

; XMLSave("History","-" A_Now)
If History_Save
	{
	 ; XA_Save("History", A_ScriptDir "\ClipData\History\History-" A_Now ".xml.bak") ; put variable name in quotes
	 XMLSave("History","-" A_Now)
	 History_Save:=0
	}
Return

#include %A_ScriptDir%\lib\cl3apiclass.ahk

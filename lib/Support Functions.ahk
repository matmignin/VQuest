CheckActive:
  ; Varbar.Follow()
  if winexist("Excel - \\Remote") ;shrink excel 
    WinGet, winminmax, MinMax , Excel - \\Remote,
        if (winminmax=1){
        winactivate, Excel - \\Remote
        send, {lwindown}{down}{lwinup}
        WinMove, Excel - \\Remote, , -178, -1179, 780, 1023
        sleep 300
      }
      ; If Follow 
      ; {
        ; If (Winexist("NuGenesis LMS - \\Remote") || Winactive("Register new samples - \\Remote")) && WinExist("Excel - \\Remote")
          ; WinGetPos, LMS_X, LMS_Y, LMS_W,LMS_H, "NuGenesis LMS - \\Remote"
        ; else
        ; WinGetTitle, WinTitle, A 
        ; VarWin_X := LMS_X+(LMS_W/2)-400
        ; VarWin_Y := LMS_Y
        ; WinMove, VarBar ahk_class AutoHotkeyGUI,, VarWin_X, VarWin_Y,
      ; }
      If A_TimeIdle >1000
        send, {ctrlUp}{altup}
  return





class Breaking {
	Point(){
		Global
		If GetKeyState("Space", "P") || GetKeyState("Esc", "P") || GetKeyState("Lbutton", "P") {	
		TT("Broke")
			exit
		}
		if keep_running = n ;another signal to stop
				Exit
	}
	Preamble(){
		Global
		if keep_running = y
		{
			keep_running = n ;signal other thread to stop
			exit
		}
		keep_running = y
	}
	}
	
	
	CloseWindow(){
	global
	if WinActive("Inbox - mmignin@vitaquest.com - Outlook") ; || winactive("ahk_exe OUTLOOK.EXE")
		Return
	else if winexist("PDF Preview - \\Remote"){
		winactivate
		clk(944, 11)
		sleep 400
	}
	else if winactive("Results Definition - \\Remote"){
    send, {esc}
    return
	}
	; else if winactive("Composition - \\Remote"){
    ; 	clk(841, 895)
    ; 	sleep 50
    ; 	clk(946, 896)
    ; 	sleep 400
    ; }
	else If winactive("NuGenesis LMS - \\Remote")
		LMS.FilterClear()
	else if WinActive("ahk_exe firefox.exe") || winactive("ahk_exe msedge.exe") || winactive("ahk_exe Code.exe") {
		send, ^{w}
		sleep 400
		return
	}
	else if WinActive("ahk_exe explorer.exe") || winactive("ahk_exe OUTLOOK.EXE") || winactive("OneNote for Windows 10") {
		sendinput, !{F4}
		sleep 400
		return
	}
	else if winactive("Settings ahk_class ApplicationFrameWindow"){
		winclose
		sleep 400
		return
	}
	else if winactive("ahk_exe EXCEL.EXE"){
		Send, {ctrldown}{down}{ctrlup}
		sleep 400
		return
	}
	else if winactive("Adobe Acrobat Reader"){
		send, ^q
		sleep 400
	}
	else
		PostMessage, 0x112, 0xF060,,, A     ; ...so close window     
	return
	}
	
	
	
	
ctrlEvent(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:=""){

 ;GuiControlGet, OutputVar , , %CtrlHwnd%,
 IniRead,vOutput, Customers.ini, Customers, %OutputVar%
 msgbox, %vOutput%
}


WindowNames(){
 global
 Loop, Read, WindowNames.ini
 {
  If A_Index = 1
   Continue
  WindowName := StrSplit(A_LoopReadLine, "=")
  ; MethodGroup := StrSplit(A_LoopReadLine, "|")
  Selection:= % WindowName[1]
  ; Group:= % MethodGroup[2]
  Menu, WindowNameMenu, add, %Selection%, WindowNameMenu
 }
 Menu, WindowNameMenu, Show,
return

WindowNameMenu:
 sleep 200
 InputVar:=A_ThisMenuItem
 IniRead,vOutput, WindowNames.ini, WindowNames, %InputVar%
 Sendinput, %vOutput%{enter}
return
}



; ReadSpecIntoDataBase:
;   iniread, full, data.ini, %Product%,ecc738
;   Test_Specs:= strsplit(Full,"=")
;   Test:=Test_Specs[1]
;   Specs:= strsplit(Test_Specs[2],"|")
;   msgbox % "test: " Test "`n`nLabelClaim: " Specs[1] "`nMinLimit: " Specs[2] "`nMaxLimit: " Specs[3] "`nUnits: " Specs[4] "`nPercision: " Specs[5] "`nDescription: " Specs[6] "`nMethod: " Specs[7] "`n" "`nTests: " Tests "`nTest_Specs[2]: " Test_Specs[2]
;   LabelClaim[A_index] "|" MinLimit[A_index]"|" MaxLimit[A_index]"|" Units[A_index]"|" Percision[A_index] "|" Description[A_index] "|" Method[A_index]
;   Return 
  
  
  
  WM_LBUTTONDOWN(wParam, lParam)
			{
				X := lParam & 0xFFFF
				Y := lParam >> 16
				if A_GuiControl
					Ctrl := "`n(in control " . A_GuiControl . ")"
				; ToolTip You left-clicked in Gui window #%A_Gui% at client coordinates %X%x%Y%.%Ctrl%
				PostMessage, 0xA1, 2
		; keywait, Lbutton, U T0.20
			; if !errorlevel
			; {
				; keywait, Lbutton, U T3
					; if errorlevel
						; MouseClick, Left, , , 1, 0, U
						; MouseClick, Left, , , 1, 0, U
				wingetpos, Varbar_X, Varbar_Y,W,H, VarBar ahk_class AutoHotkeyGUI
				; IniWrite, %Varbar_X%, data.ini, Locations, VarBar_X
				; IniWrite, %Varbar_Y%, data.ini, Locations, VarBar_Y
					
		; MouseClick, Left, , , 1, 0, U
				; return
			; }
			; else
		; MouseClick, Left, , , 1, 0, U
					
}


VS_Code_WindowInfo(){
	global
	CoordMode, mouse, window
	MouseGetPos, mX, mY, ,WinControl
	WinGetPos,wX,wY,wW,wH, A
	WinGetTitle, winTitle, A
	WinGetClass, Winclass, A
	WinGet, WinProcess, ProcessName, A
	MousePosition:=mX "`, " mY
	Sleep, 100
	TT(MousePosition "`n Title: " winTitle " `n Process: " WinProcess " `n Control: "winControl " `n Class: " winclass "`nWindowPosition " wX ", " wY ", " wW ", " wH,3000,,,2)
	Process:= "ahk_exe " WinProcess
	WinInfo:="WinMove, " Wintitle ", , " wX ", " wY ", " wW ", " wH
	keywait, F20, U
	keywait, F21, U
	sleep 500
	; Tooltip,
	; SetTimer, RemoveToolTip, -2000
	}

DoublePress(action,SecondAction:="", ToolTip:=""){
	If (A_ThisHotkey=A_PriorHotkey && A_TimeSincePriorHotkey<300){
		send, % action "{shiftup}{altup}{ctrlup}{lwinup}"
		tt(ToolTip)
	}
	Else
		send % SecondAction "{shiftup}{altup}{ctrlup}{lwinup}"
	Return
	}

FlashScreen(){
	send, #^{c}
	sleep 40
	send, #^{c}
	return
	}

TT(msg:="yo", time=1500, X:="",Y:="",W:="", T:="") {
	global
		N=1
	CoordMode, ToolTip, Relative
	If !X
		X:=A_CaretX-50
	If !Y
		Y:=A_CaretY-50
	tooltip, %msg%, %X%, %Y%,%W%
	; hwnd := WinExist("ahk_class tooltips_class32")
	; if T
   	; WinSet, Trans, %T%, % "ahk_id" hwnd
   	; WinSet, TransColor, FFFFFF 200, % "ahk_id" hwnd
	; CoordMode, ToolTip, screen 
	; WinSet, Trans, 200, %W%
	SetTimer, RemoveToolTip%W%, -%time% 
	return
	RemoveToolTip:
		ToolTip
		N=0
	return
	RemoveToolTip1:
		ToolTip,,,,1
		N=0
	return
	RemoveToolTip2:
		ToolTip,,,,2
		N=0
	return
	RemoveToolTip3:
		ToolTip,,,,3
		N=0
	return
	RemoveToolTip4:
		ToolTip,,,,3
		N=0
	return
	}

ReloadScript(){
	TT("`nReload`n ")
	IfWinExist, ahk_exe AutoHotkey.exe Vquest.ahk
		WinActivate,
	sendinput, ^s
	sleep 200
	run, VQuest.ahk
	send,{altup}{CtrlUp}{ShiftUp}{LWinUp}
	}





class click{

	OKay(sleeptime:=""){
		global
		sleep %Sleeptime%
		if winactive("Results Definition")
			clk(1336,592)
		else If WinActive("Result Editor")
			clk(370,660)
		else if Edit Ingredient
			clk(265, 561)
		else if winactive("Result Entry")
			clk(1028, 808)
		else if winActive("Results Definition - \\Remote")
			clk(951, 751)
		else if winActive("Microsoft Excel Security Notice - \\Remote")
			send, !y
		else if winActive("Reason For Change - \\Remote")
			clk(229, 236)
		else if winactive("New Document - \\Remote")
			clk(415, 360)
		else if winActive("Edit specification - \\Remote")
			clk(323, 621)
		else if winActive("Reason for Change - \\Remote")
			Return clk(170, 331)
		else if winexist("Error - \\Remote") {
			winactivate
			clk(148, 104)
			winactivate, Register new samples - \\Remote
			clk(181, 104, 2)
			send, %product%{enter}
		}
		else if winexist("Change Configuration - \\Remote")
			clk(131, 296,"Change Configuration - \\Remote")
		Else
			send,{enter}
		return
	}

	esc(){
		if winexist("Change Configuration - \\Remote")
			click 342, 296
		Else
			send,{esc}
		return
	}

	Save(){
		if winactive("Edit Product")
			click 275, 578
		else If Winactive("Composition")
			click 1236, 888
		else If Winactive("Test Definition Editor ")
			Click 341, 618
		Else
			return
	}
	edit(){
		if winactive("Results Definition")
			click 78,63
		else
			click 84, 65
		return
	}
	Add(){
		if winactive("Formulation")
			click, 73, 280
		else
			click 45, 65
		return
	}
	Requests_tab(){
		click 865,83
		return
	}
	MyWork_Tab(){
		click 761,44
		return
	}
	Mywork_Searchbar(){
		click 500,127, 2
		return
	}
	EditTest_1(){
		ifwinnotactive, NuGenesis LMS - \\Remote
			WinActivate, NuGenesis LMS - \\Remote
		Send,{click, 56, 784 }
		return
	}
	EnterResults(){
		WinActivate, NuGenesis LMS - \\Remote
		WinActivate, NuGenesis LMS - \\Remote
		click 74, 900
		return
	}
	MoveOverTest_1(){
		if winactive("Select Methods Tests")
			Send,{Click}{click 506, 341}
		Else
			return
	}
	Orient(){
		if winactive("Result Entry")
			click 843, 202, 2
		else if winactive("Test Definition Editor")
			Click, 187, 200

		Else
			return
	}
	CopySpecTemplate(){
		WinActivate, NuGenesis LMS - \\Remote
		click 102, 289 ;copy into new spec
		WinWaitActive, Edit specification - Remote, ,1
		if ErrorLevel
			winactivate, Edit specification - Remote
		; click 317, 83
		; sleep 100
		return
	}
	NewSampleTemplate(){
		WinActivate, NuGenesis LMS - \\Remote
		click 103, 325
		return
	}
	
	TestDefinitionEditor_Results(){
		winactivate, Test Definition Editor - \\Remote
		click 236, 246 ;click resulst
		sleep 200
		return
	}
	EditSampleTemplate(){
		WinActivate, NuGenesis LMS - \\Remote
		click 70, 518
		winwaitactive, Edit sample template - \\Remote,, 5
		return
	}
}

Mouse_Save(){
	Global
	MouseGetPos, mx, my, mw,
	MouseReturn:="{click " Mx ", " My ",0}"
	PrevY:=My-26
	NextY:=My+26
	Next:="{click " Mx ", " NextY ",0}"
	Prev:="{click " Mx ", " PrevY ",0}"
	return
}

MakeTransparent(){
Global Iteration, winToggle
; Toggle:=A
	T:=(255/5)*Iteration
	if WinToggle := !WinToggle
		WinSet, Transparent, %T%, A
	else {
			WinSet, TransColor, Off, A
		WinSet, Transparent, Off, A
	}
Return
}

MouseIsOver(WinTitle){
	Global
	MouseGetPos,,, Win
	Return WinExist(WinTitle . " ahk_id " . Win)
}

Mouse_RbuttonUP(){
	#inputlevel 1
	suspend, On
	sleep 50
	; send,{AppsKey}
	Click, Right
	; send,{rbutton}
	; sleep 200
	; MouseClick, Right,,,1, 0, U
	; sendinput,{esc}
	suspend, Off
	#inputlevel 0
	return
}

Clk(x,y,Button:="Left",n=1,window:="",returnMouse:=1){
	global
	; mx:=
	; my:=
	; mw:=
	MouseGetPos, mx, my, mw,
	MouseReturn:="{click " Mx ", " My ",0}"	
	; sleep 25
	if (window!="")
		winactivate, %window%
	mouseclick, %Button%, %x%,%y%,%n%,0
	sleep 25
	if (window!="")
		winactivate, %mw%
	If (ReturnMouse=0)	
		Return MouseReturn
	else
		mousemove,%mx%,%my%,0
	; sleep 50
	;  return, {Click, %x%,%y%,}
}

Mouse_Click(Link){
	global
	Mouse_Save()
	if Link contains Save_ProductTab.EditProduct
		click 275, 578
	else If link contains Results_Definition_edit
		click 78,63
	else If link contains Result_Editor_Ok
		click 370,660
	else If link contains Results_Definition_ok
		click 1336,592
	else If link contains Requests_tab
		click 865,83
	else If link contains MyWork_Tab
		click 761,44
	else If link contains Mywork_Searchbar
		click 500,127, 2
	else if Link contains Save_Composition
		click 1236, 888
	else if Link contains Save_Composition
		click
	else if Link Contains OK_ProductTab.EditIngredient
		click 265, 561
	else if Link contains OK_ResultEntry
		click, 1028, 808
	else if Link contains Orient_ResultEntry
		click 843, 202, 2
	else if Link contains main_enter_results
		click 74, 776
	else if Link contains ScrollDown_EditFormulation
		click 453, 444
	else if Link contains Dropdown_ProductTab.EditIngredient
		click 272, 67
	else if Link contains SearchBar_SelectMethodsTests
		click 225, 69, 2
	else if Link contains MoveOverTest_SelectMethodsTests
		Send,{Click}{click 506, 341}
	else if Link contains Add
		click 45, 65
	else if Link contains Edit
		click 84, 65
	else if Link Contains Main_EditTest
		Sendinput,{click, 56, 784 }
	else if Link Contains Add_Formulation
		click, 73, 280
	else if Link contains AddNewSampleTemplate
		click 103, 325
	else if Link contains Orient_SpecTab.TestDefinitionEditor
		Click, 187, 200
	else if Link contains Save_SpecTab.TestDefinitionEditor
		Click 341, 618
	else if Link contains Select_TestsForRequests
	{
		sendinput,{Click 500, 340}{click, 845, 658}
		winwaitactive, Edit request - \\Remote, ,3
		sendinput,{tab}{enter}
	}
	else if Link Contains Products_Tab
		Sendinput,{click, 550, 35}{tab}%Product%+{Tab 7}
	else if Link contains SearchBar_Product
	{
		if winactive("Select methods tests - \\Remote")
		{
			click, 246,77, 2
			return
		}
		else If WinActive("NuGenesis LMS - \\Remote")
		{
			;click 366, 44
			;sleep 300
			click 518, 89, 2
			sendinput, %Product%
			sleep 200
			send,{enter}
		}
		return
	}
	else if Link contains SearchBar_Batch
	{
		if winactive("Select methods tests - \\Remote")
		{
			click, 246,77, 2
			return
		}
		else If WinActive("NuGenesis LMS - \\Remote")
		{
			click 783, 45
			sleep 400
			click 487, 125, 2
			sendinput, %Batch%
			sleep 200
			send,{enter}
			winwaitactive, Warning - \\Remote, ,2
			if errorlevel
				return
			else
				sendinput,{esc}
			return
		}
		Return
	}
	else
		msgbox, yo
	send, %mouseReturn%
	return
}

; #if WinExist("Login - \\Remote") || Winexist("Sign :") || winexist("Windows Security") || winexist("CredentialUIBroker.exe")
;  Mbutton::Sendpassword()
; #if

SendPassword(){
	if winactive("Remote Desktop")
		sendinput, mmignin{tab}{K}ilgore7744{enter}
	; sendinput, ?+{K}ilgore7744{enter}
	if WinExist("ahk_exe ONENOTE.EXE Protected Section"){
		winactivate
		sendinput, {K}ilgore7744{enter}
	}
	if WinExist("Login - \\Remote"){
		winactivate
		sendinput, mmignin{tab}{K}ilgore7744{enter}
	}
	Else If Winexist("Sign :"){
		winactivate,
		sendinput,{tab 2}{right 2}{tab 2}mmignin{tab}Kilgore7744{enter}
	}
	else if winexist("Windows Security"){
		winactivate,
		sendinput, Kilgore7744{enter}
	}
	else if winexist("CredentialUIBroker.exe"){
		winactivate,
		sendinput, Kilgore7744{enter}
	}
	else
		sendinput, +{K}ilgore7744{enter}
	return
}

CreditCard(){
	sendinput, 4130220009588038
	TT("11/21 127",5000)
	return
}

#IfWinActive



Wheel_Paste()
{
	Global
	BlockInput, on
	if winactive("ahk_exe WFICA32.EXE")
	{
		Clipboard := Trim((Clipboard, "`r`n"))
		sleep 80
		send, %Clipboard%
		; TT("Paste")
	}
	else
	send, {ctrldown}{v}{ctrlup}{altup}{ShiftUp}{LWinUp}
		blockinput off
			sleep 50
	return
}
Wheel_Cut()
{
	global
	PreClip:=ClipboardAll
	clipboard:=
	; sendlevel 2
	Send, {ctrldown}{x}{ctrlup}{altup}{ShiftUp}{LWinUp}

	clipwait, 1
	 TT(clipboard)
	sleep 400
	; sendlevel 0
;   send,{altup}{CtrlUp}{ShiftUp}{LWinUp}
	return
}
Wheel_Copy()
{
	global
		PreClip:=ClipboardAll
		clipboard:=
	; sendlevel 2
	Send, {ctrldown}{c}{ctrlup}{altup}{ShiftUp}{LWinUp}
	clipwait, 1
	; sleep 100
	; sendlevel 0
	; TT(clipboard)
	sleep 50
;   send,{altup}{CtrlUp}{ShiftUp}{LWinUp}
	return
}
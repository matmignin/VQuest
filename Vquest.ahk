﻿gosub, vquest_start

StartTest(){
  SetTimer, SmartDocs, 10
  ;  SpecTab_Table()
  ;  Test()
}
  customer:=[]



; SetTimer, CheckActive, 100

return


CheckActive:
  If WinActive("NuGenesis LMS - \\Remote") || Winactive("ahk_exe EXCEL.EXE") || winactive("ahk_exe OUTLOOK.EXE") || winactive("ahk_exe Code.exe") 
  {
    varbar.move()
    return
    }
  Else if WinActive("VarBar ahk_class AutoHotkeyGUI")
    exit
  else
    WinMove, VarBar ahk_class AutoHotkeyGUI,, 1500, 0
  Return

SmartDocs:
    Autofill_SmartDoc()
    
return



Test(n:=0){
  Global
  ; Gosub, TestSpeccopying
  gosub, Test2
  return
}

Test1:
iniread, full, data.ini, %Product%,
Test_Specs:= strsplit(Full,"=")
Test:=Test_Specs[1]
Specs:= strsplit(Test_Specs[2],"|")
msgbox % "test: " Test "`n`nLabelClaim: " Specs[1] "`nMinLimit: " Specs[2] "`nMaxLimit: " Specs[3] "`nUnits: " Specs[4] "`nPercision: " Specs[5] "`nDescription: " Specs[6] "`nMethod: " Specs[7] "`n" "`nTests: " Tests "`nTest_Specs[2]: " Test_Specs[2]

LabelClaim[A_index] "|" MinLimit[A_index]"|" MaxLimit[A_index]"|" Units[A_index]"|" Percision[A_index] "|" Description[A_index] "|" Method[A_index]
Return  


Test2:
Autofill_SmartDoc()
  setwindelay, 450
return

Autofill_SmartDoc(){
  global
  setwindelay, 50
  If Winexist("LMS Actions - \\Remote") {
			WinActivate,
			click 60, 44
      sleep 200
      WinWaitClose, LMS Actions - \\Remote
      return
    }
  else if winexist("Select Iterations - \\Remote"){
    WinActivate, 
      Rotation_GetTable()
    WinWaitClose, Select Iterations - \\Remote
      return
  }
	else If Winexist("New Document - \\Remote") {
    WinActivate,   
    sleep 200                    
		send, {tab 6}{right 5}{tab 4}%Product%{tab 2}{enter}
		sleep 400
		WinActivate, NuGenesis LMS - \\Remote
		sleep 400
		click, 525, 100 ;edit section
		sleep 200			
    return				 
  }
		else If Winexist("Select Product - \\Remote"){
      WinActivate,
		  click 105, 62 ;select Formulation search
		sendinput, %product%{enter 2}
    WinWaitClose, Select Product - \\Remote
    return
    }
    else if winactive("Release: Rotational Testing Schedule - \\Remote")
    autofill()
    else if winactive("Sign : 210421_Rotation_0007 - \\Remote")
      AutoFill()
    else if winactive("Release:"){
      AutoFill()
      SetTimer, SmartDocs, off
      exit
    }  
    else
      return
}


TestSpecCopying:
  ; ToggleFilter_Test()
  ; FilterSearch_Test("Vitamin C","221")
  ; CopyResults_Test()
  ; ParseResultSpecs()
  ;   ; FilterSearch_Test()
  ; 	coordmode, tooltip, Screen
  ;   tooltip, Low: %LowerLimit% `t High: %UpperLimit% `t Unit: %Unit% `t %Precision% `n `t %Requirement%, 1500, 0
  ; ; msgbox, %product% `t %batch% `n %lot%
return

  
ctrlEvent(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")
{
  
  ;GuiControlGet, OutputVar , , %CtrlHwnd%,
  IniRead,vOutput, Customers.ini, Customers, %OutputVar%
msgbox, %vOutput%
}

CopyResults_Test(){
  global
  WinActivate, NuGenesis LMS - \\Remote
    click 57, 750 ; edit results
    WinWaitActive, Results Definition - \\Remote
    click 282, 121 ; click row
      sleep 100
  ; SendLevel, 1
  send, ^c
  sleep 200
  ; clipwait, 1
  if ErrorLevel
    msgbox, yo
  sendlevel,0
  sleep 200
  send, {esc}
}

ParseResultSpecs(){
  global
  ParsedSpecs:=[]
  Loop, parse, Clipboard, `t 
  ParsedSpecs.insert(A_LoopField)
  MinLimit:=Parsedspecs[17]
  MaxLimit:=Parsedspecs[18]
  Precision:=Parsedspecs[19]
  Requirement:=Parsedspecs[20]
  Units:=Parsedspecs[21]
}

ToggleFilter_Test(){
  WinActivate, NuGenesis LMS - \\Remote
  click 489, 836, R
  sendinput, {down 2}{enter}
}

FilterSearch_Test(TestName:="", MethodName:=""){
  WinActivate, NuGenesis LMS - \\Remote
  click 1230, 648 ;click name filterbox
  send, ^a%TestName%{enter}
  click 1067, 647 ; click method ID Filterbox
  send, ^a%MethodName%{enter}{tab 4}
}

return







#IfWinActive,
  Xbutton1 & Xbutton2::wheel("^!{tab}")

Sendlevel 1
  Rbutton & Mbutton::send, {F21}
  Xbutton2 & Xbutton1::sendinput, {CtrlDown}{F21}{CtrlUp}
  Rbutton & F17::F21
 ; F19::Return ;send, {F21}
  Sendlevel 0
  


KEY_DEFAULT:
!f::Open_Firefox()
!v::Open_vsCode()

Return & K::Enter_Product("K")
Return & 0::Enter_Batch()
  Mbutton & WheelDown::^WheelDown
  Mbutton & Wheelup::^WheelUp 
  Mbutton & F17::Wheel_Right()
  Mbutton & F16::Wheel_left()
  Mbutton::Mbutton
  Rbutton & Wheelup::Wheel_cut() 
  Rbutton & Wheeldown::Wheel_paste()
  Rbutton & Xbutton1::Get_WindowInfo()
  Rbutton & F16::Backspace
  Rbutton & Lbutton::Enter
  Rbutton up::Mouse_RbuttonUP()
  Xbutton2 & LButton::Sendinput, +^4 ;screenshot"
  Xbutton2 & RButton::Sendinput, +^3 ;screenshot"
  Xbutton2 & Mbutton::Clip("OCR") 
  Xbutton2 & WheelUp::Wheel(Product)
  Xbutton2 & WheelDown::Wheel(Batch)
  Xbutton2 & wheelleft::Excel.PreviousSheet()
  Xbutton2 & wheelright::Excel.NextSheet()
  Xbutton2 & F17::Excel.NextSheet()
  Xbutton2 & F16::Excel.PreviousSheet()
  ; Xbutton1 & Rbutton::Get_WindowInfo()
  Xbutton2::Clip()
  Xbutton2 & F18::Varbar.reset()
  Xbutton1 & wheelDown::Mouse_CloseWindow()
  F18 & Wheelup::!^tab
  Xbutton1 & Lbutton::Sendinput, #{down}
  
  ; Xbutton1::Menu()
  F18 & Wheeldown::+^!tab
  F18 & Lbutton::sendinput, ^{Click}
  F18 & Rbutton::sendinput, +{Click}
  F18 & Mbutton::^a
  F18 & F17::!tab
  F18 & F16::!+tab

enter::enter
  Xbutton1::Menu()
  ; if (A_TimeSincePriorHotkey != -1 & A_TimeSincePriorHotkey <300)
  ;   cnt +=1
  ; else if (A_TimeSincePriorHotkey > 400)
  ;   cnt :=0
    
  ;   if (cnt==2)
  ;   {
  ; ;  try menu, menu, deleteAll
  ;     Autofill()
  ;     tooltip("Tripple")
  ;   }
  ;   if (cnt == 1)
  ;     Menu()
  ;     RETurn

#If (A_PriorHotKey = "F18" AND A_TimeSincePriorHotkey < 2000) ;____F18____
  f18::ReloadScript()
  Wheelup::test()
  Wheeldown::send, {esc}
  F16::sendinput, {Click 354, 44}
  F17::sendinput, {click, 743, 41}
  Lbutton::sendinput, ^{click}
  Rbutton::sendinput, +{click}
  mbutton::Clip()
  #If
  ; F18::Autofill() ;Tooltip("☩",2000) 
  F18 uP::send, {space}








KEY_Varbar:
  #If Mouse_IsOver("VarBar ahk_class AutoHotkeyGUI") 
  wheelleft::Excel.PreviousSheet()
  wheelRight::excel.Nextsheet()
  WheelUp::Varbar.AddIteration()
  wheeldown::excel.previoussheet()
  F17::Excel.NextSheet()
  F16::excel.previoussheet()
  Rbutton::Excel.connect()
  Mbutton & WheelDown::varbar.Move()
  mbutton::
    if WinExist("Result Editor - \\Remote") || WinExist("Test Definition Editor - \\Remote") || winexist("Results Definition - \\Remote")
      SpecTab_Table()
    else
      ProductTab_Table()
  return
  #if
  
  
  
  Methods() {
  global
  ; Mouse_Click("searchBar_SelectMethodsTest")
  WinActivate, Select methods tests - \\Remote
  click, 229, 72,2
  send, ^a
  Loop, Read, Methods.ini
{
  If A_Index = 1
    Continue
  Method := StrSplit(A_LoopReadLine, "=") 
  ; MethodGroup := StrSplit(A_LoopReadLine, "|") 
  Selection:= % Method[1]
  ; Group:= % MethodGroup[2]
  Menu, Methodmenu, add, %Selection%, Methods
}
   Menu, MethodMenu, Show,
return

Methods:
sleep 200
InputVar:=A_ThisMenuItem
  IniRead,vOutput, Methods.ini, Methods, %InputVar%
  Sendinput, %vOutput%{enter}
   sleep 300
   click 506, 341
   Methods() 
return
}	
  
  
  
;___________________________________________________________________________
KEY_LMS:
  #Ifwinactive, NuGenesis LMS - \\Remote 
  F20::Mouse_Click("SearchBar_Batch") 
  Xbutton1 & WheelRight:: sendinput, {click, 743, 41}
  Xbutton1 & WheelLeft::sendinput, {Click 354, 44}
  F17::click 78, 750
    F18::autofill()
  Xbutton1 & WheelUp::Test()
  Xbutton1 & wheeldown::Varbar.SubIteration()
  Xbutton2 & WheelUp::SearchBar(Product)
  Xbutton2 & WheelDown::SearchBar(Batch)
  Mbutton::Excel.Connect()
  Enter::Sendinput, ^a^c{enter}
  #IfWinActive
  ;select methods
  #Ifwinactive, Select methods tests - \\Remote
  F19 & space::AutoFill()
  F17::Methods()
#IfWinActive, Results Definition - \\Remote
wheelup::Mouse_click("Edit")
WheelDown::wheel("{esc}")

#ifwinactive, Edit test (Field Configuration:
  F16::Autofill()
#Ifwinactive, Result Entry - \\Remote  ;Enter Test Results window
  Xbutton2::WorkTab_ChangeTestResults("toggle")	
  F16::WorkTab_ChangeTestResults("toggle")
  F17::WorkTab_ChangeTestResults()
  
#ifwinactive, Register new samples - \\Remote
  Xbutton2 & wheelup::sendinput, {click 180, 103, 2}%Product%{enter}
  F18::Autofill(1)

#IfWinActive, ahk_exe WFICA32.EXE, ;GENERIC LMS
  Xbutton1 & WheelUp::Varbar.AddIteration()
  Xbutton1 & wheeldown::Varbar.SubIteration()
  browser_Forward::Excel.NextSheet()
  browser_Back::Excel.PreviousSheet()
  ; Xbutton2 & F17::Excel.NextSheet()
  ; Xbutton2 & F16::Excel.PreviousSheet()
  Mbutton::AutoFill()
  F18::autofill()
  Xbutton2 & WheelUp::Wheel(Product)
  Xbutton2 & WheelDown::Wheel(Batch)

#IfWinActive, Enter Product Number ahk_class #32770
  m::1
  ,::2
  .::3
  j::4
  k::5
  l::6
  u::7
  i::8
  o::9
  `;::0
  F19::0
  h::-





KEY_Excel:
  #IfWinActive, LMS Workbook.xlsm
  F18::Excel.Connect(1)
  MButton::Excel.Connect(1)
  #ifwinactive, ahk_exe EXCEL.EXE
  +Enter::sendinput, !{enter}
  $Enter::sendinput, {enter}
  F18::Excel.Search()
  Mbutton::Excel.Connect(1)
  F16::wheel("{wheelleft}",80)
  F17::wheel("{wheelRight}",80)
  
  Xbutton1 & F17::^PgDN ;Excel.NextSheet()
  Xbutton1 & F16::^PgUp ;Excel.PreviousSheet()
  #ifwinactive, Find and Replace,
  Xbutton2 & WheelUp::
  Wheel("{alt down}n{alt up}")
  Sendinput, %Product%
  return
  Xbutton2 & WheelDown::
 ; Wheel("{alt down}n{alt up}")
  Sendinput % Batch
  return
  return::sendinput, !i
  rbutton & Lbutton::sendinput, !i

#IfWinActive, ahk_exe explorer.exe
Mbutton::Open_in_Notepad()
  Xbutton1 & F17::Excel.NextSheet()
  Xbutton1 & F16::Excel.PreviousSheet()
#IfWinActive, C:\Users\mmignin\Desktop\Label Copy\All Label Copy ahk_exe explorer.exe
Xbutton2 & Wheelup::
winactivate, C:\Users\mmignin\Desktop\Label Copy\All Label Copy ahk_exe explorer.exe
send, ^e
sleep 60
sendinput, %Product%{enter}
sleep 300

return
KEY_OUTLOOK:
  #IfWinActive, ahk_exe OUTLOOK.EXE 
  Mbutton::SENDINPUT % Varbar.Sendinput("Batch") " is updated"
  Rbutton & Wheelup::Wheel("{ctrl down}x{ctrl up}")
  Rbutton & wheeldown::Wheel("{ctrl down}v{ctrl up}")
  Rbutton & F17::Varbar.Sendinput("Batch"," is updated.")
  Xbutton1 & WheelDown::varbar.search("batch")
  Xbutton1 & Wheelup::varbar.search("Product")
  Xbutton2::Clip()
  F19 & Space::Varbar.Sendinput("Product")
  F20 & Space::Varbar.Sendinput("batch")
  F18::LMS_Search()

KEY_Browser:
  #IfWinActive, ahk_exe firefox.exe
  Xbutton1 & WheelDown::Wheel("^w")
  F16::sendinput, !{left}
  Xbutton2 & WheelDOWN::Browser_Back
  F17::!right
  Xbutton1 & wheelUP::Browser_Forward
  Mbutton::Mbutton ;sendinput, ^{click}

KEY_Snipper: 
  #IfWinActive, Snipper - Snipaste ; the capture screen
  rbutton::send, ^c
  WheelDown::wheel("^1")
  Wheelup::Wheel("^5")
  Mbutton::excel.PasteValues("snip")
  #IfWinActive, Paster - Snipaste ahk_exe Snipaste.exe ; the floating window
  Mbutton & wheelUp::Wheel("{click right}z1{click right}e{ctrl down}5{ctrl up}")
  Mbutton::send, {esc}
  Xbutton2::sendinput, ^c
  F17::sendinput, ^+{+}
  F16::sendinput, ^+{-}
  #If mouse_isover("Paster - Snipaste ahk_class Qt5QWindowToolSaveBits")
  sendlevel 1
  Mbutton::send, !{click}
  #if

Scroll_Fix:
  #if winactive("Result Editor - \\Remote") || winactive("Test Definition Editor - \\Remote")
  wheeldown::Wheel_scroll("100")
  wheelup::Wheel_scroll("-100")
    ; #ifwinactive, Test Definition Editor - \\Remote
  ; wheeldown::Wheel_scroll("100")
  ; wheelup::Wheel_scroll("-100"
  #if
ClipTool:
#IfWinactive, C:\Users\mmignin\Documents\VQuest\lib\CL3\cl3.ahk - AutoHotkey v1.1.33.06,
  F19::send, {esc}
  F19 & j::send, {down}
  F19 & k::send, {up}
  F19 & l::send, {enter}
  F19 & h::send, {esc}
  Capslock & j::send, {down}
  Capslock & k::send, {up}
  capslock & l::send, {enter}
  capslock & h::send, {esc}
  capslock::esc
  #IfWinActive

#If (A_PriorHotKey = "Browser_forward" AND A_TimeSincePriorHotkey < 1000)
  browser_forward::Send, !{tab}{space}
  browser_back::send, +!{tab}{space}
  media_Next::Mouse_CloseWindow()
  #if

KEY_Otherstuff:
  Media_Play_Pause::^+4 ;4finger tap
  Media_Prev::F7 ;3fringer down
  ; Media_Next:: ;3finger up
  Browser_Back::+!tab ;3finger left
  Browser_Forward::^!tab

  Volume_Down::F11
  Volume_Up::F12
  #right::tooltip(A_ThisHotkey)
  ^+!down::tooltip(A_ThisHotkey)
  CapsLock::return
  F20 & Right::send, #{right}
  F20 & Left::send, #{Left}
  F20 & UP::send, #{UP}
  F20 & Down::send, #{Down}
  F20::AutoFill()
  
#If (A_PriorHotKey = "Media_next" AND A_TimeSincePriorHotkey < 1000)
    Browser_forward::#right
    Browser_back::#left
    Media_Next::sendinput, #{up}
    Wheelup::tooltip(A_ThisHotkey)
    Wheeldown::tooltip(A_ThisHotkey)
    wheelleft::tooltip(A_ThisHotkey)
    wheelright::tooltip(A_ThisHotkey)
    Lbutton::tooltip(A_ThisHotkey)
    Rbutton::tooltip(A_ThisHotkey)
    mbutton::tooltip(A_ThisHotkey)
    #If
  Media_next::Tooltip("Swipe",2000) 
  
#If WinActive("ahk_exe Code.exe") && Getkeystate("Capslock","p") ;editor
    ,::sendinput, +!/
    m::+!down
    n::+!n
    u::+!up
    '::+^!n
    .::+F1
    up::^+up
    down::^+down
    /::sendinput, !^w
    5::^+/




open_Firefox(){
  ifwinnotexist, ahk_exe firefox.exe
    run, firefox.exe, "C:\Program Files\Mozilla Firefox\" 
  else 
    WinActivate, ahk_exe firefox.exe

  return
}

open_VScode(){
  ifwinnotexist,ahk_exe Code.exe
    run, Code.exe, "C:\Program Files\Microsoft VS Code\" 
  else 
    WinActivate, ahk_exe Code.exe

  return
}

  Open_in_Notepad(){
    click
    WinGetClass class, % " ahk_id " WinExist("A")
    for Window in ComObjCreate("Shell.Application").Windows 
      Selection := Window.Document.SelectedItems
    for Items in Selection
      Path_to_Selection := Items.path		
    Run C:\Windows\system32\Notepad.exe %Path_to_Selection%
  }

  Snip_groupChange(){
    Wheel("{ctrl down}22{Ctrl up}")
    tooltip("Snip Group Changed",2000)
  return
}
Enter_Batch(){
  global
  ;inputbox, Batch,Enter Batch Number, %key%- ,,,,%varbar_x%,%Varbar_y%,,Default
  WinActivate, ahk_class Transparent Windows Client ahk_exe WFICA32.EXE
  ;inputbox, Code,Enter Product Number, %key% `t ,,,,%varbar_x%,%Varbar_y%,,Default
  click 755, 480
  sleep 100
  ;click 1131, 80
  click 487, 130, 2 ;click search bar
  sendlevel, 1
  sendinput, {F19}
  sendlevel, 0
  Input, CodeA, V L3 T5, -
  if !ErrorLevel
  sendinput, -
  Input, CodeB, V L4 T5, {enter}
  if !ErrorLevel
  send, {enter}
  Batch:=CodeA . "-" . CodeB
  GuiControl, Varbar:Text, Batch, %Batch% 
  tooltip(Batch)
  return
}

Enter_Product(key){
  Global
  WinActivate, ahk_class Transparent Windows Client ahk_exe WFICA32.EXE
  ;inputbox, Code,Enter Product Number, %key% `t ,,,,%varbar_x%,%Varbar_y%,,Default
  click 755, 480
  sleep 100
  ;click 1131, 80
  click 487, 130, 2 ;click search bar
  sendinput, %Key%
  sendlevel, 1
  sendinput, {F19}
  sendlevel, 0
  Input, Code, V L3 T5, {enter}
    if !ErrorLevel
  send, {enter}
  Product:=Key Code
	GuiControl, Varbar:Text, Product, %Product% 
  tooltip(Product)
  return
} 

LMS_Search(){
  clipboard:=""
  send, ^c
  sleep 200
  ;ClipWait, 1,
  Clipboard := Trim((Clipboard, "`r`n"))
  WinActivate, NuGenesis LMS - \\Remote
  click 783, 45
  sleep 400
SearchBar(Clipboard)
  ; click, 500,127, 2 ;click search bar
  sleep 200
  ; Send, %clipboard%{enter}
  return
}

StopSub: 
exitapp
Return
VarBar_ResetSub:
  VarBar.Reset()
return
Run_Display:
  run, Display.url, C:\Users\mmignin\Desktop\
Run_CL3:
  Run, cl3.Ahk, lib\CL3
return
run_VIM:
  Run, ViM.Ahk
return
#IfWinActive,
WindowSpySub: 
Run, WindowSpy.ahk,C:\Program Files\AutoHotkey\

#Include <AutoFill>
#include <varBar>
#include <ProductTab>
#include <WorkTab>
#include <SpecTab>
#include <Rotation>
#include <Excel>
#include <vis2>
#include <SearchBar>
#include <wheel>
#include <VScode>
#include <mouse>
VQuest_Start:
  #Persistent 
  #NoEnv
  #SingleInstance,Force
  #KeyHistory 100
  SetWorkingDir, %A_ScriptDir%
  Menu, Tray, Add,CL3, Run_cl3
  menu, tray, add, Display settings, Run_display
  Menu, Tray, Add, Vim, Run_Vim
  Menu, Tray, Add, Stop, StopSub
  Menu, Tray, Add, windowSpy, WindowSpySub 
  Menu, Tray, Add, ResetVarbar, Varbar_ResetSub
  Menu, Tray, Default, ResetVarbar
  SetBatchLines, 10ms
  Setnumlockstate Alwayson
  setCapslockstate alwaysoff
  SetscrolllockState, alwaysOff
  	CoordMode, mouse, window
  SetDefaultMouseSpeed, 0
  ; detecthiddenwindows, on

  SetTitleMatchMode, 2
  ; settitlematchmode, slow
  #MaxHotkeysPerInterval 200
  #HotkeyModifierTimeout 10
  #maxthreadsperhotkey, 1
  SetKeyDelay, 2, 1
  setwindelay, 450
  ; AutoTrim, On
  Menu, Tray, Icon, Robot.ico
Results_Definition_edit:="78,63"
Result_Editor_Ok:="370,660"
Results_Definition_ok:="1336,592"
Requests_tab:="865,83"
MyWork_Tab:="761,44"
Mywork_Searchbar:="500,127,2"
  Iniread, Iteration, data.ini, SavedVariables, Iteration
  Iniread, VarBar_X, data.ini, Locations, VarBar_x
  Iniread, VarBar_Y, data.ini, Locations, VarBar_Y
  Excel.Connect(1)
  StartTest()
  



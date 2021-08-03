#Ifwinactive,

KEY_DEFAULT:
	F15::								menu.Apps()
	F17::								MouseClip()
	Media_Next::					send, {shiftdown}{altdown}{tab}{altup}{shiftup}
	Media_Prev::					send, {altdown}{tab}{altup}`
	Media_Play_Pause:: 			send, {ctrldown}{altdown}{tab}{altup}{ctrlup}
	Volume_Down::					send, {lwindown}{tab}{lwinup}
	F16::								send, !{tab}
	$#F7::							send, {lwindown}{right}{lwinup}
	$#F6::							send, {lwindown}{left}{lwinup}
	$#F9::							send, {lwindown}{up}{lwinup}
	$#F8::							send, {lwindown}{down}{lwinup}
	$!F7::							send, {laltdown}{right}{laltup}
	$!F6::							send, {laltdown}{left}{laltup}
	$!F9::							send, {laltdown}{up}{laltup}
	$!F8::							send, {laltdown}{down}{laltup}
	Xbutton2 & Wheelup::			Gosub, F9
	Xbutton2 & Wheeldown::		Gosub, F8
	Xbutton2 & Wheelleft::		Gosub, F6
	Xbutton2 & Wheelright::		Gosub, F7
	Xbutton1 & Wheelup::			Gosub, NumpadMult
	Xbutton1 & Wheeldown::		Gosub, NumpadDiv
	Xbutton1 & Wheelleft::		Gosub, Numpadsub
	Xbutton1 & Wheelright::		Gosub, Numpadadd
	Xbutton1::						clip_C()
	Xbutton2::						Numlock
	+Backspace::					backspace
	+^z::								send, {shiftup}{Ctrldown}{y}{CtrlUp}
	~<+rshift::						alttab
	~>+lshift::						ShiftAltTab
	lshift & Appskey::			Return
	rshift & Appskey::			return
	<^;::	 							sendinput, %Timestring%{space}
	~Lbutton & left:: 			sendinput, %SampleID%
	~Lbutton & Down:: 			sendinput, %Coated%
	~Lbutton & right::			sendinput, %Lot%
	~Lbutton & up::	 			sendinput, %SampleID%

	/ & Down::						send, %Coated%
	/ & .::							send, {?}
	/ & right::	 					send, %Lot%
	/ & up::							send, %SampleID%
	/::	 							send, /
	` & Del::						Test(Iteration)
	` & 1::							Test_1()
	` & 2::							Test_2()
	` & 3::							Test_3()
	`::	 							sendraw, ``
	~>+lbutton::					send,{shiftDown}{click}{shiftup}
	F19 & up::						send, %SampleID%
	F19 & left::					send, %lot%
	F19 & right::					send, %coated%
	F19 & s::	 					send, %SampleID%
	
	
#if MouseClip
	sendlevel 2
	; ~Lbutton::
	; 									ClickClip()
	; 									; ControlsetText, Static1,%Clipboard%,VarBar
	; 									StrReplace(clipboard, "`n`r", "")
	; 									sleep 100
	; 									; TT(Clipboard,4000,1,1,3,100)
	; 									return	
	Mbutton::
										clip()
										GuiControl,Varbar:Text, Clipboard, %Clipboard%
										return
	$Numlock::	        	
										StrReplace(clipboard, "`n", "")
										send, {ctrldown}{v}{ctrlup}
										return
	#if
		Mbutton::					TrackPad.3Tap() ;	TMbutton() ;	ClipPaste()
		; Mbutton::								TrackPad.3Tap() ;	TMbutton() ;	ClipPaste()
	  ; Numlock::
		; 	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 300)
		; 		Send, {ctrldown}{x}{ctrlup}
		; 	else
		; 		ClipPaste()
		; 	return
	sendlevel 0

	; Media_Play_Pause::			
	; 	send, ^{c}
	; 	winactivate, screencaps
	; 	sleep 200
	; 	send, {down}{enter}^{v}
	; 	return

	<^Space::             	varbar.focus("Note1")

F19_And_F20:
	F20 & 9::             	SaveWindow_Save()
	F21 & 9::             	SaveWindow_Save()
	F20 & 0::             	SavedWindow_Restore()
	F21 & 0::             	SavedWindow_Restore()
	; F20 & '::           	varbar.follow()
	F13 & esc::					Varbar.reset()	
	; F21 & '::					Varbar.reset()	
	F19 & \::             	CreditCard()
	F19 & Space::         	send, %product%
	F20 & Space::         	Sendinput, %batch%
	F21 & Space::         	Sendinput, %batch%
	F19 & backspace::     	send,{delete}
	F20 & Insert::        	Clip("OCR")
	F20 & Media_Play_Pause::Clip("OCR")
	F21 & Insert::        	Clip("OCR")
	F20 & F7::            	Excel.NextSheet()
	F21 & F7::            	Excel.NextSheet()
	F20 & F6::            	Excel.PrevSheet()
	F21 & F6::            	Excel.PrevSheet()
	F20 & backspace::     	run, Taskmgr.exe
	F21 & backspace::     	run, Taskmgr.exe
	F20 & Right::         	send, #{right}
	F21 & Right::         	send, #{right}
	F20 & Left::          	send, #{Left}
	F21 & Left::          	send, #{Left}
	F20 & UP::            	send, #{UP}
	F21 & UP::            	send, #{UP}
	F20 & Down::          	send, #{Down}
	F21 & Down::          	send, #{Down}
	F20 & \::             	Sendpassword()
	F21 & \::             	Sendpassword()
	F20 & .::             	VS_Code_WindowInfo()
	F21 & .::             	VS_Code_WindowInfo()
	F20 & o:: 				 	OpenApp.Outlook()
	F21 & o::				 	OpenApp.Outlook()
	F20 & =::             	sendinput,{CtrlDown}{=}{Ctrlup}
	F21 & =::             	sendinput,{CtrlDown}{=}{Ctrlup}
	F20 & -::             	sendinput,{CtrlDown}{-}{Ctrlup}
	F21 & -::             	sendinput,{CtrlDown}{-}{Ctrlup}
	F20 & Rshift::        	Test_2() 
	F21 & Rshift::        	Test_2() 
	F19 & enter::			 	varbar.focus("Edit1")
	F20 & enter::			 	varbar.focus("Edit2")
	F21 & enter::			 	varbar.focus("Edit2")
	F20 & ,::					varbar.Focus("Edit2")


	F20 & l::             	OpenApp.LMS()
	F21 & l::             	OpenApp.LMS()
	F20 & F19::           	send, {F22}
	F21 & F19::           	send, {F22}
	F19 & lbutton::       	^Lbutton
	F20::                 	Clip_C()
	F20 & F21::           	send, {F21}
	F21::                 	Clip_C()
	F19 up::              	Clip_V()
	F19 & Media_Play_pause::
									my_screenwidth:=A_ScreenWidth-215
									my_screenheight:=A_Screenheight-115
									IniWrite, %my_screenwidth%, data.ini, Locations, Notes_x
									IniWrite, %my_screenheight%, data.ini, Locations, Notes_y
									Return
	
	F13 & Lbutton::       	F13Click()














Double_press_For_Enter:
#If (A_PriorHotKey = "F19 & Space" || A_PriorHotKey = "F21 & Space" || A_PriorHotKey = "F20 & Space") && (A_TimeSincePriorHotkey < 5000) 
	F19 & space::           send, {enter}
	; $space::              send, {enter} 
	$rshift::               send, {tab}
	F20 & Space::           send, {enter}
	F21 & Space::           send, {enter}

#If (A_PriorhotKey = "F19" || A_PriorHotKey = "F20" || A_PriorHotKey = "F21 & Space") && (A_TimeSincePriorHotkey < 5000) 
	$rshift::								send, {tab}
	$space::								send, {enter}
#if 

#If (A_PriorhotKey = "lbutton" && A_TimeSincePriorhotkey < 300) 
	~lbutton::
		sleep 200
		if getkeystate(lbutton, "P")
			tt("ye")
			return
#If getkeystate("lbutton","p") || (A_PriorhotKey = "lbutton" && A_TimeSincePriorhotkey < 800) 
  space::             send, {ctrldown}{click}{ctrlup}
  F19::               send, {F21}
  .::                 VS_Code_WindowInfo()
  v::                 send, {shiftdown}{altdown}{ctrldown}{v}{ctrlup}{altup}{shiftup}
  F20::               send, {shiftdown}{ctrldown}{4}{ctrlup}{shiftup}
  e::                 send,{LWinDown}{e}{lwinup}
  o::                 OpenApp.Outlook()
  d::                 LMS.Orient()
  w::                 OpenApp.Workbook()
#If
numpadsub::           #left
numpadadd::           #right
numpadMult::          #up
numpaddiv::           #down
	pause::                           reload
	` & esc::                         Pause




class TrackPad {
	3Right(){
		global
		If winactive("NuGenesis LMS - \\Remote")
			LMS.SearchBar(Batch,"{enter}")
		else If winactive("Result Entry - \\Remote")
			WorkTab.ChangeTestResults()
		else If winactive("Select methods tests - \\Remote")
			SpecTab.Methods()
		else If WinActive("Composition - \\Remote")
			send, {enter}
		else If WinActive("Test Definition Editor - \\Remote")
			clk(330, 619) ;click save
		else If WinActive("Results Definition - \\Remote")
			send, {enter}
		else if winactive("Register new samples - \\Remote")
			clk(502, 354)
		else if winactive("Select samples for test:")
			send % Clk(504, 324) "{click, 849, 661}"  ; add test.
		else	
			send, {WheelRight}
		return
	}

	3left(){
			global
		If winactive("NuGenesis LMS - \\Remote")
			LMS.SearchBar(Product,"{enter}")
		else If winactive("Select methods tests - \\Remote")
			send, {esc}
		else If WinActive("Composition - \\Remote")
			send, {esc}
		else If WinActive("Test Definition Editor - \\Remote")
			send, {esc}
		else If WinActive("Results Definition - \\Remote")
			send, {esc}
		else if winactive("Edit test (Field Configuration:")
			send, {esc}
		else If winactive("Result Entry - \\Remote")  ;Enter Test Results window"
			WorkTab.ChangeTestResults("toggle")
		else if winactive("Register new samples - \\Remote")
			send, {esc}
		else if winactive("Select samples for test:")
			send, {esc}
		else 
			send, {wheelleft}
		return
		}


	3Down(){
		global
		If winactive("NuGenesis LMS - \\Remote")
			LMS.Filter(Clear)
		else if winactive("Select samples for test:")
			Clk(853, 657) ; click okay.
		else
			return
		return
	}


	3up(){
		global
		If winactive("NuGenesis LMS - \\Remote")
			LMS.DetectTab()
				if (Tab="Requests"){
					click, 2
					sleep 200
					Autofill()
					return
				}
				else if (Tab="Products")
					LMS.ViewCoa()
		else if winactive("Edit test (Field Configuration:")
			Autofill()
		else if winactive("Register new samples - \\Remote")
			LMS.SearchBar(Product,"{enter}")
		else If WinActive("Select tests for request: R")
			clk(638, 70)
		else if winactive("Select samples for test:")
			send % Clk(250, 70) "{up}" ; click okay.
		else If WinActive("Composition - \\Remote")
			ProductTab.AddCOASpace()
		else
			return
		return
		
		}


	3tap(){
	Global 
		; if MousePaste
		; 	; ClipPaste()
		; else if !MousePaste {
			If winactive("NuGenesis LMS - \\Remote") 
			 Menu.Lms()

			else if Winactive("Login - \\Remote") || Winexist("Sign :") || winexist("Windows Security") || winexist("CredentialUIBroker.exe")
			 	Sendpassword()
			else if winactive("ahk_exe firefox.exe")
				send, {ctrldown}{click}{ctrlup}
			else If WinActive("LMS Workbook.xlsb")
					clip_C()
			else if winactive("Edit Formulation - \\Remote") {
				mouseclick, left, 455, 472,2,0
				clk(250, 284)
			} else if Winactive("Register new samples - \\Remote"){
					WorkTab.registerNewSamples()
			} else if winactive("Edit Product - \\Remote") {
				ProductTab.EditProduct() 
			} else If WinActive("Select tests for request: R") {
				WorkTab.SelectTestSample() 
			} else If WinActive("Paster - Snipaste") || WINACTIVE("Snipper - Snipaste") {
				; sendlevel 1
					send, {ctrldown}{7}{ctrlup}
				; sendlevel 0
			} Else 
				Autofill()
			return
		; }
		}


	4tap(){
		global
				if ClipPaste = 1
			ClipPaste()
		else if (ClipPaste=0) {
			If winactive("NuGenesis LMS - \\Remote") {
				LMS.Detecttab()
				if (Tab="Requests")
					{
					click
					clk(61, 635) ;enter results
					Return
					}
				else if (Tab="Samples")
					{
					clk(83, 753) ;Show Requests
					Return
					}
				else if (Tab="Products")
					{
					clk(86, 443) ;edit composition
					Return
					}
				else if (Tab="Specs")
					{
					click
					clk(67, 754) ;edit results
					Return
					}
				else
					Menu.LMS()
			}
			Else
				Autofill()
		}
		return
		}



	2right(){
		global
		If winactive("NuGenesis LMS - \\Remote") {
		lms.DetectTab()
			if (Tab="Samples")
				clk(xRequestsTab,yWorkTabs)
			else if (Tab="Requests")
				clk(56, 630)
			else
				lms.SearchBar(Batch,"{enter}")
			sleep 800
		}

		Else
			send, %batch%
		sleep 700
		return
		}


	2Left(){
		global
		If winactive("NuGenesis LMS - \\Remote"){
			lms.DetectTab()
			if (Tab="Requests")
				clk(xSamplesTab,yWorkTabs)
			else If (Tab="Samples")
				clk(70, 395)
		Else
			send, %Product%
		sleep 700
		return
		}
	}
}




K_Main_LMS_Screen:
  #Ifwinactive, NuGenesis LMS - \\Remote
  F20 & Left::WinMove, A, , -283, -1196, 1662, 952
  F21 & Left::WinMove, A, , -283, -1196, 1662, 952
  F19 & F20::lms.searchBar("")
  F19 & F21::lms.searchBar("")
  F19 & space::Send, %Product%{enter}
  F20 & space::Send, %Batch%{enter}
  F21 & space::Send, %Batch%{enter}
  F19 & /::Send, %lot%{enter}
  ~Lbutton & F19::send,{enter}
  Enter::LMS.SaveCode()
  numpaddiv::CloseWindow()
	; space & lbutton::send, +{click}
	; space up::sendinput, ^{click}
	; wheelright::TrackPad.2right()
	; wheelleft::TrackPad.2left()



Results_Definition:
  #IfWinActive, Results Definition - \\Remote
  wheelup::Mouse_click("Edit")
  ; numlock::send, % clk(712, 663) "{esc}"


Register_new_samples:
  #ifwinactive, Register new samples - \\Remote
	F7::
		clk(181, 104,2,2)
		sleep 300
		send, %Product%{enter}
		return

Result_Entry:
  #Ifwinactive, Result Entry - \\Remote ;Enter Test Results window
    #MaxThreadsPerHotkey 2
      F9::WorkTab.ChangeTestResults("loop")
    #MaxThreadsPerHotkey 1 
Other_LMS_KEYS:
	#ifwinactive, Reason for Change - \\Remote
	F13 & v::
						send % "Verification" 
						sleep 200
						Click.Okay()
						return
WFICA32:
  #IfWinActive, ahk_exe WFICA32.EXE, ;GENERIC LMS
	F20 & Space::						send, %Batch%
	F21 & Space::						send, %Batch%
	F19 & space::						send, %Product%
	F19 & up::							send, %sampleID%
	F19 & left::						send, %lot%
	F19 & right::						send, %coated%
	F19 & s::	 						send, %SampleID%
	F21 & /::	 						send, %SampleID%
	$Rbutton up::						Mouse_RbuttonUP()
	^`::										Varbar.reset()
	enter::									click.okay()
	esc::										click.esc()
	; left::						left
	; Down::						down
	; right::						right
	; up::						up
	numpaddiv::			closeWindow()
	<^r::						ReloadScript()
	F9::						TrackPad.3up()
	F8::						TrackPad.3Down()
	F7::						TrackPad.3Right()
	F6::						TrackPad.3Left()	
	; ~alt & tab::clip_C()

	numpadMult::excel.connect()
	numpadadd::Excel.NextSheet()
	numpadsub::Excel.PrevSheet()

	Rbutton & F19::       	send % VS_Code_WindowInfo() 
	Rbutton & F6::        	send, Backspace
	Rbutton & Lbutton::   	send, Enter
	Rbutton::             	Menu.Env() ;send % Mouse_RbuttonUP()


MouseIsOver:
	return
#If Mouse_IsOver("LMS Workbook.xlsb")
	numpadadd::Excel.NextSheet()
	numpadsub::Excel.PrevSheet()
#If Mouse_IsOver("ahk_exe OUTLOOK.EXE")
			Click 3
		clip()
		return
#If Mouse_IsOver("NuGenesis LMS - \\Remote ahk_exe")
	F7::LMS.SearchBar(Batch,"{enter}")
	F6::LMS.SearchBar(Product,"{enter}")
	; Numlock::
	; 	click
	; 	sleep 300
	; 	TrackPad.4tap()
	; 	return
	space & lbutton::send, +{click}
	; space up::sendinput, ^{click}

  #If mouse_isover("Result Editor - \\Remote") || mouse_isover("Test Definition Editor - \\Remote") || mouse_isover("Edit Formulation - \\Remote")
    Wheeldown::LMS.ScrollDown()
  #if











~lbutton::return
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
F13Click(){
  KeyWait, lbutton, T0.25
    If ErrorLevel
    {
       KeyWait, Lbutton, D
        If !ErrorLevel
          send, ^{click 3}
        exit
    }
    send, ^{Click 2}
    return
	}





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








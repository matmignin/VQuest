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
		WinActivate, NuGenedsis LMS - \\Remote
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
	RegisterNewSamples(){
		WinActivate, Register new samples - \\Remote
		click 181, 103, 2
		sleep 50
		; click 181, 103,
		sleep 300
		send, %product%{enter}
		sleep 300
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

Mouse_IsOver(WinTitle){
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



KEY_Varbar:
  #If Mouse_IsOver("VarBar ahk_class AutoHotkeyGUI") 
  wheelleft::Excel.PreviousSheet()
  wheelRight::excel.Nextsheet()
  WheelUp::Varbar.AddIteration()
  Wheeldown::Varbar.SubIteration()
  F7::Excel.NextSheet()
  F6::Excel.previoussheet()
  Mbutton & WheelDown::Varbar.Follow()
  mbutton::Varbar.LaunchTable()
  Xbutton1 & F6::ProductTab_Table()
  Xbutton1 & F7::SpecTab_Table()
  Rbutton::
	Menu.Tables()   ; Excel.connect()
	menu.show()
	return
	F8::ReloadScript()
  ; Lbutton::MouseClick, Right,,,1, 0, U
  #if
  
  








Class VarBar{

Show(X:=1, Y:=1, Destroy:="Reset"){ 
	Global
	try Gui,VarBar:Destroy
	If (X<>0)
	{
		 Iniread, VarBar_X, data.ini, Locations, VarBar_X
		Iniread, VarBar_Y, data.ini, Locations, Varbar_Y	
	}
	If (X=0)
	{
	coordmode, mouse, Screen
	MouseGetPos,MousePos_X,MousePos_Y,w,h
	coordmode, mouse, Window
		Varbar_X:=MousePos_X
		varbar_y:=MousePos_Y-10
	}
	if (Destroy:="Reset")
		GUI, VarBar:destroy
	Gui Varbar:Default
	Gui VarBar: +LastFound +AlwaysOnTop  -Caption  +ToolWindow +owner  
	; WinGetPos, LMS_X, LMS_Y, LMS_W,LMS_H, NuGenesis LMS - \\Remote
	; Varbar_X := LMS_X+1000
	WinSet, Transparent, 200
	; Varbar_Y := LMS_Y
	Gui, VarBar:color, 21a366
	GUI, VarBar:Font, s16 cBlack Bold, Consolas
	Gui, VarBar:Add, edit, vProduct gproductVarBar left ReadOnly h30 x0 y0 w62, %product% ;|%DDLProducts%	
	GUI, VarBar:Font, s12 cBlack Bold, Consolas
	Gui, VarBar:add, Text, vBatch x68 y0 w100, %Batch%
	GUI, VarBar:Font, s9 cBlack , Arial Narrow
	Gui, VarBar:add, Text, vlot x70 y16 w70, %Lot%
	GUI, VarBar:Font, s7 cBlack , arial
	Gui, VarBar:add, Text, vCoated x120 y18 w50, %Coated%
	GUI, VarBar:Font, s8 cBlack , arial Narrow
	Gui, VarBar:add, Text, vname  x160 -wrap y0 w160, %Name%
	Gui, VarBar:add, Text, vcustomer  x210 -wrap y16 w160, %Customer%
	GUI, VarBar:Font, s8 cBlack , arial Narrow
	Gui, VarBar:add, Text, vColor x120 wrap y18 w80, %Color%
	GUI, VarBar:Font, s11 cBlack Bold, Consolap
	; Gui, VarBar:Add, text, gIterationVarBar vIteration left x300 h30 y0 w70,
	; Gui, VarBar:Add, UpDown, vIterationUpDown x300 h30 y0 w1 Range0-6, %Iteration%
	OnMessage(0x203, "VarBar.Relocate")
	CoordMode, mouse, screen
	; WinGetPos, VarBar_X, VarBar_Y,,, NuGenesis LMS - \\Remote,
	; varbar_x:= Varbar_x +100
	Gui, VarBar:Show, h30 x%VarBar_X% y%VarBar_y%  w300 NoActivate, VarBar
	; Gui, VarBar:Show, h30 x%offset_X% y%offset_y%  w320 NoActivate, VarBar
	CoordMode, mouse, window
	return





ProductVarBar:
sleep 100
Gui, VarBar:submit,NoHide

return
IterationVarBar:
	; sleep 600
	; Gui, VarBar:Submit,Nohide
	; ControlGetText, Iteration, Edit2, VarBar
	
	; sleep 100
	; IniWrite, %Iteration%, data.ini, SavedVariables, Iteration
	; return
VarBarGuiClose:
	coordmode, mouse, Screen
	; WinGetPos,VarBar_X,Varbar_Y,w,h
		WinGetPos, LMS_X, LMS_Y, LMS_W,LMS_H, NuGenesis LMS - \\Remote
	Varbar_X := LMS_X+1000
	Varbar_Y := LMS_Y
	sleep 100
	IniWrite, %VarBar_X%, data.ini, Locations, VarBar_X
	IniWrite, %VarBar_y%, data.ini, Locations, VarBar_Y
	; coordmode, mouse, Window
	sleep 500
	GUI, VarBar:destroy
return
}


Follow(){
	global
	  SetTimer, CheckActive, 600
		WinGetPos, LMS_X, LMS_Y, LMS_W,LMS_H, A
	VarWin_X := LMS_X+(LMS_W/2)-400
	VarWin_Y := LMS_Y 
  WinMove, VarBar ahk_class AutoHotkeyGUI,, VarWin_X, VarWin_Y,
	return
}

Relocate(){
	global
	settimer, checkactive, off
	PostMessage, 0xA1, 2 
	 keywait, Lbutton, U
	 wingetpos, Varbar_X, Varbar_Y,W,H, VarBar ahk_class AutoHotkeyGUI
	IniWrite, %Varbar_X%, data.ini, Locations, VarBar_X
	IniWrite, %Varbar_Y%, data.ini, Locations, VarBar_Y
	sleep 300
	return
}

Clear(Var:="NotProduct"){
	global
	If Var contains NotProduct
	{
		ControlsetText, Static1,, VarBar
		ControlsetText, Static2,, VarBar
		ControlsetText, Static3,, VarBar
		ControlsetText, Static4,, VarBar
		ControlsetText, Static5,, VarBar
		ControlsetText, Static6,, VarBar
		ControlsetText, Static7,, VarBar
		ControlsetText, Static8,, VarBar
	}
If Var contains NotBatch
	{
		ControlsetText, Static2,, VarBar
		ControlsetText, Static3,, VarBar
		ControlsetText, Static4,, VarBar
		ControlsetText, Static5,, VarBar
		ControlsetText, Static6,, VarBar
		ControlsetText, Static7,, VarBar
		ControlsetText, Static8,, VarBar
	}
	If (Var:= "Notlot")
	{
		ControlsetText, Static3,, VarBar
		ControlsetText, Static4,, VarBar
		ControlsetText, Static5,, VarBar
		ControlsetText, Static6,, VarBar
		ControlsetText, Static7,, VarBar
		ControlsetText, Static8,, VarBar
	}
	else
		varbar.update(), 
	
}

LaunchTable(){
		global
    if winactive("Result Editor - \\Remote") || Winactive("Test Definition Editor - \\Remote") || winactive("Results Definition - \\Remote")
      SpecTab_Table()
    else
      ProductTab_Table()
  return
  }

get(Category:="All"){
	Global
	If Category contains All
		return
	If Category contains Product
		output:=product
	else If Category contains Batch
		output:=Batch	
	else If Category contains Lot
		output:=Lot
	else If Category contains Coated
		output:=Coated
	else If Category contains Name
		output:=Name
	else If Category contains Customer
		output:=Customer
	else If Category contains Iteration
		output:=Iteration
	sleep 100
		Return %ouput%
}

Sendinput(Category:="",PostOutput:="")
	{
		Global
		BlockInput, on
		sleep 100
		if WinActive("Select Product - \\Remote")
		{
			send, {click 106, 64}%Product%{enter}{enter}
			exit
			}
		if WinActive("NuGenesis LMS - \\Remote") 
		{
				SearchBar("Product")
		}
		if winactive("Register new samples - \\Remote")
			send, {click 182, 103}%Product%
		If Category contains Product
			output:=product
		else If Category contains Batch
			output:=Batch	
		else If Category contains Lot
			output:=Lot
		else If Category contains Coated
			output:=Coated
		else If Category contains Name
			output:=Name
		else If Category contains Customer
			output:=Customer
		else If Category contains Iteration
			output:=Iteration
		Send, %output%%PostOutput%
			sleep 100
		if WinActive("NuGenesis LMS - \\Remote") || WinActive("Select Product - \\Remote") || winactive("ahk_exe explorer.exe")
				sendinput, ^a^c{enter}	
				blockinput off
		if winactive("Find and Replace")
			send, !i
		sleep 400
		return
}



Search(input){
		global
	Clip()
	; WinActivate, NuGenesis LMS - \\Remote
	; click 746, 47
	; sleep 200
	SearchBar(input)
	; Varbar.sendinput("Batch")
	return
}




AddIteration(){
	global Iteration
	GuiControl, Varbar:Text, iteration, %iteration%
	Iteration+=1
	sleep 50
	tooltip(Iteration)
	return
	}
SubIteration(){
	global Iteration
	GuiControl, Varbar:Text, iteration, %iteration%
	Iteration-=1
	sleep 50
	tooltip(Iteration)
	return
	}


Reset()
{
	Global
	GUI, VarBar:destroy
	coordmode, mouse, Screen
	MouseGetPos,MousePos_X,MousePos_Y,w,h
	coordmode, mouse, Window
	IniWrite, MousePos_X+50, data.ini, Locations, ProductTable_X
	IniWrite, MousePos_Y+50, data.ini, Locations, ProductTable_Y
	IniWrite, MousePos_X+50, data.ini, Locations, SpecTable_X
	IniWrite, MousePos_Y+50, data.ini, Locations, SpecTable_Y
	;Gui, VarBar:Show, h30 x%VarBar_X% y%VarBar_y%  w390 ;  NoActivate
	VarBar.show(0)
	return
}


update(){
	Global
	GuiControl, Varbar:Text, Product, %Product%
	GuiControl, Varbar:Text, Batch, %Batch%
	GuiControl, Varbar:Text, lot, %lot%
	GuiControl, Varbar:Text, Coated, %coated%
	GuiControl, Varbar:Text, name, %name%
	GuiControl, Varbar:Text, customer, %Customer%
	GuiControl, Varbar:Text, iteration, %iteration%
	GuiControl, varbar:text, ShapeSize, %shapeSize%
	GuiControl, varbar:text, Color, %Color%
}
}
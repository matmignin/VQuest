

Class VarBar{	
	Show(X:=1, Y:=1, Destroy:="Reset"){
			Global
				TopScreen:=1 ;A_ScreenHeight-35
				MidScreen:=A_ScreenWidth//2
				VarBar_H=1
				VarBar_T:=235
				VarBar_W=450
			try Gui,VarBar:Destroy
			This.loadSavedVariables()
				Gui Varbar:Default
				Gui VarBar: +AlwaysOnTop -Caption +ToolWindow +owner +HwndGUIID 
				WinSet, Transparent, 100, %GUIID%
				Gui, VarBar:color,DC734F, 97BA7F     
				this.AddBoxes()
			CoordMode, mouse, screen
			IfWinexist, NuGenesis LMS - \\Remote
			LMS.Orient()
			Gui, VarBar:Show,  x%Varbar_X% y%Varbar_y% w%VarBar_w% h%varbar_H% NoActivate, VarBar
		CoordMode, mouse, window
		ControlsetText, Static1, %Iteration%,VarBar
		OnMessage(0x0201, "WM_LBUTTONDOWN")
		OnMessage(0x203, "VariableBar_Relocate")
		WinSet, Transparent, %Varbar_T%, AHK_id %GUIID%
		return
	}
		AddEdit(Variable,Dimensions:="",Font:=""){
			global
				GUI,VarBar:Font,			 s%Font%  , consolas ;cBlack Bold, %Font%
				Gui,VarBar:Add,edit,		v%Variable% +wrap -multi	g%Variable%VarBar %Dimensions%,		%    %Variable% 
		}
		AddText(Variable,Dimensions:="",Font:=""){
			global
				GUI,VarBar:Font,			 s%Font%  ;cBlack Bold, %Font%
				Gui,VarBar:Add,Text,		v%Variable% 	%Dimensions%,		%    %Variable%  
		}
	AddBoxes(){
			global
			this.AddEdit("Product",	"left h29 x10 y1 w65",			"16 Bold")
			this.AddEdit("Batch",		"left h29 x+1 y1 w75", 			"11,Consolas")
			If !Lot
				 L_L:="w60"
			else 
					L_L:=
			this.AddEdit("Lot",			"left h29 x+1 y1 " L_L , 			"9, Consolas")
			If !Coated
				 C_L:="w45"
			else 
					C_L:=
				this.AddEdit("Coated",	"left h29 x+1 y1 " c_L,			"9, Arial Narrow")
			if ShowSampleID
			this.AddEdit("SampleID","H29 x+1 y1 w85",					"9, Arial Narrow")
			else
			this.AddEdit("SampleID","H29 x+1 y1 w0",					"9, Arial Narrow")
		; GUI,VarBar:Font,			
		This.AddText("Iteration","x+5 center y-3 w23",		"20 Bold 107C41, Consolas")	; Text1
			This.addedit("Note1","x+3 H29 y1 w150 left" ,"9 cBlack,arial Narrow") ; edit6
			This.addedit("Note2","X3 H29 y+2 w440 left","9 cBlack,arial Narrow")			; edit7
			; This.addedit("Note3","X+3 H29  w220 left","9 cBlack,arial Narrow")				; edit8
		Return
		
			ProductVarBar:
			BatchVarBar:
			LotVarBar:
			SampleIDVarBar:
			Note1VarBar:
			Note2VarBar:
			Note3VarBar:
			CoatedVarBar:
			sleep 100
			Gui, VarBar:submit,NoHide
			; this.SaveVariables()
			return

			VarBarGuiClose:
			VarBarGuiEscape:
				sleep 100
				this.SaveVariables()
			return
		}

Menu(){
  global
	MouseGetPos,,,,WinControl
  try Menu, VarBarmenu, DeleteAll
	    HideVarBar:=CreateMenu("showVarbar","VarBarMenu")
    TempCode:=CreateMenu("TempCode","VarBarMenu")
    EnteringRotations:=CreateMenu("EnteringRotations","VarBarMenu")
    SwitchWorkSheets:=CreateMenu("SwitchWorkSheets","VarBarMenu")
    DebuggingScript:=CreateMenu("DebuggingScript","VarBarMenu")
    HideVarbar:=CreateMenu("HideVarbar","VarBarMenu")
    Menu, VarBarMenu, Add,		 		Show&SampleID, 					ShowSampleID 
      if ShowSampleID=1  
        menu, VarBarmenu, Check, 	Show&SampleID
    Menu, VarBarMenu, Add,		 		Tables, 					Varbar.LaunchTable 
		
		If WinExist("Mats LMS Workbook.xlsb - Excel"){ 
			Menu,VarBarMenu,add,				&Spec Table,						Tests
			Menu,VarBarMenu,add,				&Ingredient Table,			Tests
		}
  Try Menu,VarBarmenu,show
  }


HoverAction(Size:=100){
  global
	If (MouseIsOver("VarBar ahk_exe AutoHotkey.exe") && Varbar_H!=Size ){
		; ControlGetFocus, GUIFocus, VarBar
    VarBar_H:=Size
    WinMove, VarBar ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, ,,,,%VarBar_H%
	}
	else If !(MouseIsOver("VarBar ahk_exe AutoHotkey.exe") && Varbar_H!=32 ){
		ControlGetFocus, GUIFocus, VarBar
		if GUIFocus
			return
		VarBar_H:=32
    WinMove, VarBar ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, ,,,,%VarBar_H%
	}
}


	loadSavedVariables(){
		global
		if !WinExist("Mats LMS Workbook.xlsb") { ;|| !RegexMatch(XL.ActiveSheet.Name, "i)[abdefghijkl]\d{3}"){
			Iniread, Batch, data.ini, SavedVariables, Batch
			Iniread, Product, data.ini, Products, Product
			Iniread, Batch0, data.ini, SavedVariables, Batch0
			Iniread, Batch1, data.ini, SavedVariables, Batch1
			Iniread, SampleID, data.ini, SavedVariables, SampleID
			Iniread, Lot, data.ini, SavedVariables, Lot
			Iniread, Coated, data.ini, SavedVariables, Coated
			}
			
			IniRead, Varbar_X, data.ini, Locations, VarBar_X
			IniRead, Varbar_Y, data.ini, Locations, VarBar_Y
			Iniread, Iteration, data.ini, SavedVariables, Iteration
			Iniread, ShowSampleID, data.ini, Options, ShowSampleID
			Iniread, ShowCoated, data.ini, Options, ShowSampleID
			Iniread, ShowNote3, data.ini, Options, ShowNote3
			Iniread, SwitchWorkSheets, data.ini, Options, SwitchWorkSheets
			iniread, note1, data.ini, Notes, note1
			Iniread, note2, data.ini, Notes, note2
			Products:=[]
        FileRead, LoadedNotes, Data\CurrentCodes.txt
        Products := StrSplit(LoadedNotes,"`r`n")
		}


	SaveVariables(){
		global
		if Product
			iniwrite, %Product%, data.ini, Products, Product
		if Batch
			iniwrite, %Batch%, data.ini, Batches, Batch
		if Lot
			iniwrite, %Lot%, data.ini, SavedVariables, Lot
		if Coated
			iniwrite, %Coated%, data.ini, SavedVariables, Coated
		if SampleID
			iniwrite, %SampleID%, data.ini, SavedVariables, SampleID
		if Iteration
			IniWrite, %Iteration%, data.ini, SavedVariables, Iteration
		if CurrentCodes
			IniWrite, `n%CurrentCodes%, Data\Products.ini, %The_Day%, %The_Hour%
		if Note1
			IniWrite, %note1%, data.ini, Notes, note1
		if Note2
			IniWrite, %note2%, data.ini, Notes, note2
		; if Note3
			; IniWrite	, %note3%, data.ini, Notes, note3
		}



			
		

      FloatAtopWindow(FloatTime:=""){
			Global Varbar_X, Varbar_Y
    	  wingetpos, Varbar_X, Varbar_y, Varbar_w, Varbar_h, VarBar ahk_exe AutoHotkey.exe
      WinGetPos, VarBar_oX, VarBar_oY, Varbar_oW,Varbar_oH, A
      WinMove, VarBar ahk_class VarBar ahk_exe AutoHotkey.exe, ,varbar_oX+100, Varbar_oy
        WinWaitNotActive,  ;- \\Remote,, 20, NuGenesis LMS - \\Remote
				WinMove, VarBar ahk_class VarBar ahk_exe AutoHotkey.exe, ,varbar_x, Varbar_y
    }
		
		
		
		
		



	Reset(){
		Global
			coordmode, mouse, Screen
			; keywait, Lbutton, U T2
			MouseGetPos,Varbar_X,Varbar_Y
		; tooltip,
		IniWrite, %VarBar_y%, data.ini, Locations, VarBar_Y
		IniWrite, %varbar_x%, data.ini, Locations, VarBar_X
		IniWrite, %Xpos%, %A_ScriptDir%\ClipData\ClipChain\ClipChain.ini, Settings, ClipChainX
		IniWrite, %Ypos%, %A_ScriptDir%\ClipData\ClipChain\ClipChain.ini, Settings, ClipChainY

		VarBar.show(0)
		coordmode, mouse, window
		return
		}


		
	Focus(Control){
		global
		WinGetTitle, the_WinTitle, A
		caret_x:=A_CaretX
		caret_y:=A_Carety
		WinActivate, VarBar ahk_exe AutoHotkey.exe
		GuiControl Varbar:Focus, %Control%
		; sleep 100
		SendInput, ^{a}
		return
		}	

	Relocate(){
		global
				PostMessage, 0xA1, 2
				keywait, Lbutton, U T2
					Send, ^a
		return
	}
		

	LaunchTable(){
		global
		try GUI ingredient_table:destroy
		try GUI Spec_table:destroy
		excel.connect(1)
		ifwinnotactive, ahk_exe WFICA32.EXE 
		winactivate, ahk_exe WFICA32.EXE
		lms.DetectTab()
		if winexist("Result Editor - \\Remote") || Winactive("Test Definition Editor - \\Remote") || winactive("Results Definition - \\Remote") || (Tab="Specs")
			SpecTab.Table()
		if winexist("Composition - \\Remote") || WinActive("Edit Ingredient - \\Remote") || (Tab="Products")
			ProductTab.Table()
		else {
				Menu.Tables()
			; If (Tab="Products")
				; ProductTab.Table()
			; else If (Tab="Specs")
				; SpecTab.Table()
			; else	
		}
		return
	}




		Search(input){
		global
		Clip()
		LMS.SearchBar(input)
		return
		}

		AddIteration(speed:=350){
		global Iteration
		; GuiControl, -redraw, varbar
		sleep 10
		Iteration+=1
		ControlsetText, Static1,%Iteration%,VarBar
		Pop(Iteration)
		; tt(Iteration,300,Varbar_x,Varbar_y,2,200)
		sleep %Speed%
		IniWrite, %Iteration%, data.ini, SavedVariables, Iteration
		; GuiControl, +redraw, varbar
		return
		}
		SubIteration(speed:=350){
		global Iteration
		; GuiControl, -redraw, varbar
		sleep 10
		Iteration-=1
		ControlsetText, Static1,%Iteration%,VarBar
		; tt(Iteration,300,Varbar_x,Varbar_y,2,200)
		Pop(Iteration)
		sleep %speed%
		IniWrite, %Iteration%, data.ini, SavedVariables, Iteration
		; GuiControl, +redraw, varbar
		return
		}

	

HistoryMenuItem(){
	global
	sleep 200
	RegExMatch(A_ThisMenuItem, "i)[abdefghijkl]\d{3}\b", rProduct)
	ControlsetText, Edit1,%rProduct%, VarBar
	RegExMatch(A_ThisMenuItem, "i)(?<!Ct#)\b\d{3}-\d{4}\b", rBatch)
	ControlsetText, Edit2,%rBatch%, VarBar
	RegExMatch(A_ThisMenuItem, "i)(\b\d{4}\w\d\w?|\bBulk\b)", rlot)
	ControlsetText, Edit3,%rLot%, VarBar
	RegExMatch(A_ThisMenuItem, "i)(coated: |ct#\s|Ct#|ct\s|coated\s)\d{3}-\d{4}\b", rCoated)
	RegExMatch(rCoated,   "\d{3}-\d{4}", rCoated)
	ControlsetText, Edit4,%rCoated%, VarBar 
	Product:=rProduct
	Batch:=rBatch
	Lot:=rLot
	Coated:=rCoated 
	return
	}
	}
			
			
;;||||||||||||||||||||||||||||||||||| KEYBINDINGS |||||||||||||||||||||||||||||||||||||
	#IfWinActive, VarBar ahk_exe AutoHotkey.exe 
		F19 & F20::Send, {tab}{shiftdown}{tab}{shiftup} ;varbar.focus("Batch")
	;	F19::varbar.focus("Product")
		; F20::varbar.focus("Batch")
		^enter::                           
								winactivate, %the_WinTitle%
								click, %caret_X%, %caret_y%
								return
		Mbutton::
			click
		enter::
			ControlGetFocus,WinControl,VarBar ahk_exe AutoHotkey.exe	
			if (WinControl="Edit1") || (WinControl="Edit2") || (WinControl="Edit3") ||(WinControl="Edit4"){
						Send, ^a^c
						winactivate, NuGenesis LMS - \\Remote			
				LMS.Searchbar(clipboard,"{enter}")
			}
			if (WinControl="Edit6") || (WinControl="Edit7") || (WinControl="Edit8") || (WinControl="Edit9")
				varbar.SaveVariables()
				;varbar.show()
			return
		;Lbutton::click
			; Rbutton::					
			; MouseGetPos,,,,WinControl
			; ; ControlGetFocus,WinControl,VarBar ahk_exe AutoHotkey.exe
			; if (WinControl="Edit1") || (WinControl="Edit2") || (WinControl="Edit3") || (WinControl="Edit4")
			; 	menu.ProductSelection()
			; else
			; 	VarBar.Menu()
			; return
	#ifwinactive
		; ^left::Lms.SelectTab("Left")
		; ^right::LMs.SelectTab("right")

	#If MouseIsOver("VarBar ahk_exe AutoHotkey.exe") && WinExist("Mats LMS Workbook.xlsb - Excel")
		wheelleft::Excel.PrevSheet()
		wheelright::excel.Nextsheet()   
												
	#If MouseIsOver("VarBar ahk_exe AutoHotkey.exe")
		wheelright::	Varbar.AddIteration(0)
		wheelleft::Varbar.SubIteration(0)
		Numlock::
			MouseGetPos,,,,WinControl
				if (WinControl="Edit1") || (WinControl="Edit2") || (WinControl="Edit3"){
					click
					Send, ^a
					clip.regex()
					winactivate, NuGenesis LMS - \\Remote			
					LMS.Searchbar(clipboard,"{enter}")
					return
				}
				else if (winControl="Edit6") 
					TT(Wincontrol)
				else
					VarBar.Menu()
				return



		WheelUp::      send % Blockrepeat(600) Varbar.AddIteration()
		Wheeldown::    send % Blockrepeat(600) Varbar.SubIteration()
		+wheelup::	Varbar.AddIteration(0)
		+wheeldown::Varbar.SubIteration(0)
		; up::				Varbar.AddIteration(0)
		; down::   		Varbar.SubIteration(0)
		F9::           Excel.connect()
		F7::           Excel.NextSheet()
		F6::           Excel.PrevSheet()
		F8::				Varbar.launchTable()
			return
		; Rbutton::		
		; MouseGetPos,,,,WinControl
		; 		if (WinControl="Edit1")
		; 			menu.Products()	
		; 		else if (WinControl="Edit2") || (WinControl="Edit3")
		; 			menu.Batches()
		; 		else if (winControl="Static1")
		; 			VarBar.Menu()
		; 		else
		; 			menu.SetStatus()
		; 	return
		numpaddot:: 	 Openapp.Workbook()
	#if

  WM_LBUTTONDOWN(wParam, lParam){
		PostMessage, 0xA1, 2
				X := lParam & 0xFFFF
				Y := lParam >> 16
				if A_GuiControl
					Ctrl := "`n(in control " . A_GuiControl . ")"
				PostMessage, 0xA1, 2
				MouseGetPos,,,,WinControl
				setTimer, SaveVarBarLocaton, -1000

		return
		SaveVarBarLocaton:
			wingetpos, Varbar_X, Varbar_Y,W,H, VarBar ahk_class AutoHotkeyGUI
			IniWrite, %VarBar_y%, data.ini, Locations, VarBar_Y
			IniWrite, %varbar_x%, data.ini, Locations, VarBar_X
			return
} 

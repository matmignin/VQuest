return

Class ClipBar{
	Show(X:=1, Y:=1, Destroy:="Reset"){
		Global
		try GUI,ClipBar:Destroy
		TopScreen:=1 ;A_ScreenHeight-35
		MidScreen:=A_ScreenWidth//2
		wingetpos, Nugenesis_X, Nugenesis_y, Nugenesis_w, Nugenesis_h, NuGenesis LMS
		wingetpos, Win_X, Win_y, Win_w, Win_h, A
		ClipBar_H=33
		ClipBar_H_max=56
		ClipBar_T:=235
		ClipBar_W=390
		ClipBar_x:=Nugenesis_X+(Nugenesis_W/3)
		; ClipBar_Y:=-Nugenesis_h
		ClipBar_Y:=Nugenesis_Y
		Gui ClipBar: +AlwaysOnTop -Caption +Toolwindow +owner +HwndGUIID
		Gui ClipBar:Default
		Gui, ClipBar:+Delimiter`n
		winSet, Transparent, 100, %GUIID%
		GUI, ClipBar:color,DC734F, 97BA7F
		; this.AddEdit("Product",	 "left h32 x1 y0 w65",				"16 Bold")
			GUI,ClipBar:Font,			 s17 Bold , consolas
			GUI,ClipBar:Add,edit,		vProduct +wrap -multi	gClipBarHandler left h33 x1 y0 w65,	%Product%
		this.AddEdit("Batch",	 "left h33 x+0 y0 w92", 			"13,Consolas")
		this.AddEdit("Lot",		 "left h33 x+0 y0 w77", 			"10, Consolas")
		this.AddEdit("Coated",	 "left h33 x+0 y0 wrap w72",		"9, Arial Narrow")
		GUI, ClipBar:font, cBlack s9 Norm w500 , Consolas
		This.AddEdit("Iteration", "x+2 h33 left y0 w62",			 "16 Bold 107C41, Consolas")	; Text1
		this.AddBoxes()
		CoordMode, mouse, screen
		try GUI, ClipBar:Show, x%ClipBar_X% y%ClipBar_y% w%ClipBar_w% h%ClipBar_H% Noactivate, ClipBar
		catch
			GUI, ClipBar:Show, x%Win_X% y%Win_Y% w%ClipBar_w% h%ClipBar_H% Noactivate, ClipBar
		CoordMode, mouse, window
		; OnMessage(0x0201, "WM_LBUTTONDOWN")
		this.loadSavedVariables()
			OnMessage(0x0201, "WM_LBUTTONDOWN")
			OnMessage(0x0203, "WM_LBUTTONDBLCLK")
			; OnMessage(  WM_LBUTTONUP := 0x0202, "WM_LBUTTONUP")
			;OnMessage(0x0200, "WM_MOUSEMOVE")
			; OnMessage(0x203,  "VariableBar_Relocate")
		; OnMessage(0x002C, "ODDDL_MeasureItem") ; WM_MEASUREITEM
		; OnMessage(0x002B, "ODDDL_DrawItem") ; WM_DRAWITEM
		winSet, Transparent, %ClipBar_T%, AHK_id %GUIID%
		Return

		ClipBarHandler:
		; while (A_TimeIdle < 1000) && winactive("ClipBar")
		; sleep 25
		; sleep 300
			; sleep 1000
			PriorCodestring:=CodeString
			GUI, ClipBar:submit,NoHide
			; ControlGetText, Product, Edit1, ClipBar
			; ControlGetText, Batch, Edit2, ClipBar
			; ControlGetText, Lot, Edit3, ClipBar
			; ControlGetText, Coated, Edit4, ClipBar
			; ControlGetText, Iteration, Edit5, ClipBar
			Ct:=Coated ? " ct#" : ""
			; CodeString:=clip.CodesRegex(clipboard)
			CodeString:=trim(Product " " Batch " " Lot Ct Coated)
			      if (PriorCodestring!=Codestring){
					FileDelete, %CodeFile%
					sleep 200
					FileAppend, %CodeString%, %CodeFile%
				}
			; iniwrite, %CodeString%, \\10.1.2.118\users\vitaquest\mmignin\RemoteVQ\Settings.ini, SavedVariables, Code

		return
		ClipBarGuiClose:
		ClipBarButtonOK:
		ClipBarGuiEscape:
			; GUI, ClipBar:submit,NoHide
			sleep 50
			ClipBar.SaveVariables()
		return
	}

	AddEdit(Variable,Dimensions:="",Font:=""){
		global
		GUI,ClipBar:Font,			 s%Font% , consolas ;cBlack Bold, %Font%
		GUI,ClipBar:Add,edit,		v%Variable% +wrap -multi	gClipBarHandler %Dimensions%,		% %Variable%
	}
	AddText(Variable,Dimensions:="",Font:=""){
		global
		GUI,ClipBar:Font,			 s%Font% ;cBlack Bold, %Font%
		GUI,ClipBar:Add,Text,		v%Variable% 	%Dimensions%,		% %Variable%
	}

	Menu(){
		global
		If Nsub
				exit
			Nsub:=1
		MouseGetPos,,,,winControl
		try Menu, ClipBarmenu, DeleteAll
		Menu, ClipBarMenu, Add, All Products, AllProductsMsgbox
		Menu, ClipBarMenu, Add, All Batches, AllBatchesMsgbox
		Menu, ClipBarMenu, Add,
		Menu, ClipbarMenu, add, Show WholeBatches, ShowWholeBatches
		Menu, FtenMenu, Add, ApproveTestSpec, FtenMenuHandler
		Menu, FtenMenu, Add, NewSpecVersion, FtenMenuHandler
		Menu, FtenMenu, Add, RemoveTestSpec, FtenMenuHandler
		Menu, FtenMenu, Add, RemoveAndApprove, FtenMenuHandler
		Menu, FtenMenu, Add, WholeBatchMenu, FtenMenuHandler
		Menu, FtenMenu, Add, AddOrganoleptic, FtenMenuHandler
		Menu, ClipbarMenu, Add, Ften, :FtenMenu
		Menu, ClipBarMenu, add, Show Final Label Copy, ShowFinalLabelCopy
		Menu, ClipBarMenu, add, Show Scan Label Copy, ShowScanLabelCopy
		Menu, ClipBarMenu, add, Show Total CoAs, ShowFINAL_C_O_A
		Menu, ClipbarMenu, add, Manual &COAs folder, ShowManualCOA
		Menu, ClipbarMenu, add, &mfg folder, Showmfg
		Menu, ClipbarMenu, add, &GLOBAL VISION folder, ShowGlobalVision
		; Menu, ClipBarMenu, add, Show EditBox, ShowEditBox, +Break
		; Menu, ClipBarMenu, add, Paste Spec, +!^F10
		Menu, ClipBarMenu, add, Add Data From Clipboard, #+!F10
		Menu, ClipBarMenu, add, ParsespecsTable, #+^F10
		Menu, ClipBarMenu, Add, Stop Timer, StopTimer
		Menu, ClipbarMenu, add, Add Sample Log, !^+F3
		Menu, ClipBarMenu, Add, Detect Clipboard, clipChange
		if winactive("Results Definition") || winactive("Composition") || winactive("Results"){
			Menu, ClipBarMenu, Add, USP Heavy Metal, Heavy_metals, +Break
			Menu, ClipBarMenu, Add, Canada Heavy Metal, Heavy_metals
			Menu, ClipBarMenu, Add, Prop65 Heavy Metal, Heavy_metals
			Menu, ClipBarMenu, Add, Report Only Heavy Metal, Heavy_metals
			Menu, ClipBarMenu, Add, Custom Heavy Metal, Heavy_metals
		}
		Try Menu,ClipBarmenu,show
		Nsub:=
	}
	Reset(){
		Global
		coordmode, mouse, Screen
		; keywait, Lbutton, U T2
		MouseGetPos,ClipBar_X,ClipBar_Y
		ClipBar.show(0)
		coordmode, mouse, window
		return
	}

	Focus(Control){
		global
		; winGetTitle, the_winTitle, A
		winactivate, ClipBar ahk_exe RemoteVQ
		; caret_x:=A_CaretX
		GuiControl ClipBar:Focus, %Control%
		; caret_y:=A_Carety
		; winactivate, ClipBar ahk_exe RemoteVQ
		; FlashScreen()
		Sendinput, +{left}
		return
	}

	Search(input){
		global
		Clip()
		LMS.SearchBar(input)
		return
	}

	AddIteration(speed:=300){
		global Iteration, NAdd
			If NAdd
				exit
			; #maxthreadsperhotkey, 1
			; #MaxHotkeysPerInterval, 500
		; GuiControl, -redraw, ClipBar
		NAdd:=1
		sleep 55
		Iteration+=1
		sleep %Speed%
		ControlsetText, Edit5,%Iteration%,ClipBar
		; sleep 100
			; #MaxHotkeysPerInterval, 70
		NAdd:=0
		;CustomerPosition:=Iteration
		; #maxthreadsperhotkey, 2
		return
	}
	SubIteration(speed:=300){
		global Iteration, NSub
			If Nsub
				exit
			; #maxthreadsperhotkey, 1
		; #MaxHotkeysPerInterval, 500
		Nsub:=1
		; GuiControl, -redraw, ClipBar
		sleep 55
		Iteration-=1
		sleep %speed%
		ControlsetText, Edit5,%Iteration%,ClipBar
		; sleep 100
		Nsub:=0
		;CustomerPosition:=Iteration
			; #maxthreadsperhotkey, 2
		return
	}

		Relocate(){
		global
				PostMessage, 0xA1, 2
				; if MouseIsOver("ClipBar")
					; keywait, Lbutton, U T1
					; Send, ^a
		return
	}
	SaveVariables(){ ;;_________________SAVING VARIABLES_________________________
	global
		GUI, ClipBar:default
		GUI, ClipBar:Submit, Nohide
		ControlGetText, Product, Edit1, ClipBar
		ControlGetText, Batch, Edit2, ClipBar
		ControlGetText, Lot, Edit3, ClipBar
		ControlGetText, Coated, Edit4, ClipBar
		ControlGetText, Iteration, Edit5, ClipBar
		Null:=""
		sleep 100
		if Product
			iniwrite, %Product%, Settings.ini, SavedVariables, Product
		else
			iniwrite, %Null%, Settings.ini, SavedVariables, Product
		if Batch
			iniwrite, %Batch%, Settings.ini, SavedVariables, Batch
		else
			iniwrite, %Null%, Settings.ini, SavedVariables, Batch
		if lot
			iniwrite, %Lot%, Settings.ini, SavedVariables, Lot
		else
			iniwrite, %Null%, Settings.ini, SavedVariables, Lot
		if Coated
			iniwrite, %Coated%, Settings.ini, SavedVariables, Coated
		else
			iniwrite, %Null%, Settings.ini, SavedVariables, Coated
		; if SampleID
			; iniwrite, %SampleID%, Settings.ini, SavedVariables, SampleID
		; if Iteration
			iniwrite, %Iteration%, Settings.ini, SavedVariables, Iteration
		; else
			; iniwrite, %Null%, Settings.ini, SavedVariables, SampleID
		; if CustomerPosition
	}
loadSavedVariables(){ ;;___________________________LOADING VARIABLES_________________________
	global
		GUI, ClipBar:default
		Iniread, Iteration, Settings.ini, SavedVariables, Iteration
		iniRead, Product, Settings.ini, SavedVariables, Product
		iniRead, Batch, Settings.ini, SavedVariables, Batch
		iniRead, Lot, Settings.ini, SavedVariables, Lot
		iniRead, Coated, Settings.ini, SavedVariables, Coated

		; if !Iteration
			; GuiControl,ClipBar:Text, Iteration, %Iteration%
		;  if !Product
			; GuiControl,ClipBar:Text, Product, %Product%
		; if Batch
		; 	GuiControl,ClipBar:Text, Batch, %Batch%
		; if lot
		; 	GuiControl,ClipBar:Text, lot, %lot%
		; if Coated
		; 	GuiControl,ClipBar:Text, Coated, %Coated%
		; GUI, ClipBar:Submit, Nohide
	}
}
; WM_LBUTTONDOWN(wParam, lParam){
; 		If !MouseIsOver("ClipBar ahk_exe RemoteVQ")
; 		return
; 		PostMessage, 0xA1, 2
; 				X := lParam & 0xFFFF
; 				Y := lParam >> 16
; 				if A_GuiControl
; 					ctrl := "`n(in control " . A_GuiControl . ")"
; 				PostMessage, 0xA1, 2
; 				MouseGetPos,,,,winControl
; }
		return
;;||||||||||||||||||||||||||||||||||| KEYBINDINGS |||||||||||||||||||||||||||||||||||||
#Ifwinactive, ClipBar ahk_exe RemoteVQ.exe
	enter::
		ControlGetFocus,winControl,ClipBar ahk_exe RemoteVQ.exe
		if (winControl="Edit1") || (winControl="Edit2") || (winControl="Edit3"){
			GUI, ClipBar:default
			Gui, ClipBar:submit, nohide
			LMS.Searchbar(clipboard,"{enter}")
		}
			else if (winControl="Edit4"){
				Coated:=
				GUI, ClipBar:default
				ControlsetText, Edit4,%Coated%,ClipBar ahk_exe RemoteVQ.exe
				Gui, ClipBar:submit, nohide
				iniwrite, Coated, Settings.ini, SavedVariables, Coated
			}

	return
	Mbutton::
			; ControlGetFocus,winControl,ClipBar ahk_exe RemoteVQ
			; MouseGetPos, , , winid, wincontrol
			; if (winControl="Edit1") || (winControl="Edit2") || (winControl="Edit3"){
				ClipBar.Menu()
				return
			; }
			; else if (winControl="Edit4"){
				; Coated:=
				; GUI, ClipBar:default
				; ControlsetText, Edit4,%Coated%,ClipBar ahk_exe RemoteVQ
				; Gui, ClipBar:submit, nohide
				; iniwrite, Coated, Settings.ini, SavedVariables, Coated
			; }
#ifwinactive
	WM_LBUTTONDOWN(wParam, lParam){
		If !MouseIsOver("ClipBar ahk_exe RemoteVQ.exe")
		return
		PostMessage, 0xA1, 2
				X := lParam & 0xFFFF
				Y := lParam >> 16
				if A_GuiControl
					ctrl := "`n(in control " . A_GuiControl . ")"
				PostMessage, 0xA1, 2
				MouseGetPos,,,,winControl
				return
	}
#If MouseIsOver("ClipBar ahk_exe RemoteVQ.exe")

			;	setTimer, SaveVarBarLocaton, -1500
; Wheeldown::ClipBar.SubIteration(250)
; Wheelup::ClipBar.AddIteration(250)
; Wheelup::
; 	iniread, PriorCodeString, Settings.ini, SavedVariables, PriorCodeString
; 	sleep 200
; 	; clip.CodesRegex(PriorCodeString)
; 	; sleep 400
; 	return
; Wheeldown::
; 	iniread, CodeString, Settings.ini, SavedVariables, CodeString
; 	sleep 200
; 	; Fileread, CodeString, %CodeFile%
; 	; iniread, CodeString, Settings.ini, SavedVariables, CodeString
; 	clip.CodesRegex(CodeString)
; 	; sleep 400
; 	return
; ClipBar.AddIteration(450)
; ClipBar.SubIteration(450)


wheelleft::
	If BlockingWheel
			return
	#maxthreadsperhotkey, 1
		BlockingWheel:=1
	GoSub, AllProductsMsgbox
	SetTimer, BlockTheWheel, -3000
		#maxthreadsperhotkey, 2
	return

wheelright::
	If BlockingWheel
			return
	BlockingWheel:=1
	NumberMenu(6)
	sleep 2000
; GoSub, AllBatchesMsgbox
; sleep 2000
	BlockingWheel:=
	Return
wheelup::
	If BlockingWheel
			return
	#maxthreadsperhotkey, 1
	BlockingWheel:=1
	ClipBar.Menu()
		#maxthreadsperhotkey, 2
	SetTimer, BlockTheWheel, -3000
	return

wheeldown::
	If BlockingWheel
			return
	#maxthreadsperhotkey, 1
		BlockingWheel:=1
	WholeBatchMenu()
	SetTimer, BlockTheWheel, -3000
		#maxthreadsperhotkey, 2
	return

Mbutton::reloadSub()
Rbutton::
		; ControlGetFocus,winControl,ClipBar ahk_exe RemoteVQ
		MouseGetPos, , , winid, wincontrol
		if (winControl="Edit1")
			GetAllProducts()
		else if (winControl="Edit2")
			GetAllBatches()
		else if (winControl="Edit3"){
			Lot:=
			GUI, ClipBar:default
			ControlsetText, Edit3,%Lot%,ClipBar
			iniwrite, Lot, Settings.ini, SavedVariables, Lot
		}
		else if (winControl="Edit4"){
			Coated:=
			GUI, ClipBar:default
			ControlsetText, Edit4,%Coated%,ClipBar
			iniwrite, Coated, Settings.ini, SavedVariables, Coated
		}
		else if (winControl="Edit5")
			worktab.CustomerMenu()
		return

#if


ClipBar_ResetSub:
	ClipBar.Reset()
	return

BlockTheWheel:
	sleep 3000
	BlockingWheel:=
	#maxthreadsperhotkey, 2
	return


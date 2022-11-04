
		#ifwinactive,
	+#F11::SpecTab.ApproveSpecVersion()
	^#F11::SpecTab.NewSpecVersion()
	!#F11::SpecTab.RemoveTestSpec()
	~RWin::Send {Blind}{vkFF}
	~LWin::Send {Blind}{vkFF}
	F18::return
	; $RWin::return
	; $LWin::return
	<!left::GetAllProducts()
	<!right::GetAllBatches()
	; F1::sendinput, %Product%
	; F1::CountFiles()
	; +F1::GetAllProducts()
	; +F1::
		; SpecTab.GetRowText()
		; SpecTab.AutoFill()
		; return
	+!F5::LMS.Menu()
	^Space::LMS.SearchBar("",,"False")
	!^Space::LMS.SearchBar("","{delete}","False")
	^+s::specTab.TestDefinitionEditor_Stability()
	;_!F1::GetAllProducts("`n")
	+F1::worktab.NewTestRequestLink()
	F2::Reload
	;F2::sendinput, %Batch%
	^+F16::GetAllProducts()
	^+F15::GetAllBatches()
	;- !F2::GetAllBatches("`n")
	; F3::sendinput, %Lot%
	!F1::ClipBar.Focus("Edit1")
	!F2::ClipBar.Focus("Edit2")
	!F3::ClipBar.Focus("Edit3")
	!F4::ClipBar.Focus("Edit4")
	!F5::ClipBar.Focus("Edit5")
	F4::sendinput, %Coated%
	;+F3::3tap()
+!^F1::GetAllProducts()
+!^F2::GetAllBatches()
+!^F4::SwitchEnv("Test")
+!^F5::

	+F10::spectab.Autofill()
	; if !(Requirement)
	    ; iniread, MinLimit, Settings.ini, CopiedSpecs, MinLimit
        ; iniread, MaxLimit, Settings.ini, CopiedSpecs, MaxLimit
        ; iniread, Percision, Settings.ini, CopiedSpecs, Percision
        ; iniread, Requirement, Settings.ini, CopiedSpecs, Requirement
        ; iniread, Units, Settings.ini, CopiedSpecs, Units
        ; iniread, Description, Settings.ini, CopiedSpecs, Description
        ; iniread, ResultID, Settings.ini, CopiedSpecs, ResultID
        ; iniread, SeqNo, Settings.ini, CopiedSpecs, SeqNo
        ; iniread, Method, Settings.ini, CopiedSpecs, Method
	  ;copiedText:= ResultID "`t" Description "`n MinLimit: " MinLimit "`n MaxLimit: " MaxLimit "`n Requirement: " Requirement "`n Percision: " Percision "`n Units: " Units
	 ; TT(CopiedText,2000,1,1,1)

		return
	+F4::4tap()
	+F9::worktab.CustomerMenu()
		; Sendinput, ^{c}
		; sleep 100
		; TT(Clipboard)
		; return
	^F8::AddToList()
	; +F15::AddToList()
	; ^F9::send, ^v





Test_msgbox(msg){
	global
	; msgbox % " Name: " Name[] "`n Claim: " Claim[] "`n Position: " Position[] "`n IngredientID: " IngredientID[]
	; TT(Listarray(Name))
	TT(msg,2000)
	; listarray(Position),1000,300,300,2,,"R")
	return
}
Ctest_1:
	return


showLabelCopy(FileDir,FileType‚ShowMultiple:=0){
  Global Product
  Loop, Files, %FileDir%*%Product%*.%FieType%*,R
  {
	; If (A_LoopFileTimeCreated=Rec)
		; {
		; if FPath2
			; FPath3=%FPath2%
		; FPath2=%A_LoopFileFullPath%
		; Rec=%A_LoopFileTimeCreated%
		; }
	If (A_LoopFileTimeCreated>Rec)
		{
		; if FPath
		; FPathB=%FPath%
		FPath=%A_LoopFileLongPath%
		Rec=%A_LoopFileTimeCreated%
		}
	}
	sleep 300
	Run, explore %Fpath%
;   if !ShowMultiple
    ; Return
;   Else
;   Sleep 500
;   if FPath2
    ; Run, explore %Fpath2%
;   if FPath3
    ; Run, explore %Fpath3%
;   if FPathB
    ; Run, explore %FpathB%
  return
  }




AddToList(){
	; ListItem:=[]
	TT("AddToList")
	; ListItem:=StrSplit(ParseText,"`n")
	CoordMode, mouse, window
	Loop, parse, clipboard, "`n"
	{
		TT(A_index ": `n" A_LoopField,2000)
		Breaking.Point()
		click, 407, 73 ;click New Value
		sleep 200
		click, 608, 201 ;click First EditBox
		sleep 200
		sendinput, %A_loopField%
		sleep 400
		Breaking.Point()
	}
	return
		; CoordMode, mouse, Screen
}

;; _____________________________LMS KEYBINDINGS____________________________
	#Ifwinactive, NuGenesis LMS ;; ___Nugenesis
		+^F10::
		if !(Iteration)
			SpecTab.FullRemoveTest()
		else
		{
			loop, %iteration%
				{
					SpecTab.FullRemoveTest()
					sleep 2000
					Breaking.Point()
				}
		}
			return


		; +F3::AddToList()
		mbutton:: 3tap()
		+mbutton::lms.Menu()
		F19::lms.Menu()
		F7::3Right()
		F6::3Left()
		Enter::LMS.SaveCode()
		>+F20::LMS.SearchbarPaste()
		+^v::LMS.SearchbarPaste()
		<^v::lms.searchbarPaste()
		!^+F3::  ;add a bunch of sample logtests
			Loop 20
			{
				Breaking.Point()
				MouseGetPos, xpos, ypos
				if winactive("NuGenesis LMS")
					Click, 2
				sleep 500
				Breaking.Point()
				if winactive("Edit test (Field Configuration: ")
					Sendinput,{Click, 402, 284}{end}{down 2}{shiftdown}{9}{shiftup}on sample log{shiftdown}{0}{shiftup}{click, 334, 618}
				Sleep 300
				winactivate, NuGenesis LMS
				sleep 400
				Breaking.Point()
				mousemove, xpos, ypos+26,0
				click
				sleep 300
				Breaking.Point()
			}
			return


	#ifwinactive, Edit test `(Field Configuration
			+Mbutton::
			F10::Send,{Click, 402, 284}{end}{down 2}{shiftdown}{9}{shiftup}on sample log{shiftdown}{0}{shiftup}{click, 334, 618}


	#Ifwinactive,Edit Ingredient
		Mbutton::
		Paste_Clipped_Ingredient:
		mouseclick, left, 244, 133,1,0
			sendinput, {tab 4}^{a}%clipped_Position%{tab}%clipped_LabelName%{tab 2}%clipped_LabelClaim%  ;click potencty box
			if (clipped_IngredientGroup)
				Sendinput, {Tab}%clipped_IngredientGroup%	;ingredientgroup
			mousemove, 280, 558, 0
			Tooltip
			return

	#Ifwinactive,Select Iterations
		^F9::LMS.PasteProductRotation()
	#Ifwinactive,Book
		+F9::LMS.CopyProductRotation()
	#Ifwinactive,Test Definition Editor
		enter::clk(333,615)
		mbutton::
		sleep 200
		if (Description)
			SpecTab.TestDefinitionEditor(Description) ; the pre window
			Breaking.Point()
			sleep 200
			MouseClick, left, 464, 532,2,0 ;click scrollbar
			click 239, 246  ;results link
			sleep 200
			Breaking.Point()
			winactivate, Results Definition
			sleep 100
			; clk(338,617)
			; sleep 400
			; clk(910,668)
			return
		+enter::sendinput, {enter}
	#Ifwinactive, Result Entry ;;___Result_Entry
		+Mbutton::worktab.fixrotation(20,1)
		F10::WorkTab.CorrectTestResults("loop")

	#Ifwinactive, Results Definition ;;__Results_Definition:
		Enter::
		mbutton::
			winactivate, Results Definition
			tooltip,
			Send,{click 80, 66} ;click edit
			sleep 200
			Breaking.Point()
			winwaitactive, Result Editor,,2
			if !errorlevel
				If (Clipped_specs){
					SpecTab.ResultEditor(Clipped_MinLimit,Clipped_MaxLimit,Clipped_Units,Clipped_Percision,1,Clipped_FullRequirement)
					clipped_Specs:=
					Breaking.Point()
					return
					}
				If (MinLimit || MaxLimit) && !(FullRequirement)
					SpecTab.ResultEditor(MinLimit,MaxLimit,Units,Percision,1,1)
				If (MinLimit || MaxLimit) && (FullRequirement)
					SpecTab.ResultEditor(MinLimit,MaxLimit,Units,Percision,1,FullRequirement)
				else
				{
					; inputbox, InputVar, Requirements, Requirements
					; FullRequirements:=InputVar
					inputbox, MinLimit, MinLimit, MinLimit
					inputbox, MaxLimit, MaxLimit, maxLimit
					inputbox, Units, Units, Units

					; Minlimit:=regexmatch(InputVar,Regexminlimit,r) ? Trim(rMinLimit, "`r`n") : 0
					; Maxlimit:=regexmatch(InputVar,Regexmaxlimit,r) ? Trim(rMaxLimit, "`r`n") : 0
					; Units:=regexmatch(InputVar,RegexUnit,r) ? trim(rUnit,"`r`n") : ""
					; sleep 200
					SpecTab.ResultEditor(MinLimit,MaxLimit,Units,"",1,1)
					minlimit:=
					maxlimit:=
					units:=
				}
				Breaking.Point()

				return
		; F10::lms.menu()
		+mbutton::lms.menu()
		+enter::sendinput, {enter}
; space::sendinput,{ctrldown}{click}{ctrlup}
	#ifwinactive, Register new samples ;;__Register_new_samples:
		F6::
			clk(181, 104,2,2)
			sleep 300
			Send, %Product%{enter}
			return

	#ifwinactive, New Document
		Enter::
			LMS.SaveCode()
			LMSclick.okay()
			return
		+enter::sendinput, {enter}
	#ifwinactive, Reason for Change
	#ifwinactive, Select tests for request:
		; space::send, ^{click}
		; rbutton::send, ^{click}
		; Numpaddot::send, {click 837, 656}{
	#ifwinactive, Edit request
		F10::Worktab.EditRequest()
	#ifwinactive, Select samples for test:
	#Ifwinactive, ahk_exe eln.exe ;;___LMS app
		;;^`::						ClipBar.reset()
		enter::						LMSclick.okay()
		+enter::					sendinput, {enter}
		^enter::					sendinput, {enter}
		esc::						LMSclick.esc()
		F8::						3down()
		F7::						3Right()
		F6::						3Left()
		+Mbutton::						4tap()
		^F10::						4tap()
		mbutton::					3tap()
		; +!F10::						3tap()
	#Ifwinactive,
		esc::						esc
		pause::						Suspend, Toggle
		#h::return
		#p::return
		#k::return
		>+Backspace::			Delete
		return



;;____________________TouchPad BINDINGS__________________________________________
	3tap(){
		Global
		; FlashScreen("3-Tap")

		If winactive("ahk_exe eln.exe") {
			if winactive("NuGenesis LMS"){ ; If Nugeneses
				LMS.DetectTab()
				if (Tab="Specs"){
						SpecTab.CopySpecTemplate()
						return
				}
				else if (Tab="Requests")
					clk(61, 635) ;enter results
				else if (Tab="Products")
					clk(67, 754) ;edit results
				else if (Tab="Samples"){
					; blockinput, on

					send, {click 124, 294} ;assign Requests
					sleep 500
					if winactive("Edit request")
						send, {click, 258, 613}
						; sleep 500
					sleep 800
					if winactive("Select tests for request: R")
						; sleep 500
					; winactivate, Select tests for request: R
						send, {click, 31, 102}

					; blockinput, off
				return
				}
				}
			else if winexist("Delete Test") || winexist("Delete Tests") || winexist("Delete results") || winexist("Delete sample templates") || winExist("Delete specification") { ; Press Okay
					winactivate,
					send, y
					clk(229, 136)
					return
				}
			else if winactive("Result Editor") {
					SpecTab.ResultEditor(MinLimit,MaxLimit,Units,Percision,1,FullRequirements)
				}
			else if winactive("Register new samples")
					WorkTab.registerNewSamples()
			else if winactive("Test Definition Editor")
					mouseclick, left, 333, 615
			else if winactive("Result Entry") {
					MouseGetPos, xpos, ypos
					; WorkTab.FixRotation(1,1)
					WorkTab.CorrectTestResults("toggle")
					mousemove, %xpos%, %yPos%+26,0
				}
			else if winactive("Edit specification")
					SpecTab.Edit_Analytical()
			else if winactive("Results Definition")
					lms.menu()
			else if winactive("Composition")
					ProductTab.Table()
			else if winactive("Select methods tests")
					clk(854, 658)
			; else If winactive("Select methods tests")
					; SpecTab.Table()
			else if winactive("Edit Formulation")
					productTab.AddNewFormulation()
			else if winactive("Select Product ahk_exe eln.exe")
					send % clk(107, 66) Product "{enter}{enter}"
			else if winactive("Edit request")
				WorkTab.EditRequest()
			else if winactive("Edit Product")
					ProductTab.AddNewProduct()
			else If winactive("Select tests for request: R")
					WorkTab.SelectTestSample()
			else if winexist("Release: ") || winexist("Release: Rotational Testing Schedule") { ; Press Okay
					winactivate,
					clk(131, 144)
				}
			else if winexist("Sign :") || winexist("windows Security") || winexist("CredentialUIBroker.exe")
				Sendpassword()
			}
			else
				return
	}


	3Right(){
		global
		if keep_running = y
		{
			keep_running = n ;signal other thread to stop
			return
		}
		keep_running = y
		; FlashScreen("3-Right")
		If winactive("NuGenesis LMS")
			LMS.SearchBar(Batch,"{enter}")
		else If winactive("Result Entry")
			WorkTab.CorrectTestResults()
		else If winactive("Select methods tests")
			SpecTab.Methods()
		else If winactive("Composition")
			Send, {enter}
		else If winactive("Test Definition Editor")
			clk(330, 619) ;click save
		else If winactive("Results Definition"){
			Send, {enter}
			sleep 200
			winactivate, "Test Definition Editor"
			clk(330, 619)
		}
		else if winactive("Register new samples")
			clk(502, 354)
		else if winactive("Select samples for test:") ; selecting the physical or micro
			send % Clk(504, 324) "{click, 849, 661}"  ; add test.
		else if winactive("Edit request (Field Configuration:")
			send, {click 332, 617} ;click save
		else if winactive("Select tests for request: R"){
				send, {click 504, 338}{click 846, 659}  ; add test.
				sleep 300
		}
		else if winactive("ahk_exe eln.exe")
			Send, %Batch%
		else
			Send, %Batch%
		keep_running = n
		return
		}
	3left(){
		global
		if keep_running = y
		{
			keep_running = n ;signal other thread to stop
			return
		}
		keep_running = y
		; FlashScreen("3-Left")
		if winactive("NuGenesis LMS")
				LMS.SearchBar(Product,"{enter}",0)
		else If winactive("Select methods tests")
			Send, {esc}
		else If winactive("Composition")
			Send, {esc}
		else If winactive("Test Definition Editor")
			Send, {esc}
		else If winactive("Results Definition")
			Send, {esc}
		else if winactive("Edit test (Field Configuration:")
			send, {esc}
		else if winactive("Edit sample template")
			Sendinput, {click 438, 84}{home}{delete 4}%Product%{enter}
		else if winactive("Register new samples")
			Send, {esc}
		else if winactive("Select samples for test:")
			Send, {esc}
		else If winactive("Result Entry")   ;Enter Test Results window"
			WorkTab.CorrectTestResults("toggle")
		else if winactive("ahk_exe eln.exe")
			Send, %Product%
		else
			send, %Product%
		keep_running = n
		return
	}
	3down(){
		global
		;FlashScreen("3-Down")
		if winactive("Select samples for test:")
			Clk(853, 657) ; click okay.
		return
	}
	3up(){
		global
		;FlashScreen("3-Up")
		if winactive("Results Definition")
			lms.menu()
		else if winactive("Result Entry")
			return
		else if winactive("Register new samples")
			LMS.SearchBar(Product,"{enter}")
		else If winactive("Select tests for request: R")
			mouseclick, Left, 638, 70
		else if winactive("Select samples for test:")
			send % Clk(250, 70) "{up}" ; click okay.
		else If winactive("Composition")
			return
		else
			return
	}
		;;	_____4Fingers
	4tap(){
		global
		; FlashScreen(tab)
			If winactive("NuGenesis LMS") {
				LMS.Detecttab()
				if (Tab="Requests") {
							MouseGetPos, mx, mY
							send, {click 2}
							sleep 500
								if !winactive("Edit test")
									winactivate
								sleep 300
								if winactive("NuGenesis LMS")
									mousemove, %mx%, %My% ,0
								return
						return
					}
					else If (tab:="Samples")
					lms.menu()
				else if (Tab:="Products")
						mouseclick, left, 78, 443 ;edit compositi
				else if (Tab="Specs")
						lms.menu()
				else
					return
			}
			else if winactive("Edit test"){
				sendinput, {click 384, 222}{tab 2}{end 2}
				sendinput, {shiftdown}{9}{shiftup}on sample log{shiftdown}{0}{shiftup}
				sendinput, {Click 334, 618}
			}
			else if winactive("Edit sample")
				worktab.CustomerMenu()
			; else if winactive("Composition")
				; ProductTab.AddCOASpace()
			else if winactive("Register new samples"){
				Send, {click}
				; Excel.Batches()
				winactivate, Register new samples
					sleep 200
					WorkTab.registerNewSamples()
					return
			}
			return
	}



#ifwinactive, ahk_exe eln.exe
	:*:osl`;::`(On Sample Log)
	:*:fm`;::`Finished, Micro
	:*:ia`;::`In Process, Analytical
	:*:iaa`;::`In Process, Analytical (Annual)
	:*:ip`;::`In Process, Physical
	:*:ir`;::`In Process, Retain
	:*:st`;::`Stability
	:*:cr`;::`Coated, Retain
	:*:ca`;::`Coated, Analytical
	:*:cp`;::`Coated, Physical
	:*:in`;::`ingredient
	; :*:pa`;::`P. aeruginosa
	:*:uc`;::`Update Total Coliforms Method
#Ifwinactive, Edit Formulation
	:*R:00`;::`#00 capsule / 0.917`" x 0.336`"
	:*R:00e`;::`#00 elongated capsule / 0.995`" x 0.336`"
	:*R:3`;::`#3 capsule / 0.626`" x 0.229`"
	:*R:2`;::`#2 capsule / 0.709`" x 0.250`"
	:*R:1`;::`#1 capsule / 0.765`" x 0.272`"
	:*R:0`;::`#0 capsule / 0.854`" x 0.300`"
	:*R:USP`;::`Meets USP Requirements
	:*R:fr`;::`Fixing Rotation
	:*R:7/16`;::`Round / 0.4375`"
	:*R:5.5o`;::`Oblong / 0.750`" x 0.313`"
	:*R:5.5ov`;::`Oval / 0.625`" x 0.344`"
	:*RR:5o`;::`Oblong / 0.750`" x 0.250`"
	:*:1s`;::
	sendinput, `Each (1) scoop (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:2s`;::
	sendinput, `Each two (2) scoop (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:3s`;::
	sendinput, `Each three (3) scoop (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:1sp`;::
	sendinput, `Each (1) stick packet (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:2sp`;::
	sendinput, `Each two (2) stick packet (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:3sp`;::
	sendinput, `Each three (3) stick packet (%ShapeAndSize% g) contains{tab}^{a}Blend{tab}^{a}%color%+{tab 2}^{left 3}{left}
	return
	:*:1c`;::`Each (1) capsule contains
	:*:2c`;::`Each two (2) capsules contains
	:*:3c`;::`Each three (3) capsules contains
	:*:4c`;::`Each four (4) capsules contains
	:*:5c`;::`Each five (5) capsules contains
	:*:6c`;::`Each six (6) capsules contains
	:*:7c`;::`Each seven (7) capsules contains
	:*:1t`;::`Each (1) tablet contains
	:*:2t`;::`Each two (2) tablets contains
	:*:3t`;::`Each three (3) tablets contains
	:*:4t`;::`Each four (4) tablets contains
	:*:5t`;::`Each five (5) tablets contains
	:*:6t`;::`Each six (6) tablets contains
	:*:7t`;::`Each seven (7) tablets contains

#ifwinactive


GetAllBatches(Delimiter:=" ",File:=""){
  global
  regBatches:=[]
		Haystack:=Clipboard
		PreClip:=Clipboard
		sleep 100
  while pos := RegexMatch(Haystack, "i)(?<!Ct#)\b\d{3}-\d{4}\b", aBatch, pos+1) ; {
      regBatches.insert(aBatch)
  ; }
      AllBatches:=[], oTemp := {}
      for vKey, vValue in regBatches
      {
          if (ObjGetCapacity([vValue], 1) = "") ;is numeric
          {
              if !ObjHasKey(oTemp, vValue+0)
                  AllBatches.Push(vValue+0), oTemp[vValue+0] := ""
          }
          else
          {
              if !ObjHasKey(oTemp, "" vValue)
                  AllBatches.Push("" vValue), oTemp["" vValue] := ""
          }
        }
    AllBatches:=Listarray(AllBatches,"")
    AllBatches:= StrReplace(AllBatches, A_space A_space, Delimiter)
    AllBatchesDDL:= StrReplace(AllBatches, A_space A_space, "`r`n")


    ; SimpleClip:=1
    sleep 20
		; clipboard:=AllBatches
		; LMS.Searchbar(AllBatches)
		sleep 200
		; send, ^v
		; TT(AllBatches)
    sleep 400
    ; SimpleClip:=1
    ;clipboard:=PreClip
	FileDelete, AllBatches.txt
	sleep 200
	FileAppend, %AllBatches%, AllBatches.txt
		clip.editbox(AllBatches)
		return AllBatches
}

GetAllProducts(Delimiter:=" ",File:=""){
  global
  regProducts:=[]
  pos=0
		Haystack:=Clipboard
		sleep 100
  while pos := RegexMatch(Haystack, RegexProduct, aProduct, pos+1) ; {
      regProducts.insert(aProduct)
  ; }
      AllProducts:=[], oTemp := {}
      for vKey, vValue in regProducts
      {
          if (ObjGetCapacity([vValue], 1) = "") ;is numeric
          {
              if !ObjHasKey(oTemp, vValue+0)
                  AllProducts.Push(vValue+0), oTemp[vValue+0] := ""
          }
          else
          {
              if !ObjHasKey(oTemp, "" vValue)
                  AllProducts.Push("" vValue), oTemp["" vValue] := ""
          }
        }
    AllProducts:=Listarray(AllProducts,"")
    AllProducts:= StrReplace(AllProducts, A_space A_space, Delimiter)
    ; SimpleClip:=1
    sleep 20
    ; clipboard:=AllProducts
    sleep 200
	; LMS.Searchbar(AllProducts)
    ;send, ^v
	; TT(AllProducts)
    sleep 400
    ; SimpleClip:=1
	FileDelete, AllProducts.txt
	sleep 200
	FileAppend, %AllProducts%, AllProducts.txt
	clip.editbox(AllProducts)
    ;clipboard:=Preclip
		Return AllProducts
}

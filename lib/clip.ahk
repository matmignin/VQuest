

Clip(input=0,Wait:="0.55"){
  global tab, Batch, Product, lot, coated, sampleid, analytical,micro,retain,physical,CTphysical,CTretain,department
  ; ClipboardSaved:=Clipboardall
  If Input contains OCR
  {
    ; BlockInput, on
    OCR()
    ; sleep 200
    ; BlockInput, Off
    return
  }
  clipboard:=
  if (input=="cut")
    Send, ^{x}{ctrlup}
  else
    Send, ^{c}{ctrlup}
  clipwait,%Wait%
  sleep %input%
  if errorlevel
  { 
    ; clipboard:=ClipboardSaved
    if (A_PriorKey != "F19") || (A_PriorhotKey != "Mbutton") || (A_PriorhotKey != "^Wheeldown")
      exit
    Send, {home}{shiftdown}{end}{shiftup}^{c}{ctrlup}
  }
  clip.Regex()
  return
}

clipChange(type){
  global
  ifwinactive, Select tests for request: R
    return
  ; if A_PriorKey:="^1"If
    ; exit
  sleep 50
    ; if !instr(Clipboard,"`r`n")
    clip.Parse()
    ; clip.Regex()
    ; if WinActive("ahk_exe WFICA32.EXE"){
      ; clip.Departmentregex()
      ; StringReplace, Clipboard, Clipboard,Value,111Skin Limited
      ; RegExMatch(HayStack, "i)[abdefghijkl]\d{3}", cProduct)
      ; tt(Clipboard,1000)
    if !PreventPopUp
      ; Pop(Clipboard,,1000)
      ; exit
    ; } 
    ; if Clipboard && !WinActive("ahk_exe EXCEL.EXE") && !WinActive("ahk_exe Code.exe") && !WinActive("NuGenesis LMS - \\Remote")
      ; exit
    if A_PriorKey = c
      tt(clipboard,200,100,-1500,,,"R")
      ; Pop(clipboard,,400) ;100,-1500,,150,"R")
    else if A_PriorKey = x
      tt(clipboard,200,100,-1500,,150,"R")
    if A_PriorKey = b
      return
return

}


Class Clip {
		EditBox(){
    Global EditBox
		try Gui, EditBox:Destroy
		result := Clipboard
		Gui EditBox: +AlwaysOnTop +ToolWindow +resize +owner +HwndGUIID
			GUI, EditBox:Font, s12 cBlack, Consolas
			Gui, EditBox:Add, Edit, x1 y1 W400 H200 +VScroll + Resize vEditBox , % Result 
			gui, EditBox:add, button, X1 y1 h2 w2 Hidden default gEditBoxButtonOK, OK
			Gui, EditBox:Show,, GUI Clipboard
			return
			EditBoxGuiClose:
			EditBoxGuiEscape:
			EditBoxButtonOK:
			Gui, EditBox:submit
			clipboard:=EditBox
			return
		}


CutSwap(){
  send, {lbutton up}
  preclip:=clipboard
  clipboard:=
  send, ^x
  Clipwait, 0.25
  postclip:=clipboard
  clipboard:=
  clipboard:=Preclip
  clipwait, 0.25
  send, ^v     
  clipboard:=PostClip
}
Append(Delimiter:="`n",key:="c"){
    global
		PreClip:=Clipboard
		Clipboard:=
		Send, ^%key%
		clipwait, 0.75
		if errorlevel
      clipboard:=Preclip
    else  
    {
      clipboard := Preclip Delimiter Clipboard
      tt(clipboard,1000,A_ScreenWidth-500,,2,150)
    }
		return 
}

;MsgBox, % (Clipboard ~= "i)[abdefghijkl]\d{3}")

Parse(Value:=""){
  global
  regProducts:=[], regBatches:=[],
  sleep 150
  PreventPopup:=1
    If !Value
      ParsedClipboard:=Clipboard
    else 
      ParsedClipboard:=Value
    loop, parse, ParsedClipboard, "`r`n" 
      {
        RegexMatch(A_loopField, "i)[abdefghijkl]\d{3}", VarProduct)
        RegexMatch(A_loopField, "i)(?<!Ct#)\d{3}-\d{4}\b", VarBatch)
        RegexMatch(A_loopField, "i)\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b", VarLot)
        RegExMatch(A_loopfield, "i)(coated: |ct#\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", Var)
        RegExMatch(A_loopfield, "i)(s|\$)\d{8}-\d{3}\b", VarSampleID)
          if VarProduct {
            Match:= VarProduct
            if varBatch
              Match.= " " VarBatch
            if varLot
              match.= " " VarLot    
            if varCoated
              match.= " " VarCoated 
            If ShowSampleId && VarSampleID 
              match.= " | " VarSampleID 
          }
          ; Match:= VarProduct
          if Match && A_Index = 1
              ; clip.regex()
              clip.Singleregex()
          else if Match && A_Index > 1
            regProducts.insert(Match)
      }
    if (RegProducts.maxindex() > 1) {
        Products:=[], oTemp := {} ;remove duplicates
        for vKey, vValue in regProducts {
        if (ObjGetCapacity([vValue], 1) = "") ;is numeric
          {
            if !ObjHasKey(oTemp, vValue+0)
              Products.Push(vValue+0), oTemp[vValue+0] := ""
          }
          else
          {
            if !ObjHasKey(oTemp, "" vValue)
              Products.Push("" vValue), oTemp["" vValue] := ""
          }
        }
      sleep 100
        filedelete, data\CurrentCodes.txt
        For Each, Element In Products 
          CurrentCodes .= Element "`n"
        FileAppend, %CurrentCodes%, data\CurrentCodes.txt
      }
      ; Pop(CurrentCodes,,500,"Right")
      PreventPopup:=
    IniWrite, `n%AllCodes%, Data\Products.ini, %The_Day%, %The_Hour%
    return
}
Cl3Parse(){
  global
  regProducts:=[], regBatches:=[],
  sleep 200
  ; if (Value:="")
    ParsedClipboard:=Clipboard
  ; else
    ; ParsedClipboard:=Value
  if !instr(ParsedClipboard,"`r`n"){
    CurrentCodes:=
    return
  }
    loop, parse, ParsedClipboard, "`r`n" 
      {
        RegexMatch(A_loopField, "i)[abdefghijkl]\d{3}", VarProduct)
        RegexMatch(A_loopField, "i)(?<!Ct#)\d{3}-\d{4}\b", VarBatch)
        RegexMatch(A_loopField, "i)\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b", VarLot)
        RegExMatch(A_loopfield, "i)(coated: |ct#\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", Var)
          Match:= VarProduct
            if varBatch
              Match.= " " VarBatch
            if varLot
              match.= " " VarLot    
            if varCoated
              match.= " Ct#" VarCoated  

          ; Match:= VarProduct
          if Match
            regProducts.insert(Match)
      }
    Products:=[], oTemp := {} ;remove duplicates
      for vKey, vValue in regProducts {
      if (ObjGetCapacity([vValue], 1) = "") ;is numeric
        {
          if !ObjHasKey(oTemp, vValue+0)
            Products.Push(vValue+0), oTemp[vValue+0] := ""
        }
        else
        {
          if !ObjHasKey(oTemp, "" vValue)
            Products.Push("" vValue), oTemp["" vValue] := ""
        }
      }
      sleep 200
      AllCodes:=Listarray(Products)
      ; Pop(AllCodes,,2000)
  
      ; GuiControl,Varbar:Text, Note1, %AllCodes%
    ; ; ControlsetText, Edit6,%AllProducts%,VarBar
    ;IniWrite, %AllCodes%, Data\Products.ini, Products, AllCodes


    return
}
SingleRegex(){
    global Batch, Product, lot, coated, sampleid, Products, CurrentCodes, ConnectedProducts
    ConnectedProducts:=[]

      Haystack:=Clipboard
    sleep      20
      RegExMatch(HayStack, "i)[abdefghijkl]\d{3}", cProduct)
      RegExMatch(HayStack, "i)(?<!Ct#)\d{3}-\d{4}\b", cBatch)
      RegExMatch(HayStack, "i)(\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b)", clot)
      ; RegExMatch(HayStack, "i)(coated: |ct#/\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", c)
      RegExMatch(HayStack, "i)(coated: |ct#\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", c)
      ; RegExMatch(HayStack, "i)(coated: |ct#/\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", c)
      ; If ShowSampleID
        ; RegExMatch(HayStack, "i)(s|\$)\d{8}-\d{3}\b", cSampleID)
      If cProduct {
        ConnectedProduct:= cProduct " " cBatch " " clot " " cCoated
        sleep 50
        ; FileAppend, `n%ConnectedProduct%`n, data\CurrentCodes.txt
        ; FileAppend, %ConnectedProduct%`n, data\RecentProducts.txt
        ; FileAppend, `n%CurrentCodes%, data\CurrentCodes.txt
        ; CurrentCodes.= ConnectedProduct
        Connectedproducts.Push("`n" Trim(ConnectedProduct) "`n")
        GuiControl,Varbar:Text, Product, %cProduct%
        Product:=cProduct
        IniWrite, %cProduct%, data.ini, Products, Product
      }
      If cBatch {
        GuiControl,Varbar:Text, Batch, %cBatch%
        Batch:=cBatch
        IniWrite, %cBatch%, data.ini, SavedVariables, Batch
      }
      If cLot {
        GuiControl,Varbar:Text, lot, %clot%
        lot:=cLot
        IniWrite, %cLot%, data.ini, SavedVariables, Lot
        ; varbar.show()
      }
      If !cLot {
        ; GuiControl,Varbar:Text, lot, %clot%
        lot:=cLot
        IniWrite, %cLot%, data.ini, SavedVariables, Lot
        ; varbar.show()
      }
      If !cCoated {
        GuiControl,Vajrbar:Text, Coated, %cCoated%
        Coated:=cCoated
        IniWrite, %cCoated%, data.ini, SavedVariables, Coated
        ; varbar.show()
      }
      If cCoated {
        GuiControl,Varbar:Text, Coated, %cCoated%
        IniWrite, %cCoated%, data.ini, SavedVariables, Coated
        ; varbar.show()
      }
      If cSampleID {
        GuiControl,Varbar:Text, SampleID, %cSampleID%
        ; varbar.show()
      }
    }
  
Regex(Category:=""){
    global Batch, Batch0, Product, Product0, Product1, Product2, Product3, lot, coated, sampleid, analytical,micro,retain,physical,CTphysical,CTretain, products, Department, 
    if !Category
      Haystack:=Clipboard
    else 
      Haystack:=Category
    sleep      20
      RegExMatch(HayStack, "i)[abdefghijkl]\d{3}", cProduct)
      RegExMatch(HayStack, "i)(?<!Ct#)\d{3}-\d{4}\b", cBatch)
      RegExMatch(HayStack, "i)(\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b)", clot)
      RegExMatch(HayStack, "i)(coated: |ct#\s|Ct#|ct\s|coated\s)(?P<Coated>\d{3}-\d{4})", c)
      ; RegExMatch(HayStack, "i)(s|\$)\d{8}-\d{3}\b", cSampleID)
      ; StringReplace, cSampleID, cSampleID, $, S
      ; If cProduct && cBatch && clot 
        ; FileAppend, %cProduct% %cBatch% %clot% %Coated%`n, data\CurrentCodes.txt
      If cProduct {
        GuiControl,Varbar:Text, Product, %cProduct%
        Product:=cProduct
        IniWrite, %cProduct%, data.ini, Products, Product
        FileAppend, `n`t%cProduct% %cBatch% %clot% %cCoated% `n, Data\CurrentCodes.txt
      }
      If cBatch {
        GuiControl,Varbar:Text, Batch, %cBatch%
        Batch:=cBatch
        IniWrite, %cBatch%, data.ini, SavedVariables, Batch
      }
      If cLot {
        GuiControl,Varbar:Text, lot, %clot%
        lot:=cLot
        IniWrite, %cLot%, data.ini, SavedVariables, Lot
        ; varbar.show()
      }
      If !cLot {
        ; GuiControl,Varbar:Text, lot, %clot%
        lot:=cLot
        IniWrite, %cLot%, data.ini, SavedVariables, Lot
        ; varbar.show()
      }
      If !cCoated {
        GuiControl,Vajrbar:Text, Coated, %cCoated%
        Coated:=cCoated
        IniWrite, %cCoated%, data.ini, SavedVariables, Coated
        ; varbar.show()
      }
      If cCoated {
        GuiControl,Varbar:Text, Coated, %cCoated%
        IniWrite, %cCoated%, data.ini, SavedVariables, Coated
        varbar.show()
      }
      If cSampleID {
        GuiControl,Varbar:text, SampleID, %cSampleID%
            IniWrite, %cSampleID%, data.ini, SavedVariables, SampleID
      }


      sleep 20
      Regexmatch(HayStack, "i)(Analytical \(In Process\)|\bI, Analytical\b|\bIn Process, Analytical\b)", cAnalytical)
      Regexmatch(HayStack, "i)((?!\bFinished, )Micro\b|(?!\bF, )Micro\b|\bMicro(?= \(Finished\))|\bMicro(?= Lab\b))",cMicro)
      Regexmatch(HayStack, "i)(\bI, Retain\b|\bIn Process, Retain\b|\bRetain \(In)", cRetain)
      Regexmatch(HayStack, "i)(\bI, Physical\b|\bPhysical\b|In Process, Physical\b|\bPhysical \(In Process\))", cPhysical)
      Regexmatch(HayStack, "i)(\bCT, Physical\b|Coated, Physical\b|\bCoated, Physical\b|Physical \(Coated\)", cCTPhysical)
      Regexmatch(HayStack, "i)(\bCT, Retain\|Coated, Retain\b|Retain \(Coated\))", cCTRetain)
      Sleep      20
      If cAnalytical
        Department:="Analytical"
      If cMicro
        Department:="Micro"
      If cRetain
        Department:="Retain"
      If cCTRetain
        Department:="Retain (Coated)"
      If cPhysical
        Department:="Physical"
      If cCTPhysical
        Department:="Physical (Coated)"
  return 


  }
DepartmentRegex(){
    global analytical,micro,retain,physical,CTphysical,CTretain, Department, 
      Haystack:=Clipboard
      Regexmatch(HayStack, "i)(Analytical \(In Process\)|\bI, Analytical\b|\bIn Process, Analytical\b)", cAnalytical)
      Regexmatch(HayStack, "i)((?!\bFinished, )Micro\b|(?!\bF, )Micro\b|\bMicro(?= \(Finished\))|\bMicro(?= Lab\b))",cMicro)
      Regexmatch(HayStack, "i)(\bI, Retain\b|\bIn Process, Retain\b|\bRetain \(In)", cRetain)
      Regexmatch(HayStack, "i)(\bI, Physical\b|\bPhysical\b|In Process, Physical\b|\bPhysical \(In Process\))", cPhysical)
      Regexmatch(HayStack, "i)(\bCT, Physical\b|Coated, Physical\b|\bCoated, Physical\b|Physical \(Coated\)", cCTPhysical)
      Regexmatch(HayStack, "i)(\bCT, Retain\|Coated, Retain\b|Retain \(Coated\))", cCTRetain)
      Sleep      20
      If cAnalytical
        Department:="Analytical"
      If cMicro
        Department:="Micro"
      If cRetain
        Department:="Retain"
      If cCTRetain
        Department:="Retain (Coated)"
      If cPhysical
        Department:="Physical"
      If cCTPhysical
        Department:="Physical (Coated)"
  return 


  }
IfNothingSelected(Action){
  global
    ClipboardSaved:=ClipboardAll
    clipboard:=
    ; sleep 20
    Send, ^c
      clipwait,0.40
  if errorlevel ;if nothing selected
  {
    if Action:="SelectLine"
      Send, {home}+{end}^{c}
    if Action:="SelectAll"
      Send, ^{a}^{c}{ctrlup}
    if Action:="Select"
      Send, {click 3}^{c}{ctrlup}
    If Action:="cut"
      {
        ; clipboard:=
        Send, ^{x}
        clipwait, 0.45
        PostCut:=ClipboardAll
        clipboard:=ClipboardSaved
        sleep 35
        Send, ^{v}
        clipboard:=PostCut
      }
    if Action:="menu"
      menu.Variable()
    If Action:="Paste"
    {
      clipboard:=ClipboardSaved
      Send, ^{v}{ctrlup}
    }
    else
      send % Action
    return
  }
  else 
  return
}

ClickText(button:=""){
	mousegetpos, mousex, mousey
	SetDefaultMouseSpeed, 0
	Click, %A_CaretX% %A_caretY%, %button%
	mousemove, %mousex%, %mousey%, 0
	SetDefaultMouseSpeed, 1
}

Copy(){
  Global
    preclip:=Clipboardall
      Send, {ctrlup}{altup}{shiftup}
    KeyWait, F19, T0.20
    If ErrorLevel
    {
        KeyWait, F19, T0.65
        if (A_PriorKey!="F19") ;allows for other key combos
          exit
        if (A_PriorKey="F19") {  
        If !ErrorLevel
        {
          This.Copy("cut") ; will trigger less 1 secReturnReturnErrorLevel ClipChainPasteDoubleClickClipChainPasteDoubleClick
          Return
        }
        Else ;will trigger after 1 sec
          Send, +{F18}
          ; KeyWait, F20,
          Return
      }
    }
    clipboard:=
    Send, ^{c}
    clipwait, 0.75
    if errorlevel {
      clipboard:=Preclip
      return
    }
    TT(Clipboard)
    ; clip.Regex()

      return
  }


Paste(){
  global Clippaste
    if (ClipPaste) {
      Send, ^{v}
      return
  }
    KeyWait, F19, T0.30
    If ErrorLevel
    {
        KeyWait, F19, T2
        if (A_PriorKey!="F19")
          exit
        if (A_PriorKey="F19")
        If !ErrorLevel
        {
          ; Send, {F20}
          Return
        }
          KeyWait, F19, T2
          Return
      }
    if Errorlevel = 0
    KeyWait, F19, T0.60
      if !ErrorLevel
      {
        If (A_ThisHotkey=A_PriorHotkey && A_TimeSincePriorHotkey<400) ;if double clic
            send % BlockRepeat(300) "^{v}"
            ; wheel_paste()
          Else
          Clip.Append()
            return
      }
      return
    }
ctrl(){
  Global clippaste
      if (ClipPaste = 1){
        Send, {ctrldown}{v}{ctrlup}
        return
      }
    KeyWait, F19, T0.30
    If ErrorLevel
    {
        KeyWait, F19, T2
        if (A_PriorKey!="F19")
          exit
        if (A_PriorKey="F19")
        If !ErrorLevel
        {
          ; Send, {F20}
          Return
        }
          KeyWait, F19, T4
          Return
      }
    if Errorlevel = 0
    KeyWait, F19, T0.60
      if !ErrorLevel
      {
        If (A_ThisHotkey=A_PriorHotkey && A_TimeSincePriorHotkey<400) ;if double clic
          send % BlockRepeat(300) "^{v}"
            ; wheel_paste()
          Else
            return
      }
            ; Send, 
      return
    }
}
; Click(){
;     global
;   MouseGetPos, xx
;   TimeButtonDown = %A_TickCount%
;   ; Wait for it to be released
;   Loop
;   {
;     Sleep 10
;     GetKeyState, LButtonState, LButton, P
;     if LButtonState = U  ; Button has been released.
;     {
;         If WinActive("Crimson Editor") and (xx < 25) ; Single Click in the Selection Area of CE
;         {
;           ;  clip()
;           Send, ^{c}
;           return
;         }
;         break
;     }
;     elapsed = %A_TickCount%
;     elapsed -= %TimeButtonDown%
;     if elapsed > 200  ; Button was held down too long, so assume it's not a double-click.
;     {
;         MouseGetPos x0, y0            ; save start mouse position
;         Loop
;     {
;       Sleep 20                    ; yield time to others
;       GetKeyState keystate, LButton
;       IfEqual keystate, U, {
;         MouseGetPos x, y          ; position when button released
;         break
;       }
;     }
;     if (x-x0 > 5 or x-x0 < -5 or y-y0 > 5 or y-y0 < -5)
;     {                             ; mouse has moved
;         clip0 := ClipBoardAll      ; save old clipboard
;         ClipBoard =
;         ; Clip()                   ; selection -> clipboard
;         Send, {ctrldown}{c}{ctrlup}
;         ClipWait 1, 1              ; restore clipboard if no data
;         IfEqual ClipBoard,, SetEnv ClipBoard, %clip0%
;     }
;         return
;     }
;   }
;   ; Otherwise, button was released quickly enough.  Wait to see if it's a double-click:
;   TimeButtonUp = %A_TickCount%
;   Loop
;   {
;     Sleep 10
;     GetKeyState, LButtonState, LButton, P
;     if LButtonState = D  ; Button has been pressed down again.
;         break
;     elapsed = %A_TickCount%
;     elapsed -= %TimeButtonUp%
;     if elapsed > 350  ; No click has occurred within the allowed time, so assume it's not a double-click.
;         return
;   }
;   ;Button pressed down again, it's at least a double-click
;   TimeButtonUp2 = %A_TickCount%
;   Loop
;   {
;     Sleep 10
;     GetKeyState, LButtonState2, LButton, P
;     if LButtonState2 = U  ; Button has been released a 2nd time, let's see if it's a tripple-click.
;         break
;   }
;   ;Button released a 2nd time
;   TimeButtonUp3 = %A_TickCount%
;   Loop
;   {
;     Sleep 10
;     GetKeyState, LButtonState3, LButton, P
;     if LButtonState3 = D  ; Button has been pressed down a 3rd time.
;         break
;     elapsed = %A_TickCount%
;     elapsed -= %TimeButtonUp%
;     if elapsed > 350  ; No click has occurred within the allowed time, so assume it's not a tripple-click.
;     {  ;Double-click
;         Send, {ctrldown}{c}{ctrlup}
;         ; clip()
;         return
;     }
;   }
;   ;Tripple-click:
;     Sleep, 100
;     Send, {ctrldown}{a}{ctrlup}
;     sleep 100
;     Send, {ctrldown}{c}{ctrlup}
;     ;  clip()
;   return
    
;     return
;   }





; Paste(){
;   global Clippaste, varbar_x, Varbar_y
;     if (ClipPaste = 1){
;       Send, {ctrldown}{v}{ctrlup}
;       return
;   }
;   ClipboardSaved:=ClipboardAll
;   clipboard:=
;     Clip()
;   clipwait,0.10
;   if errorlevel 
;     {
;     clipboard:=ClipboardSaved
;      StrReplace(clipboard, "`n", "")
;       Send, {ctrldown}{v}{ctrlup}
;       ;tt("paste",,100,100,,150)
;     }
;   else
;       ; tt(clipboard,,varbar_x,varbar_y,,50)
;       sleep 500
;     return 
;   }



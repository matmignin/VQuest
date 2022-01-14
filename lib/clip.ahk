;#include *i C:\Users\mmignin\Documents\VQuest\lib\Functions.ahk


Clip(input=0,Wait:="0.45"){
  global tab, Batch, Product, lot, coated, sampleid, analytical,micro,retain,physical,CTphysical,CTretain,department, regexProduct
  If Input contains OCR
    OCR()
    return
  clipboard:=
    Send, ^{c}
  clipwait,%Wait%
  sleep %input%
  if errorlevel
  {
    tt("clip error level")
    sleep 100
  }
  clip.Regex()
  return
}

clipChange(type){
  global
  ifwinactive, Select tests for request: R
    return
  sleep 50
    clip.Parse()
    if winactive("ahk_exe WFICA32.EXE"){
      clip.Department()
    if A_PriorKey = c
      FloVar(Clipboard,3000,13)
    else if A_PriorKey = F19
      FloVar(Clipboard,3000,13)
    else if A_PriorKey = x
      FloVar(Clipboard,3000,13)
    if A_PriorKey = b
      return
}

}



Class Clip {

EditBox(Input:=""){
  Global EditBox
	try GUI, EditBox:Destroy
  if !Input
		Result := Clipboard
  else
    result := Text
	Gui EditBox: +AlwaysOnTop +Toolwindow +Resize +owner +HwndGUIID
		GUI, EditBox:Font, s12 cBlack, Consolas
    gui, editbox:Margin,1,1
		GUI, EditBox:Add, Edit, x0 y0 +Resize vEditBox , % Result
		GUI, EditBox:add, button, X0 y0 h0 w0 Hidden default gEditBoxButtonOK, OK
		GUI, EditBox:Show,Autosize, Clipboard
    winSet, Transparent, 100, EditBox
		return
		EditBoxGuiClose:
		EditBoxGuiEscape:
		EditBoxButtonOK:
		GUI, EditBox:submit
    if !Text
			clipboard:=EditBox
    sleep 50
  TT(Editbox,500,,,,200)
		return

    EditBoxGuiSize:
  if (ErrorLevel = 1)  ; The window has been minimized. No action needed.
      return
    NewWidth := A_GuiWidth
    NewHeight := A_GuiHeight
    GuiControl, Move, EditBox, W%NewWidth% H%NewHeight%
    return

	}













Append(Delimiter:="`n"){
    global
		PreClip:=Clipboard
		Clipboard:=
		Send, ^c
    sleep 75
		; clipwait, 0.75
		if errorlevel
      clipboard:=Preclip
    else
    {
      tt(Preclip "`n `t __________________ `n" clipboard)
      clipboard := Preclip Delimiter Clipboard
      sleep 50
      ; tt(clipboard,1000,A_ScreenWidth-500,,2,150)
    }
		return
}

CodesRegex(input:=""){
  global RegexProduct, RegexBatch, RegexLot, RegexCoated, rProduct, rLot, rBatch, rCoated, r
      Parse:= Input ? Input : Clipboard
        RegexMatch(Parse, RegexProduct,r)
        RegexMatch(Parse, RegexLot, r)
        RegexMatch(Parse, RegexBatch, r)
        RegExMatch(Parse, RegexCoated, r)
      if rCoated
        Ct:=" ct#"
     Return Trim(rProduct " " rBatch " " rLot Ct rCoated)
}

Parse(Value:=""){
  global
  Gui Varbar:Default
  regProducts:=[], regBatches:=[],
  sleep 150
    ParsedClipboard:= Value ? Value : Clipboard
  loop, parse, ParsedClipboard, "`r`n"
    {
      ; clip.codesRegex(A_LoopField)
      Totalclips.=clip.CodesRegex(A_LoopField) "`n"
        if A_Index = 1 ; if first line
        {
          this.SetVarbar()
            clip.Singleregex()
        }
        ;else if Match && A_Index > 1
        else if A_Index > 1
          regProducts.insert(clip.CodesRegex(A_LoopField))
      if (RegProducts.maxindex() > 1) { ;remove duplicates from array
          Products:=[], oTemp := {}
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
          For Each, Element In Products {
            CurrentCodes .= Element "`n"
          }
          ; RemoveTextDuplicates(CurrentCodes)
          sleep 100
          FileAppend, %CurrentCodes%, data\CurrentCodes.txt
          sleep 100
          RemoveFileDuplicates("C:\Users\mmignin\Documents\VQuest\Data\CurrentCodes.txt")
          sleep 100
                    ; RegProducts.InsertAt(1, Trim(Match))
                    ; gui, Varbar:Default
                    ; Gui, Varbar:+Delimiter`n
                    ; GuiControl,, DDL, % CurrentCodes := "`n" Trim(Match) "`n`n" Trim(StrReplace(CurrentCodes, "`n`n", "`n"), "`n")
          ; DDL:=
          ; GuiControl,,DDL,
          ; GuiControl, Varbar:MoveDraw, DDL
          ; guicontrol, ChooseString, ComboBox1, %Product%
        }
        ; Pop(CurrentCodes,,500,"Right")
      ; return
    }
    return
}
SetVarbar(){
  ConnectedProduct:=
  global
if rProduct {
        GUI, Varbar:font, cBlack s16  Norm w700, Consolas
        GuiControl,Varbar:Text, Product, %rProduct%
        GuiControl, Font, Product
        Product:=rProduct
        ConnectedProduct.=rProduct
      }
      If rBatch {
        GUI, Varbar:font, cBlack s12 Norm W700 ,Consolas
        GuiControl,Varbar:Text, Batch, %rBatch%
        GuiControl, Font, Batch
        Batch:=rBatch
        ConnectedProduct.= " " rBatch
      }
      If rLot {
        GUI, Varbar:font, cBlack s10 Norm w600 , Consolas
        GuiControl,Varbar:Text, lot, %rlot%
        GuiControl, Font, Lot
        lot:=rLot
        ConnectedProduct.= " " rLot
      }
      If rCoated {
        GUI, Varbar:font, cBlack s8.5 Norm w600, Arial Narrow
        GuiControl,Varbar:Text, Coated, %rCoated%
        GuiControl, Font, Coated
        Coated:=rCoated
        ConnectedProduct.= " ct#" rCoated
      }
      this.SetColor()
      if !rProduct {
        GUI, Varbar:font, c272822 s10  Right italic w300, Arial Narrow
        GuiControl, Font, Product
        ; GuiControl,Varbar:Text, Product, %rProduct%
        Poduct:=rProduct
      }
      If !rBatch {
        GUI, Varbar:font, c272822 s10 italic right w300, Arial Narrow
        GuiControl, Font, Batch
        ; GuiControl,Varbar:Text, Batch, %rBatch%
        Batch:=rBatch
      }
      If !rLot {
        GUI, Varbar:font, c272822  s10 italic  Right w300, Arial Narrow
        GuiControl, Font, lot
        ; GuiControl,Varbar:Text, lot, %rlot%
        lot:=rLot
      }
      If !rCoated {
        GuiControl, Font, Coated
        GUI, Varbar:font, c272822  s10 Italic Right w300, Arial Narrow
        ; GuiControl,Varbar:Text, Coated, %rCoated%
        Coated:=rCoated
      }
      this.AddtoList(ConnectedProduct)
}


SingleRegex(){
    global
    ; ConnectedProducts:=[]
    Gui Varbar:Default
    ConnectedProduct:=
      Haystack:=Clipboard
    sleep      20
      ; RegExMatch(HayStack, regexProduct,rProduct)
      ; RegExMatch(HayStack, regexBatch, rBatch)
      ; RegExMatch(HayStack, regexLot, rlot)
      ; RegExMatch(HayStack, regexCoated, r)
      sleep 50
      if rProduct {
        GUI, Varbar:font, cBlack s16  Norm w700, Consolas
        GuiControl,Varbar:Text, Product, %rProduct%
        GuiControl, Font, Product
        Product:=rProduct
        ConnectedProduct.=rProduct
      }
      If rBatch {
        GUI, Varbar:font, cBlack s12 Norm W700 ,Consolas
        GuiControl,Varbar:Text, Batch, %rBatch%
        GuiControl, Font, Batch
        Batch:=rBatch
        ConnectedProduct.= " " rBatch
      }
      If rLot {
        GUI, Varbar:font, cBlack s10 Norm w600 , Consolas
        GuiControl,Varbar:Text, lot, %rlot%
        GuiControl, Font, Lot
        lot:=rLot
        ConnectedProduct.= " " rLot
      }
      If rCoated {
        GUI, Varbar:font, cBlack s8.5 Norm w600, Arial Narrow
        GuiControl,Varbar:Text, Coated, %rCoated%
        GuiControl, Font, Coated
        Coated:=rCoated
        ConnectedProduct.= " ct#" rCoated
      }

      if !rProduct {
        GUI, Varbar:font, c272822 s10  Right italic w300, Arial Narrow
        GuiControl, Font, Product
        ; GuiControl,Varbar:Text, Product, %rProduct%
        Poduct:=rProduct
      }
      If !rBatch {
        GUI, Varbar:font, c272822 s10 italic right w300, Arial Narrow
        GuiControl, Font, Batch
        ; GuiControl,Varbar:Text, Batch, %rBatch%
        Batch:=rBatch
      }
      If !rLot {
        GUI, Varbar:font, c272822  s10 italic  Right w300, Arial Narrow
        GuiControl, Font, lot
        ; GuiControl,Varbar:Text, lot, %rlot%
        lot:=rLot
      }
      If !rCoated {
        GuiControl, Font, Coated
        GUI, Varbar:font, c272822  s10 Italic Right w300, Arial Narrow
        ; GuiControl,Varbar:Text, Coated, %rCoated%
        Coated:=rCoated
      }
      this.AddtoList(ConnectedProduct)
        ; GuiControl, ChooseString, Combobox1, %ConnectedProduct%
       UpdateDDLlist:
          Gui Varbar:Default
          Gui Varbar:+Delimiter`n
          gui varbar:submit, nohide
          this.AddtoList(ConnectedProduct)
          ; GuiControl,,DDL, % ConnectedProduct "`n" ;CurrentCodes ;StrReplace(CurrentCodes, "`r`n", "|")
          ; GuiControl, MoveDraw, ComboBox1

      ; If cSampleID {
        ; GuiControl,Varbar:Text, SampleID, %cSampleID%
      ; }
    }

Regex(Category:=""){
    global
    if !Category
      Haystack:=Clipboard
    else
      Haystack:=Category
    sleep      20
      Gui Varbar:Default
      RegExMatch(HayStack, RegexProduct,r)  ;"i)[abdefghijkl]\d{3}", rProduct)
      RegExMatch(HayStack, RegexBatch, r)
      RegExMatch(HayStack, RegexLot, r)
      RegExMatch(HayStack, RegexCoated, r)
      If rProduct && rBatch && rlot || rCoated
        FileAppend, %rProduct% %rBatch% %rlot% %rCoated%, data\CurrentCodes.txt
      If rProduct {
        GuiControl,Varbar:Text, Product, %rProduct%
        Product:=rProduct
        ; IniWrite, %rProduct%, Settings.ini, Products, Product
        ; AppendCode:="`n" rProduct " " rBatch " " rlot "  Ct#" rCoated
        ; TimmedAppendcode:=Trim(AppendCode)
        ; FileAppend,%TrimmedAppendCode%, Data\CurrentC.txt
      }
      If rBatch {
        GuiControl,Varbar:Text, Batch, %rBatch%
        Batch:=rBatch

      }
      If rLot {
        GuiControl,Varbar:Text, lot, %rlot%
        lot:=rLot
      }
      If rCoated {
        GuiControl,Varbar:Text, Coated, %rCoated%
        Coated:=rCoated
      }
      If !rLot {
        GuiControl,Varbar:Text, lot, %rlot%
        lot:=
      }
      If !rCoated {
        GuiControl,Varbar:Text, Coated, %rCoated%
        Coated:=
      }
      ; GuiControl, Varbar:MoveDraw, Coated
      ; gui varbar:submit, nohide
      FloVar(0,2000,16)
      sleep 20
  }
Department(DepartmentInput:=""){
  global Department
      Department:=
     if !DepartmentInput
      DepartmentHaystack:=Clipboard
    else
      DepartmentHaystack:=DepartmentInput
      sleep 100
      ; Regexmatch(DepartmentHaystack, "i)(Analytical \(In Process\)|I, Analytical|In Process, Analytical)", Analytical)
      ; Regexmatch(DepartmentHaystack, "i)(\bI, Physical\b|In Process, Physical\b|\bPhysical \(In Process\))", cPhysical)
      Regexmatch(DepartmentHaystack, "F,\sMicro",Micro)
      Regexmatch(DepartmentHaystack, "I,\sRetain", Retain)
      Regexmatch(DepartmentHaystack, "I,\sPhysical", Physical)
      Regexmatch(DepartmentHaystack, "CT,\sPhysical", ctPhysical)
      Regexmatch(DepartmentHaystack, "CT,\sRetain", ctRetain)
      Sleep      20
      If Micro
        Department:="Micro"
      else If Retain
        Department:="Retain"
      else If ctRetain
        Department:="ctRetain"
      else If Physical
        Department:="Physical"
      else If ctPhysical
        Department:="ctPhysical"
      ; else If Analytical
        ; Department:="Analytical"
      else
        msgbox % "`nDepartment: " Department "`nmicro: " micro "`nretain: " retain "`nctretain: " ctretain "`nphysical: " physical "`nctphysical: " ctphysical "`nanalytical: " analytical
      ; sleep 300
      ; tt(Department)
  return %Department%
}

IfNothingSelected(action){
  global
    ClipboardSaved:=ClipboardAll
    clipboard:=
    ; sleep 20
    Send, ^c
      clipwait,0.40
  if errorlevel ;if nothing selected
  {
    if action:="SelectLine"
      Send, {home}+{end}^{c}
    if action:="SelectAll"
      Send, ^{a}^{c}{ctrlup}
    if action:="Select"
      Send, {click 3}^{c}{ctrlup}
    If action:="cut"
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
    if action:="menu"
      menu.Variable()
    If action:="Paste"
    {
      clipboard:=ClipboardSaved
      Send, ^{v}{ctrlup}
    }
    else
      send % action
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






}







;^(?<Customer>[\w ]*)\s(?!(\s|# ?)?(\d{6}))?.*(?<=\w{3})(?<Product>[abdefghijkl]\d{3})(?=\w{4}).*(?<PillType>(Capsule|Tablet)(?: size:)) (?<PillSize>[\w ]*).*(?:Serving Size: )(?<ServingSize>\d+) (?<ServingType>[\w ]+).+(?:%.Daily Value)\s+(?<Ingredients>[\w.].*)(?=\sDaily Value)

 #If A_debuggerName
  Media_Prev::						F6 ;MakeTransparent()
	Media_Play_Pause::			Numlock
	Media_Next::						F7
#if
#if

; #If Mode("TempCode")
TEST_1: ;;||||||||||||||||||||||||||||||||||||||||||||||| TEST 1 ||||||||||||||||||||||||||||||||||||||||||||||||||||
CopyNewestFile("K880")
return


TEST_2: ;;||||||||||||||||||||||||||||||||||||||||||||||| TEST 2 ||||||||||||||||||||||||||||||||||||||||||||||||||||
  tProduct:="K796"
  tRegexSearchPattern:="i)^(?<Customer>[\w ]*(?!(\s|# ?)?(\d{6})))(?:.*)(?<Product>(?<=\w{3})[abdefghijkl]\d{3})(?=\w{4})(?:.*)(?<PillSize>(?<=size: )#[0{2})[ \w]*)(?:(?:.*\d, \d{4}\.)(?:.{2}))(?<Name>[\w ]*(?!Dietary Supplement))(?:.*)(?<ServingSize>\d+) (?<ServingType>[\w ]+)(?:.+)(?:%.Daily Value)(?:\s+)(?<Ingredients>[\w.].*)(?:Daily Value.*)"
  tRegexReplacePattern:="i)(((\d)%$)|(\Q*\E))"
  ;WordText:=
  sleep 300
  clip.EditBox(CopyWordDoc(tProduct,tRegexSearchPattern,tRegexReplacePattern))
  ; send, ^v
  return


; CopySourcePattern:="C:\Users\mmignin\Desktop\Desktop Stuff\Label Copy\All Label Copy"

CopyNewestFile(ProductToSearch:="entery", CopySourcePattern:="\\10.1.2.118\Label Copy Final\K000 - K999"){
  Loop, Files, %copySourcePattern%\label %ProductToSearch%*.docx
  {
      copy_it := false
      if not FileExist(CopyDest "\" A_LoopFileName)        ; Always copy if target file doesn't yet exist.
          copy_it := true
      else
      {
          FileGetTime, time, %CopyDest%\%A_LoopFileName%
          EnvSub, time, %A_LoopFileTimeModified%, seconds  ; Subtract the source file's time from the destination's.
          if (time < 0)                                    ; Source file is newer than destination file.
              copy_it := true
      }
      if copy_it
      {
          Latest_File:=A_LoopFilePath                      ; file path
          if ErrorLevel
            return
      }
  }
      traytip, %Latest_File%
  Return % Latest_File
}



CopyWordDoc(ProductToFind, RegexSearchPattern, RegexReplacePattern){
  doc_path := CopyNewestFile(ProductToFind)                   ; search for newst file that matches Product
    sleep 200
  oDoc := ComObjGet(doc_path)                                   ; access Word Doc
  clipboard:=                                                   ; empty clipboard
  oDoc.range.copy()                                       -
  clipwait, 1                                                   ; wait for clipboard
    sleep 300
  oDoc.close()                                                  ; close Word Doc
  WordText:=Clipboard                                           ; put text into clipboard
  RegExMatch(WordText,RegexSearchPattern,Reged)
  sleep 200               ; Search with Regex
  return % regexreplace(RegedIngredients, RegexReplacePattern)
}


#if


  return

  ; F19::
  ; loop, read, Data\CurrentCodes.txt
			; CurrentCodes .= "|yoyoyoyo||yeyeyey"
  return
  ;Mbutton::GetAllBatches()

  Update_Varbar_Dropdown:
    Gui Varbar:Default
    GuiControl,,DDL, % "K999||"
    return

  Select_Dropdown_Menu_on_VarBar:
            Gui Varbar:Default
  					GuiControl, ChooseString, ComboBox1, Debugging
						Excel.Connect(1)
            GUI, Varbar:Submit, nohide
            TT(A_mode)
            Varbar.SetColor()
						return    ;excel.FindAndReplace("Stage","Specs","B:B",0,1)
  ; F15:


;   send, {click 39, 611}
; 		if !winactive("Edit test (Field Configuration: ")
;     	winwaitactive, Edit test (Field Configuration: ,, 2
;     Send,{Click, 402, 284}{end}(on sample log){click, 334, 618}
;     return



; #If winactive("Edit specification - \\Remote") && TempCode
;   ; Mbutton:: gosub, NewVersionRAE
; #If winactive("Select methods tests - \\Remote") && TempCode
; #If winactive("Results Definition - \\Remote") && TempCode
;     Mbutton::send, {enter}
;     numlock::gosub, AddRAE_ResultsDefinition
;     rbutton::menu.lms()
;     ; Lbutton::
; #If mouseisover("NuGenesis LMS - \\Remote") && TempCode
;   ; NumLock::gosub, AddRAE ;Send, {Click 83, 560} ; click edit method
;   ; F20::gosub, CheckExcelRow
;   ; F15::gosub, CheckExcelRow

return
#if


return
; Select_next_batch_in_array:
SelectPreviousBatch(){
  global
  n+=1
  Haystack:=Products[n]
  whereAt:=listarray(Products)
  whereatsplit:=StrReplace(whereAt, n ": ","`t" )
  pop(whereatsplit)
  clip.regex(Haystack)
  ; RegExMatch(Haystack, "i)(?<Product>([abdefghijkl]\d{3})?).?(?<Batch>(\d{3}-\d{4})?).?(?<Lot>(\d{4}\w\d\w?|Bulk|G\d{7}\w?)?).?(Ct#)?(?<Coated>(\d{3}-\d{4})?)", s)
  ;   if sProduct {
  ;     Product:=sProduct
  ;     GuiControl,Varbar:Text, Product, %sProduct%
  ;   }
  ;   Batch:=sBatch
  ;   lot:=slot
  ;   Coated:=sCoated
  ;   GuiControl,Varbar:Text, Batch, %sBatch%
  ;   GuiControl,Varbar:Text, lot, %slot%
  ;   GuiControl,Varbar:Text, Coated, %sCoated%
    try XL.Sheets(sProduct).activate
}
    return



return

return
  ;Select_Previous_Batch_In_Array: ;Move to previous Batch in Array
    SelectNextBatch(){
    n-=1
    Haystack:=Products[n]
    whereAt:=listarray(Products)
    whereatsplit:=StrReplace(whereAt, n ": ","`t" )
    pop(whereatsplit)
    Clip.Regex(Haystack)
    ; RegExMatch(Haystack, "i)(?<Product>([abdefghijkl]\d{3})?).?(?<Batch>(\d{3}-\d{4})?).?(?<Lot>(\d{4}\w\d\w?|Bulk|G\d{7}\w?)?).?(Ct#)?(?<Coated>(\d{3}-\d{4})?)", s)
      ; if sProduct {
      ;   Product:=sProduct
      ;   GuiControl,Varbar:Text, Product, %sProduct%
      ; }
      ; Batch:=sBatch
      ; lot:=slot
      ; Coated:=sCoated
      ; GuiControl,Varbar:Text, Batch, %sBatch%
      ; GuiControl,Varbar:Text, lot, %slot%
      ; GuiControl,Varbar:Text, Coated, %sCoated%
      try XL.Sheets(sProduct).activate
    }
  return

RemoveFileDuplicates("C:\Users\mmignin\Documents\VQuest\Data\Duplicate Test - Copy.txt")
; test_3() ; delete duplicates
return


; RemoveFileDuplicates2(File,Sorting:="U CL R"){
; 	global
; 	FileRead, OutputVar, % File
;   ; OutputVar:=Trim(OutputVar, " `t")
;   ; OutputVar:=trim(StrReplace(OutputVar, "`t", ""))
;   ; sleep 200
; 	Sort, OutputVar, % Sorting

; 	; NewOutputVar := RegExReplace( OutputVar , "m`a)(^\s+)|(\s+$)")
; 	FileDelete, % File
; 	sleep, 400
; 	FileAppend, %OutputVar%, % File
; }
RemoveFileDuplicates(File,Sorting:="U CL R"){
	global
	FileRead, vText, % File
  vOutput := ""
  ; vtext:=strReplace(vText, "`n`n", "")
; vText:=Trim(StrReplace(vText, "`t", ""))
VarSetCapacity(vOutput, StrLen(vText)*2*2)
oArray := {}
StrReplace(vText, "`n",, vCount)
oArray.SetCapacity(vCount+1)
;Sort, vText, D, ;add this line to sort the list
Loop Parse, vText, % "`r`n"
{
	if !oArray.HasKey("z" A_LoopField)
		oArray["z" A_LoopField] := 1, vOutput .= A_LoopField "`r`n"
}
; MsgBox, % vOutput

oArray := ""
  ; OutputVar:=Trim(OutputVar, " `t")
  ; OutputVar:=trim(StrReplace(OutputVar, "`t", ""))
  ; sleep 200
	; Sort, OutputVar, % Sorting
  ; vOutput:=trim(vOutput, "`n`n")
	NewOutputVar := RegExReplace(vOutput, "m`a)(\s\r\n)","`n")
	FileDelete, % File
	sleep, 400
	FileAppend, %NewOutputVar%, % File
}

RemoveTextDuplicates(vText){ ;maintaining order and case insensitive

vOutput := ""

; vText:=Trim(StrReplace(vText, "`t", ""))
VarSetCapacity(vOutput, StrLen(vText)*2*2)
oArray := {}
StrReplace(vText, "`n",, vCount)
oArray.SetCapacity(vCount+1)
;Sort, vText, D, ;add this line to sort the list
Loop Parse, vText, % "`n"
{
	if !oArray.HasKey("z" A_LoopField)
		oArray["z" A_LoopField] := 1, vOutput .= A_LoopField "`r`n"
}
; MsgBox, % vOutput

oArray := ""
return vOutput
}






create_CurrentCodes_Dropdown:
menu.ProductSelection()
return
Test_4:       ;;|||||||||||||||||||||||||||||||||||||||||||||||||||||||| TEST 4 ||||||||||||||||||||||||||||||||||||||||||||||||||||
    try menu,DropdownMenu, Deleteall
    Loop, Read, data\CurrentCodes.Txt
    {
    ; If A_Index = 1 ;for if its an INI file
      ; Continue
    ParseList := StrSplit(A_LoopReadLine, "`n")
    ; Sort, ParseList, U
      ; MethodGroup := StrSplit(A_LoopReadLine, "|") ;for a 2nd split
    Selection:= % "&" A_index " " ParseList[1]
      ; Group:= % MethodGroup[2] ;for a second split
    Menu, Dropdownmenu, add, %Selection%, CurrentCodesMenu
    }
    Menu, DropdownMenu, Show,
    return

    CurrentCodesMenu:
      sleep 200
    RegExMatch(A_ThisMenuItem, "i)(?<Product>([abdefghijkl]\d{3})?).?(?<Batch>(\d{3}-\d{4})?).?(?<Lot>(\d{4}\w\d\w?|Bulk|G\d{7}\w?)?).?(Ct#)?(?<Coated>(\d{3}-\d{4})?)", s)
      if sProduct {
        Product:=sProduct
        GuiControl,Varbar:Text, Product, %sProduct%
      }
      Batch:=sBatch
      lot:=slot
      Coated:=sCoated
      GuiControl,Varbar:Text, Batch, %sBatch%
      GuiControl,Varbar:Text, lot, %slot%
      GuiControl,Varbar:Text, Coated, %sCoated%
      try XL.Sheets(sProduct).activate

      ; IniRead,vOutput, %inifile%, %Category%, %InputVar%
      Pop(A_ThisMenuItem,vOutput)
      return




  add_a_ToDo_item:
    GUI, Add, Checkbox, vMyCheckBoxVar gMyCheckBoxSub, Add item to do
    GUI, Add, Edit, Disabled vToDoItemVar
    GUI, Add, Button, gSaveSub, Save
    GUI, Show
return




return


MyCheckBoxSub:
  GUI, Submit, NoHide                      ; Save all states to variables so that we can check whether the checkbox has just been checked or unchecked
  If MyCheckBoxVar                         ; If the checkbox has been checked...
    GuiControl, Enable, ToDoItemVar        ; ...enable the edit box
  Else GuiControl, Disable, ToDoItemVar    ; ...otherwise, disable the edit box
return

SaveSub:
  GUI, Submit, NoHide                      ; Save all states to variables so that we can write what is in the edit box to the INI file
  ; Add IniWrite line here and use %ToDoItemVar% as the "value" to write
return
;
Return








SavedTextMenu() { ;; create a dropdown from SavedTextMenu ini datafile
		global
    if Getkeystate("LControl","p"){
      gosub, AddTextMenuItem
      return
    }
    else
    {
      try menu, Menu, DeleteAll
  		Loop, Read, C:\Users\mmignin\Documents\VQuest\Data\MenuItems.ini
  		{
  		If A_Index = 1
  			Continue
  		SavedMenuItems := StrSplit(A_LoopReadLine, "=")
  		Selection:= % SavedMenuItems[1]
  		Menu, Menu, add, %Selection%, SavedTextMenu
  		}
      menu, menu, add
      menu, menu, add, E&xit, ExitMenu
  		Menu, Menu, Show,
      }
		return
		SavedTextMenu:
			sleep 200
			InputVar:=A_ThisMenuItem
			IniRead,vOutput, C:\Users\mmignin\Documents\VQuest\Data\MenuItems.ini, SavedMenuItems, %InputVar%
			Sendinput, %vOutput%
      menu, Menu, DeleteAll
			return

      AddTextMenuItem:
      InputBox, Variable, Variable Name = Variable
      VARIABLEITEM:= "`n" Variable
      FileAppend, %VARIABLEITEM%, C:\Users\mmignin\Documents\VQuest\Data\MenuItems.ini
      Return
}


ADD_A_TODO_LIST_ITEM_IN_VSCODE:
InputBox, TODO, Write a Todo
VSCODEToDo:= "☐ " TODO "`n"
FileAppend, %VSCODETODO%, C:\Users\mmignin\Documents\VQuest\TODO
Return


  makeADropdown(inifile,Category) {
    try menu,DropdownMenu, Deleteall
    Loop, Read, %inifile% ;data\customers.ini
    {
    If A_Index = 1
      Continue
    ParseList := StrSplit(A_LoopReadLine, "`n")
      ; MethodGroup := StrSplit(A_LoopReadLine, "|") ;for a 2nd split
    Selection:= % ParseList[1]
      ; Group:= % MethodGroup[2] ;for a second split
    Menu, Dropdownmenu, add, %Selection%, Dropdownhandler
    }
    Menu, DropdownMenu, Show,
    return

    Dropdownhandler:
      InputVar:=A_ThisMenuItem
      IniRead,vOutput, %inifile%, %Category%, %InputVar%
      Pop(Inputvar,vOutput)
      return
  }



NoIdle(){
	global
	Menu, Tray, ToggleCheck, NoIdle
	If NoIdle:= !NoIdle
	{
		SetTimer, NoidleTimer, % (3*60*1000)
		Menu, Tray, Check, NoIdle
	}
	else
	{
		Menu, Tray, unCheck, NoIdle
		Settimer, NoidleTimer,off
	}
	Varbar.Show()

NoIdleTimer:
  if (A_TimeIdle > (60*1000) && NoIdle) {
    MouseMove, 1,0,0,R
    SLEEP 50
    MouseMove, -1,0,0,R
  }


}
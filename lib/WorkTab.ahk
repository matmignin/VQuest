WorkTab_EditSample(){
  global		
  ;EnvGet, ShipTo, ShipTo
  ; excel.connect()
ifwinactive, Register new samples - \\Remote
  click 2
  sleep 200
  winwaitactive, Edit sample (Field Configuration
  sendinput, {tab 2}{right}{click 277, 139}{tab 6}
  IfWinActive, Edit sample (Field Configuration: F`, Micro) - \\Remote
    sendinput, {tab}^a
  sendinput, ^a%Batch%{tab}^a
  IfWinActive, Edit sample (Field Configuration: F`, Micro) - \\Remote 
  {
    sendinput, {CtrlDown}{a}{Ctrlup}%Lot%
    send, {tab 3}
    sleep 100
    sendinput, {CtrlDown}{a}{Ctrlup}%Coated%
    sleep 100
    send, +{tab 2}
  }
  sleep 140
  WorkTab_DropdownSelect(ShipTo)
  sleep 300
  send, {enter}
    return
}

Worktab_CheckDepartment(){
  global 
  ;clipboard:=
Send, ^c
sleep 200
if (Regexmatch(Clipboard, "\bAnalytical\s\(In Process\)", Anal) > 0)
    Department:="Analytical"
else if (Regexmatch(Clipboard, "(\bFinished, \bMicro\b|\bF, Micro\b|\bMicro \(Finished\)|\bMicro Lab\b)",Micr) > 0) ; || (Regexmatch(Clipboard, "\bF, Micro\b",Micr) > 0)
; else if (Regexmatch(Clipboard, "\bMicro\b",Micr) > 0) 
    Department:="Micro"
else if (Regexmatch(Clipboard, "\bI, Retain\b", Retain) > 0)
    Department:="Retain"
else if (Regexmatch(Clipboard, "\bPhysical\b", Phys) > 0) ; || (Regexmatch(Clipboard, "\bI, Physical\b",Phys) > 0)
    Department:="Physical"
else if (Regexmatch(Clipboard, "\bCT, Retain\b", CTRetain) > 0)
    Department:="CTRetain"
else {
  Tooltip(nope)
  
  sleep 300
  exit
}
}

WorkTab_DropdownSelect(A_ShipTo){
  AbsSelection:=Abs(A_ShipTo)-1
  if (a_shipto = "-1")
    Sendinput, {end}
  else if (a_shipto = "1")
    Sendinput, {home}
  else if (a_ShipTo > 1)
    sendinput, {home}{right %A_ShipTo%}
  else if (a_ShipTo < 1)
    Sendinput, {end}{left %Absselection%}
  }
Worktab_CheckDepartment2(){
  global 
  click, 32, 176
  sleep 400
  If Winactive("Edit sample (Field Configuration: F, Micro) - \\Remote")
    Department:="Micro"
  if winactive("Edit sample (Field Configuration: I, Analytical) - \\Remote")
    Department:="Analytical"
  if winactive("Edit sample (Field Configuration: I, Physical) - \\Remote")
    Department:="Physical"
  if winactive("Edit sample `(Field Configuration: CT`, Retain`) - \\Remote")
    Department:="CTRetain"
  else
  Tooltip(De)
  exit
  send, {esc}
  sleep 200
  Tooltip(Department)
return
}

 
 
WorkTab_NewRequest(){
  global
  department:= ; Clip()
  Clipboard:=
  sleep 100
  WinActivate, NuGenesis LMS - \\Remote
  ; send, ^c
  sleep 200

  sleep 50
  Worktab_CheckDepartment()
  sleep 400
  tooltip, %department%
  click 64, 300 ;click Assign To New rewuest link
  winwaitactive, Edit request - \\Remote,,3
      if !Errorlevel
  sleep 200
  WinActivate, Edit request - \\Remote,
  click 238, 622 ;pick test
  winwaitactive, Select tests for request,,3 
    if !Errorlevel
    sleep 100
  click, right, 264, 590 ; click to show filer
  sleep 100
  send, {up}{enter}
  sleep 100
  click, 97, 125 ; click filter
  send, %Department%{enter}{tab 2}
  sleep 100
  send, %product%{enter}
  ;click 152, 195
  send, {tab}{CtrlDown}{a}{Ctrlup}
  input, , V T3, {Lbutton}{enter}
  click 504, 338 ; click arrow
  WinActivate, Select tests for request
  click, right, 264, 590 ; click to clear filter
  send, {up}{enter}
  sleep 100
  WinActivate, Select tests for request
  sleep 100
  WinActivate, Select tests for request
  click 854, 657 ; click okay
  winwaitclose, Select tests for request,,10
    if !Errorlevel
    WinWaitActive, Edit request
  While GetKeyState("Lbutton", "p")
  sleep 100
  IfWinnotActive, Edit request
    exit
  Sleep 100
    winactivate, Edit request
    send, {tab}{enter}
    tooltip,
  return

}

WorkTab_ChangeTestResults(Checkbox_Toggle:=0) {
  global 
  MouseGetPos, xpos, ypos
  click
  Mouse_Click("Orient_ResultEntry")
  if Checkbox_Toggle Contains Toggle
    sendinput, {tab}{Space}{tab}{Space}
  else
    sendinput, {tab}{tab}
  sendinput, {tab 10}^a 
  sleep 100
  send, %Iteration%
  sleep 100
  mousemove, xpos, ypos+26
  return

}

WorkTab_AddSampleLog(count) 
{
  global
  ;MouseGetPos, xpos, ypos
  loop, %count%
  {
    click 46, 877
    ;Click, xpos, ypos, 2
    ;ypos:= ypos+26
    winwaitactive, Edit test (Field Configuration: I`, Analytical) - \\Remote
    sendinput, {Click, 402, 284}{end}(on sample log){click, 334, 618}
    winwaitactive, NuGenesis LMS - \\Remote
    sleep 300
    winactivate, NuGenesis LMS - \\Remote
    sleep 500
    send, {click, 1290, 703}{down %A_index%}
  }
  return
}

WorkTab_Main_EditResults() 
{
  sendinput, {click}{click 77, 751} ;edit results
  winwaitactive, Results Definition - \\Remote
  return
}


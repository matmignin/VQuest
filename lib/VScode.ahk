return
	F20 & \::Sendinput, mmignin{tab}Kilgore7744
	F19 & \::Sendinput, ?Kilgore7744
;	#!\::Login()

return 





VsCode_:
    #IfWinActive, ahk_exe Code.exe
    $<^k::sendinput, {Ctrldown}{up}{CtrlUp}
    $<^l::sendinput, {Ctrldown}]{CtrlUp}
    $<^j::sendinput, {Ctrldown}{down}{CtrlUp
    $+^j::sendinput, {ShiftDown}{Ctrldown}{down}{CtrlUp}{ShiftUp}
    ; $+^K::sendinput, {ShiftDown}{Ctrldown}{up}{CtrlUp}{ShiftUp}
    $<^h::sendinput, {Ctrldown}[{CtrlUp}

    ; +^l::^+#`;
    ; Mbutton & Wheeldown::Wheel_2("!d",1000)
    ; +^h::^+#h
    ; mbutton::wheel_2("^m",2000)
    
    <^r::ReloadScript()
    Mbutton & F17::Sendinput, {Ctrldown}]{CtrlUp}
    Mbutton & F16::sendinput,{Ctrldown}[{CtrlUp}
    Mbutton & wheelUP::sendinput, {ctrl down}{up}{ctrl up}
    Mbutton & WheelDOWN::sendinput, {ctrl down}{down}{ctrl up}
    Mbutton::send, {CtrlDown}{f}{Ctrlup}
    Rbutton & F17::Wheel_2("!{right}",10)
    Rbutton & F16::Wheel_2("!{left}",10)
	  Rbutton & Lbutton::sendinput, {Shiftdown}{click}{ShiftUp}
    Rbutton & wheeldown::Wheel_2("{ctrl down}v{ctrl up}",2000)
    Rbutton & Wheelup::Wheel_2("{ctrl down}x{ctrl up}",2000)
    Rbutton & Xbutton2::Get_WindowInfo()
    
    Xbutton2 & F16::
    Xbutton2 & F17::
    ;$Rbutton::Click right
    Xbutton2 & Lbutton::sendinput, {CtrlDown}{click}{Ctrlup}
    
    ; Xbutton1 & Lbutton::^+4
		F18 & F16::return
    ; Xbutton1 & F18::F5
    F18 & Rbutton::sendinput, {shiftdown}{Ctrldown}m{CtrlUp}{shiftup} ; toggle bookmark
		F18 & F17::return
    F18 & wheeldown::wheel_2("{ShiftDown}{altdown}{down}{altUp}{ShiftUp}",50) ;next search
    F18::sendinput, {ShiftDown}{Ctrldown}{p}{CtrlUp}{ShiftUp}  ;search
    F18 & wheelup::wheel_2("{ShiftDown}{altdown}{up}{altUp}{ShiftUp}",50) ;projects
    F16::sendinput, {ShiftDown}{altDown}{Ctrldown}{t}{CtrlUp}{altup}{ShiftUp} ;prev tab
    F20::sendinput, {ShiftDown}{Ctrldown}{p}{CtrlUp}{ShiftUp}




    F17::ToggleDefinition()

return
  
;FUNCTIONS-----------------------------------------------------------

  Login(){
      sendinput, 4130220009588038
      trayTip, ,11/21  127
      return
    }


    Get_WindowInfo() {
      global
      CoordMode, mouse, window
      MouseClick, right,,, 1, 0, D ; Hold down the right mouse button.
      Loop
      {
        if !GetKeyState("Rbutton", "P") ; The key has been released, so break out of the loop.
          break
        MouseGetPos, MousePosX, MousePosY, , WinControl
        sleep 20
        WinGetTitle, winTitle, A
        WinGetClass, Winclass, A
        WinGet, WinProcess, ProcessName, A			
        Sleep, 100
        Tooltip("%MousePosition%`n Title: %winTitle% `n Process: %WinProcess% `n Control: %winControl% `n Class: %winclass%")
        MousePosition:=MousePosX "`, " MousePosY
				Process:=ahk_exe %WinProcess%

      }
      winTitle:=Wintitle
      Winclass:=Winclass
     ; WinGet, WinProcess, ProcessName, A	
      MouseClick, Right,,, 1, 0, U ; Release the mouse button.
      ;clipboard:=MousePosition
      mouseclick, right
      ;sendinput, {esc}
      ;MouseClick, left,,, 1, 0,
      tooltip
      return
    }

    ReloadScript(){
    global iteration
      ControlGetText, Iteration, Edit2, VarBar
      tooltip("Reload")
      if (iteration = -1)
      {
        sendinput, {F5}
        IniWrite, -2, data.ini, SavedVariables, Iteration
      }
      else if (iteration = -2)
        sendinput, {F4}
      else
      {
        sendinput, ^s
        sleep 200
        run, VQuest.ahk
      }
      send, {altup}{CtrlUp}{ShiftUp}{LWinUp}
    }

  ToggleDefinition(){
      global
      If toggle := !toggle
        sendinput  ^d
      else 
        sendinput, +{esc}
      return
      return
    }
    
    
    
    
      
    VSCODE_Hotstrings:
    :*R:cd\::{CtrlDown}
    :*R:cu\::{Ctrlup}
    :*R:ad\::{altDown}
    :*R:au\::{altup}
    :*R:sd\::{shiftDown}
    :*R:su\::{shiftup}
  Modifier_Hotstrings: 
    :*R:c\::
    sendraw, sendinput, {CtrlDown}{}{Ctrlup}
    sendinput, {left 9}
    return
    :*R:a\::
    sendraw, sendinput, {altDown}{}{altup}
    sendinput, {left 8}
    return
    :*R:s\::
    sendraw, sendinput, {shiftDown}{}{shiftup}
    sendinput, {left 10}
    return
    :*R:sac\::
    :*R:cas\::
    sendraw, sendinput, {ShiftDown}{altDown}{Ctrldown}{}{CtrlUp}{altup}{ShiftUp}
    sendinput, {left 25}
    return
    :*R:sc\::
    :*R:cs\::
    sendraw, sendinput, {ShiftDown}{Ctrldown}{}{CtrlUp}{ShiftUp}
    sendinput, {left 18}
    return
    :*R:sa\::
    :*R:as\::
    sendraw, sendinput, {ShiftDown}{altDown}{}{altup}{ShiftUp}
    sendinput, {left 17}
    return
    :*R:ca\::
    :*R:ac\::
    sendraw, sendinput, {ShiftDown}{altDown}{Ctrldown}{}{CtrlUp}{altup}
    sendinput, {left 16}
    return
    
    
    

open_VScode(){
  ifwinnotexist,ahk_exe Code.exe
    run, Code.exe, "C:\Program Files\Microsoft VS Code\" 
  else 
    WinActivate, ahk_exe Code.exe

  return
  }
﻿









#IfWinActive



Return & Space::Send_Product()
Return & A::Enter_Product("A")
Return & E::Enter_Product("E")
Return & G::Enter_Product("G")
Return & H::Enter_Product("H")
Return & I::Enter_Product("I")
Return & J::Enter_Product("J")
Return & K::Enter_Product("K")
Return & L::Enter_Product("L")
Return & 1::Enter_Batch("011")
Return & 2::Enter_Batch("012")
Return & 3::Enter_Batch("013")
Return & 4::Enter_Batch("014")
Return & 5::Enter_Batch("015")
Return & 6::Enter_Batch("006")
Return & 7::Enter_Batch("007")
Return & 8::Enter_Batch("008")
Return & 9::Enter_Batch("009")
Return & 0:: return
Return_0_Trigger:
#If (A_PriorHotKey = "Return & 0" AND A_TimeSincePriorHotkey < 4000)
Return & 0::Enter_Batch("010")
0::Enter_Batch("000")


#ifwinactive, NuGenesis LMS - \\Remote
F19::Mouse_Click("SearchBar_Product")	; rigth comm button)))
F20::Mouse_Click("SearchBar_Batch")     	   	     ; right alt button


#IfWinActive

Enter_Batch(key) 
{
		global
		MouseGetPos,MouseLocationX,MouseLocationY
		sleep 200
		inputbox,Batch,, %key%-,,70,130,%MouseLocationX%,%MouseLocationY%,,,%Batch%
		if ErrorLevel
			return
		else
			Batch:=key . "-" . Batch
		;Envset, Batch, %Batch%
		Sleep 100		
		VarBar()
		return
	}
	Enter_Product(key)
	{
		global
		MouseGetPos,MouseLocationX,MouseLocationY
		sleep 200
		inputbox,Code,,  %key%`t ,,70,130,%MouseLocationX%,%MouseLocationY%,,,%Code%
		if !ErrorLevel
			Product:=key . Code
		Save_Code("Products", Product)
		Sleep 200	
		IfWinActive, NuGenesis LMS - \\Remote
			sendinput, {ctrl down}a{ctrl up}%Product%{enter}
		VarBar()
		return
	} 


	



Main_EditResults() 
{
	sendinput, {click}{click 77, 751} ;edit results
	winwaitactive, Results Definition - \\Remote
	return
}

RegisterNewSample() 
{
	global
	winactivate, Register new samples - \\Remote
	Send, {click 179, 105}{click}%Product%{enter}
}





SelectCustomer() 
{
	sendinput, {tab} ;{right 7}{enter} ;501 nutrition was 7
		return
}
	
	

	#ifwinactive,
	
	
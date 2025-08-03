

;Automations!
; Healing
;>>>> 80% health <<<<
;Position:	104, 909
;Cursor ID:	0
;Color:	9248039
Func _Healing()
	_Idle()
	$pHealthColor = PixelGetColor(104, 909)
	If $pHealthColor = 9248039 Then
		ConsoleWrite("Health is full: " & $pHealthColor & @CRLF)
	Else
		ConsoleWrite("Health potion used: " & $pHealthColor & @CRLF)
		Send("1")
	EndIf
	Sleep(1000)
EndFunc   ;==>_Healing

Func _Idle()
	If Not WinActive("Path of Exile") Then
		ConsoleWrite("PoE NOT Active!" & @CRLF)
		Sleep(3000)
		ContinueLoop
	EndIf
EndFunc   ;==>_Idle

Func _Debug($pFunctionName, $pData)
	ConsoleWrite($pFunctionName & ": " & $pData)
EndFunc

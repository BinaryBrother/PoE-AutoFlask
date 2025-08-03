

;Automations!
; Healing
;>>>> 80% health <<<<
;Position:	104, 909
;Cursor ID:	0
;Color:	9248039




Func _Healing()

	$pHealthColor = PixelGetColor(104, 909)
	If $pHealthColor = 9248039 Then
		ConsoleWrite("Health is full: " & $pHealthColor & @CRLF)
	Else
		ConsoleWrite("Health is NOT full: " & $pHealthColor & @CRLF)
		Send("1")
	EndIf
	Sleep(1000)
EndFunc

Func _Idle()
	If Not WinActive("Path of Exile") Then
		ConsoleWrite("PoE NOT Active!" & @CRLF)
		Sleep(5000)
		ContinueLoop
EndIf
EndFunc
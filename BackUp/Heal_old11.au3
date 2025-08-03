
Opt("WinTitleMatchMode", 3)
AdlibRegister("_Healing", 500)
AdlibRegister("_RefillMana", 1000)
Global $gSoundFile = ".\Resources\Action.wav"

While 1
	Sleep(1000)
WEnd

;>>>> 100% Mana <<<<
;Position:	1805, 891
;Color:	936344 (Mana Globe Full)
Func _RefillMana()
	_Idle()
	If @error Then Return
	Local $iManaColor = PixelGetColor(1787, 1054)
	If $iManaColor = 1187649 Then
		;_Debug("_RefillMana", "Mana is full. Pixel Color:" & $pManaColor)
	Else
		_Debug("_RefillMana", "Using Mana Potion! Color: " & $iManaColor)
		SoundPlay($gSoundFile)
		Send("4")
		Sleep(1000)
	EndIf
EndFunc   ;==>_RefillMana


;>>>> 100% health No Shield <<<<
;Position:	104, 909
;Color:		9248039 (Health Globe Full)
Func _Healing()
	_Idle()
	If @error Then Return
	Local $iHealthColor = PixelGetColor(104, 909)
	If $iHealthColor = 9248039 Then
		;_Debug("_Healing", "Health is full.")
	Else
		_Debug("_Healing", "Using Health Potion! Color: " & $iHealthColor)
		SoundPlay($gSoundFile)
		Send("1")
		Sleep(1000)
	EndIf
EndFunc   ;==>_Healing

Func _Idle()
	;Pause While not Active Window
	If Not WinActive("Path of Exile") Then
		_Debug("_Idle", "PoE NOT Active! Pausing Script...")
		WinWaitActive("Path of Exile")
		_Debug("_Idle", "PoE Active! Resuming Script...")
	EndIf
	;Pause at Logon Screen and Transit/Loading Screens
	Switch PixelGetColor(104, 909)
		Case 1713446
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(1, 0, False)
		Case 1185818
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(2, 0, False)
		Case 328704
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(3, 0, False)
		Case 328962
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)
		Case 65793
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)
		Case 9248295
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)
			Case 9248295
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)


	EndSwitch
	Switch PixelGetColor(1787, 1054)
		Case 271958
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(1, 0, False)
		Case 1778469
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(2, 0, False)
		Case 0
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(3, 0, False)
		Case 131586
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)
		Case 338267
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(5, 0, False)
		Case 328709
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(6, 0, False)
		Case 204874
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(7, 0, False)
		Case 516
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(8, 0, False)
		Case 601438
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(8, 0, False)
	EndSwitch
EndFunc   ;==>_Idle


Func _Debug($pFunctionName, $pData)
	ConsoleWrite($pFunctionName & ": " & $pData & @CRLF)
EndFunc   ;==>_Debug


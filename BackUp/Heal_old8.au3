
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
	If @Error Then Return
	Local $iManaColor = PixelGetColor(1752, 958)
	If $iManaColor = 936344 Then
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
	If PixelGetColor(1752, 958) = 271958 Or PixelGetColor(104, 909) = 1713446 Or PixelGetColor(1752, 958) = 1778469 Or PixelGetColor(104, 909) = 1185818 Or PixelGetColor(1752, 958) = 0 _
			Or PixelGetColor(104, 909) = 328704 Or PixelGetColor(1752, 958) = 131586 Or PixelGetColor(1752,958) = 338267 Or PixelGetColor(1752, 958) = 328709 Or  PixelGetColor(1752, 958) = 204874 _
			Or PixelGetColor(104,909) = 328704 Or PixelGetColor(104,909) = 328962  Or PixelGetColor(1752, 958) = 516 Then
		_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
		Sleep(2000)
		Return SetError(1,0,False)
	EndIf

EndFunc   ;==>_Idle


Func _Debug($pFunctionName, $pData)
	ConsoleWrite($pFunctionName & ": " & $pData & @CRLF)
EndFunc   ;==>_Debug

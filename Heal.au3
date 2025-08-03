#Region ; *** Dynamically added Include files ***
#include <Misc.au3>                                          ; added:07/29/25 16:52:16
#EndRegion ; *** Dynamically added Include files ***


Opt("WinTitleMatchMode", 3)
SoundSetWaveVolume(25)
AdlibRegister("_Healing", 1000)
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
		Send(String(Random(4, 5, 1)))
		Sleep(2000)
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
		Send(String(Random(1, 2, 1)))
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
	Switch PixelGetColor(104, 909) ; Health
		Case 0, 256, 257, 258, 65793, 131328, 328704, 328962, 922646, 1185818, 1713446, 5180434, 5508372, 9248295
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(1, 0, False)
	EndSwitch

	Switch PixelGetColor(1787, 1054) ; Mana
		Case 0, 256, 516, 131586, 204874, 271958, 328709, 338267, 396577, 462372, 601438, 1710100, 1778469, 923160
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(2, 0, False)
	EndSwitch

	Switch PixelGetColor(887, 233) ; Dead Screen
		Case 3812396
			_Debug("_Idle", "Death Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(3, 0, False)
	EndSwitch


EndFunc   ;==>_Idle


Func _Debug($pFunctionName, $pData)
	ConsoleWrite($pFunctionName & ": " & $pData & @CRLF)
EndFunc   ;==>_Debug


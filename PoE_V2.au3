#Region ; *** Dynamically added Include files ***
#include <Misc.au3>                                          ; added:07/29/25 16:52:16
#EndRegion ; *** Dynamically added Include files ***

Opt("WinTitleMatchMode", 3)
AdlibRegister("_Healing", 1000)
;AdlibRegister("_RefillMana", 1000)
SoundSetWaveVolume(50)

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
	If $iHealthColor = 2301473 Then ;Health orb low
		_Debug("_Healing", "Using Health Potion!")
		SoundPlay($gSoundFile)
		Send(String(Random(1, 2, 1)))
		Sleep(1000)
	Else
		Return
	EndIf
EndFunc   ;==>_Healing

Func _Idle()
	;Pause While not Active Window
	If Not WinActive("Path of Exile") Then
		_Debug("_Idle", "PoE NOT Active! Pausing Script...")
		WinWaitActive("Path of Exile")
		_Debug("_Idle", "PoE Active! Resuming Script...")
	EndIf

	Switch PixelGetColor(887, 233) ; Dead Screen
		Case 3812396
			_Debug("_Idle", "Logon/Transit Screen Detected. Pausing Script...")
			Sleep(2000)
			Return SetError(4, 0, False)
	EndSwitch
EndFunc   ;==>_Idle


Func _Debug($pFunctionName, $pData)
	ConsoleWrite($pFunctionName & ": " & $pData & @CRLF)
EndFunc   ;==>_Debug


#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()

global previousTick
global DpsFlaskCooldown := 6000

; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
		if ( CheckPoeWindow() == true ) {

			if ( GetKeyState("RButton", "P") ) {
				; wait for Right Click to be held down for 200ms
				KeyWait, RButton, T 0.2
				; if held down for 200ms -> trigger kreypress
				if ( ErrorLevel = 1 ) {
					PressKey("vk32", 50)
					PressKey("vk33", 50)
					PressKey("vk34", 50)
					THREAD_WAIT(DpsFlaskCooldown)
				}
		
			}

		}
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}

; use instead a hotkey to trigger multiple flasks as your DPS routine
; in this case make sure to edit the condition at the top

;XButton1::multipleFlasks()

multipleFlasks(){
    differenceTick 	:= A_TickCount - previousTick

	if ( differenceTick < DpsFlaskCooldown ) {
		THREAD_WAIT(DpsFlaskCooldown-differenceTick)
	}
    previousTick := A_TickCount

	PressKey("vk32", 50)
	PressKey("vk33", 50)
	PressKey("vk34", 50)

	THREAD_WAIT(1000)
}
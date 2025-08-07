#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()

; Define the number of flasks to use (1 to 5)
; NumFlasks := 1 ; Will only use vk31 (Flask 1)
; NumFlasks := 2 ; Will alternate vk31 (Flask 1) and vk32 (Flask 2)
; NumFlasks := 3 ; Will cycle vk31, vk32, vk33
; NumFlasks := 4 ; Will cycle vk31, vk32, vk33, vk34
; NumFlasks := 5 ; Will cycle vk31, vk32, vk33, vk34, vk35
NumFlasks := 3 ; Set this to your desired number of flasks

FlaskCounter	:= 1
FlaskCooldown1	:= 6000 ; Cooldown for Flask 1 (vk31)
FlaskCooldown2	:= 6000 ; Cooldown for Flask 2 (vk32)
FlaskCooldown3	:= 6000 ; Cooldown for Flask 3 (vk33)
FlaskCooldown4	:= 6000 ; Cooldown for Flask 4 (vk34)
FlaskCooldown5	:= 6000 ; Cooldown for Flask 5 (vk35)

; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
		if ( CheckPoeWindow() == true ) {

			if ( GetKeyState("LButton", "P") ) {
				; wait for Left Click to be held down for 500ms
				KeyWait, LButton, T 0.5
				; if held down for 500ms -> trigger keypress
				if ( ErrorLevel = 1 ) {
					; Calculate the current flask index (1 to NumFlasks)
					; This ensures the counter cycles correctly based on how many flasks are enabled
					currentFlaskIndex := mod(FlaskCounter - 1, NumFlasks) + 1

                    ; Now, press the corresponding flask based on currentFlaskIndex
                    ; and ensure it's within the range of NumFlasks active
					if (currentFlaskIndex == 1) {
						PressKey("vk31", FlaskCooldown1) ; Press Flask 1 (Key 1)
					} else if (currentFlaskIndex == 2) {
						PressKey("vk32", FlaskCooldown2) ; Press Flask 2 (Key 2)
					} else if (currentFlaskIndex == 3) {
						PressKey("vk33", FlaskCooldown3) ; Press Flask 3 (Key 3)
					} else if (currentFlaskIndex == 4) {
						PressKey("vk34", FlaskCooldown4) ; Press Flask 4 (Key 4)
					} else if (currentFlaskIndex == 5) {
						PressKey("vk35", FlaskCooldown5) ; Press Flask 5 (Key 5)
					}

					FlaskCounter++
				}
			}

		}
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}
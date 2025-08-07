#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
; FLASKS
KeyDelayTimes["vk31"] := 6000
KeyDelayTimes["vk32"] := 6000
KeyDelayTimes["vk33"] := 6000
KeyDelayTimes["vk34"] := 6000
KeyDelayTimes["vk35"] := 6000
; SKILLS
KeyDelayTimes["Q"] 	  := 3000
KeyDelayTimes["W"] 	  := 3000
KeyDelayTimes["E"] 	  := 3000
KeyDelayTimes["R"] 	  := 3000
KeyDelayTimes["T"] 	  := 3000
; Storing the last press tick for each key
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()

; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
        if ( (_SCRIPT_KEYSTATE_THREAD == "yes") AND (CheckPoeWindow() == true) ) {

            ; check if Q being pressed for 500ms
            if ( GetKeyState("q", "P") ) {
                KeyWait, q, T 0.5
                if ( ErrorLevel = 1 ) {
                    ; SEND whatever is needed as a combo
                }
            }

        }
    }
    THREAD_WAIT(_TICK_UPDATE_WAIT) 
}
; Listen for the e key press
; Perfect release of Monk's Gathering Storm for example
~e::
    if ( (_SCRIPT_KEYSTATE_THREAD == "yes") AND (CheckPoeWindow() == true) ) {
        ; Press and hold the e key
        Sleep, 700
        Send, {e up}
    }
return
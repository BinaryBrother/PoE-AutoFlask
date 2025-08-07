#Include dependencies\includes\_INCLUDES_THREAD

global healthBuffer 	  := [] ; array to store health values
global bufferSize 		  := 40 ; 10 slots per second / temporal rift is 4 seconds / 100ms update rate
global currentHealth 	  := 0  ; current health value
global temporalRiftHealth := 0  ; health value for temporal rift usage
THREAD_WAIT(_TICK_UPDATE_WAIT*8)


; _____MAIN LOOP
Loop {
	while( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) ) {

		; store current health
		currentHealth := _POEMEMORY.CURHP

		; remove the last entry if the buffer is full
		if (healthBuffer.Length() == bufferSize)
			healthBuffer.RemoveAt(bufferSize)

		; add the current health value to the start of the buffer
		healthBuffer.InsertAt(1, currentHealth)

		; the value from 4 seconds ago will be the last item in the buffer
		if (healthBuffer.Length() == bufferSize)
			temporalRiftHealth := healthBuffer[bufferSize]


		THREAD_WAIT(100) 
	}
	THREAD_WAIT(_TICK_UPDATE_WAIT) 
}

; _____HOTKEYS
; thumb mouse key 1
$XButton1::temporalRiftExec()


; _____ACTIONS
temporalRiftExec(){
	; use temporal rift only if health result is above 1000
	if (temporalRiftHealth > 1000){
		; assuming R is the hotkey for the skill
		PressKey("XButton1", 250)
	}
	else{
		; do nothing since temporalRiftHealth is lower than 1000
	}
}
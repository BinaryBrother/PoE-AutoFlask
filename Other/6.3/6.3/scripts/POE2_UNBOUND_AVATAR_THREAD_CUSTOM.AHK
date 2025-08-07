#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()



; _____MAIN LOOP
Loop {
	if ( _POEMEMORY.ERROR == "NONE" AND InTown() == false ) {
		if ( CheckPoeWindow() == true ) {

            if ( _POEMEMORY.BUFFLIST.HasKey("ailment_bearer_activation_buff") == true ) {
                if ( _POEMEMORY.BUFFLIST["ailment_bearer_activation_buff"].CHARGES == 100 ) {
                    PressKey("Q", 250)
                    
                }
            }
        }
    }
}

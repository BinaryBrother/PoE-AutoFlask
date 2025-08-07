#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()



; _____MAIN LOOP
Loop {
	if ( _POEMEMORY.ERROR == "NONE" AND InTown() == false ) {
		if ( CheckPoeWindow() == true ) {
            if ( _POEMEMORY.BUFFLIST.HasKey("elemental_invocation_reserve") == true ) {
                if ( _POEMEMORY.BUFFLIST["elemental_invocation_reserve"].CHARGES > 95 ) {
                    PressKey("Q", 250)
                }
            }
        }
    }
}

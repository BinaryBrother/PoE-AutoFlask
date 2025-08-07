#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()



; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
		if (CheckPoeWindow() == true) {

			if (_POEMEMORY.BUFFLIST["power_charge"].CHARGES > 0) {

				if (_POEMEMORY.BUFFLIST["charged_staff_stack"].DURATION < 2.0) {
					PressKey(_SCRIPT_CHARGED_STAFF_KEY, 1000)
				}
				else if (_POEMEMORY.BUFFLIST["power_charge"].DURATION < 2.0) {
					PressKey(_SCRIPT_CHARGED_STAFF_KEY, 1000)
				}
				
			}
			
		}
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}
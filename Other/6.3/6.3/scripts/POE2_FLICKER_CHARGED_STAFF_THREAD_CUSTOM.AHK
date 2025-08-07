#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()
TogglePressKey := false


; _____MAIN LOOP
Loop {
	if (_POEMEMORY.ERROR == "NONE" AND InTown() == false) {
		if (CheckPoeWindow() == true AND TogglePressKey == true) {
			if (_POEMEMORY.BUFFLIST["power_charge"].CHARGES > 0) {

				if (_POEMEMORY.BUFFLIST["charged_staff_stack"].DURATION < 2.0) {
					PressKey(_SCRIPT_CHARGED_STAFF_KEY, 1000)
				}
				else if (_POEMEMORY.BUFFLIST["power_charge"].DURATION < 2.0) {
					PressKey(_SCRIPT_CHARGED_STAFF_KEY, 1000)
				}

				if (	(_POEMEMORY.BUFFLIST["power_charge"].CHARGES > 2)
					AND (_POEMEMORY.BUFFLIST["charged_staff_stack"].CHARGES > 2)
					AND (_POEMEMORY.BUFFLIST["charged_staff_stack"].DURATION > 5.0) )
				{
					PressKey("T", 500)
				}

			}
		}
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}

~Y::
    TogglePressKey := !TogglePressKey
    ToolTip, Script is now: %TogglePressKey% , 20 , 400
    Sleep, 500 
    ToolTip  ; Remove the tooltip
return
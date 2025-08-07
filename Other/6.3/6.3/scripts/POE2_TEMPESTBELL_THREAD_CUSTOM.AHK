#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()
TogglePressKey := false


; _____MAIN LOOP
Loop {
    if (_POEMEMORY.ERROR == "NONE" AND InTown() == false) {
        if (CheckPoeWindow() == true) {
            if (_POEMEMORY.BUFFLIST.HasKey("tempest_bell_combo_tracker") == true) {
                if (_POEMEMORY.BUFFLIST["tempest_bell_combo_tracker"].CHARGES > 3 AND TogglePressKey == true) {
                    PressKey("T", 100)
                }
            }
        }
    }

    THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}

~Y::
    TogglePressKey := !TogglePressKey
    ToolTip, Bell is now: %TogglePressKey% , 20 , 400
    Sleep, 500 
    ToolTip  ; Remove the tooltip
return
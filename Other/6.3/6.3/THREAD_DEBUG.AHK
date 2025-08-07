#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()


; _____MAIN LOOP
Loop {
    if (_POEMEMORY.ERROR == "NONE") {
        if (CheckPoeWindow() == true) {

            DisplayText := "BUFFNAME       . DURATION . CHARGES . UISTACK`n"  ; header line

            for BUFFNAMETEST, BUFFDATA in _POEMEMORY.BUFFLIST {
                DisplayText .= Format("{:-20} . {:7} . {:7} . {:7}`n"
                    , BUFFNAMETEST
                    , BUFFDATA.DURATION
                    , BUFFDATA.CHARGES
                    , BUFFDATA.UISTACK)
            }
            DisplayText .= _POEMEMORY.CURAREA
            DisplayText .= "`n"

            Tooltip, %DisplayText%, 20, 400
        }
    }
    THREAD_WAIT(_TICK_UPDATE_CRITICAL*10)
}


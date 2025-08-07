; _____FUNCTIONS

; press a given key with a sleep time at the very end of the keypress
PressKey(_PARAM_KEY, _PARAM_FINALDELAY){
    global _POEMEMORY
    ; Get the current tick
    currentTime := A_TickCount
    ; Check if a delay time is set for the key
    if ( KeyDelayTimes.HasKey(_PARAM_KEY) && ( KeyDelayTimes[_PARAM_KEY] != 0 )) {
        ; Check if the key has been pressed before and if the delay time has passed
        if (LastPressTime.HasKey(_PARAM_KEY) && (currentTime - LastPressTime[_PARAM_KEY] < KeyDelayTimes[_PARAM_KEY])) {
            ; If less than the delay time has passed, do nothing
            return
        }
        ; Update the last press tick for this key
        LastPressTime[_PARAM_KEY] := A_TickCount
    }
    ; check if key contains 30 40 50 -> means controller input
    if ( InStr(_PARAM_KEY, "30") OR InStr(_PARAM_KEY, "40") OR InStr(_PARAM_KEY, "50") ){
        _POEMEMORY.CONTROLLERPRESS := _PARAM_KEY
        return true
    }
    ; send normal key
    Send {%_PARAM_KEY% Down}
        THREAD_WAIT(_DELAY_PRESS)
    Send {%_PARAM_KEY% Up}
        THREAD_WAIT(_PARAM_FINALDELAY)

    return true
}

; sleep for a given time randomized by 10%
THREAD_WAIT(_PARAM_TIME){
    minTime := _PARAM_TIME - (_PARAM_TIME * 0.10)
    maxTime := _PARAM_TIME + (_PARAM_TIME * 0.10)

    Random, rand, minTime, maxTime

    Sleep %rand%
}

Disconnect(_PARAM_PLATFORM){
    global _POEMEMORY
    cportsPath := A_ScriptDir . "\cports.exe"
    ; delete the lines with versions you are not using anyway
    if(_PARAM_PLATFORM == "Normal"){
        RunWait, %cportsPath% /close * * * * PathOfExile.exe
    }
    if(_PARAM_PLATFORM == "Steam"){
        RunWait, %cportsPath% /close * * * * PathOfExileSteam.exe
    }
    if(_PARAM_PLATFORM == "EpicGames"){
        RunWait, %cportsPath% /close * * * * PathOfExileEGS.exe
    }
    if(_PARAM_PLATFORM == "Korea"){
        RunWait, %cportsPath% /close * * * * PathOfExile_KG.exe
    }
    ; wait for _POEMEMORY to return an ERROR STATE
    ; returning to hideout will be detected this way 
    THREAD_WAIT(2500)
    while ( _POEMEMORY.ERROR != "NONE" ) {
      THREAD_WAIT(1000)
    }
    THREAD_WAIT(1000)
}

CheckPoeWindow(){
    if WinActive("ahk_class POEWindowClass"){
        return true
    }
    else {
        return false
    }
}

UserInputBlock(_PARAM_TIME) {
    ; Dynamically remap the keys to block input
    Hotkey, *LButton, BlockedInput, On
    Hotkey, *RButton, BlockedInput, On
    Hotkey, *Space, BlockedInput, On

    Sleep, %_PARAM_TIME%

    ; Restore default behavior
    Hotkey, *LButton, BlockedInput, Off
    Hotkey, *RButton, BlockedInput, Off
    Hotkey, *Space, BlockedInput, Off
    return
}

BlockedInput() {
    ; Do nothing - effectively blocks input
}

InTown(){
    global _POEMEMORY
    curArea := _POEMEMORY.CURAREA

    if ( _SCRIPT_DISABLE_HIDEOUT == "no"){
        return false
    }

    ; Check if curArea contains any of the town strings
    if ( InStr(curArea, "Hideout") OR InStr(curArea, "Encampment") OR InStr(curArea, "Caravan") OR InStr(curArea, "Ziggurat") ) {
        return true ; Return true if any match is found
    }
    return false ; Return false if no match is found
}

IsAttacking(){
    global _POEMEMORY
    if ( _POEMEMORY.BUFFLIST.HasKey("skill_cost_over_time") == true ) {
        return true
    }
    else {
        return false
    }
}
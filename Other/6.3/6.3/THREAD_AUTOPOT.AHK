#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()



; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
		;MANA______________________________________________________________________________________
			if ( (_POEMEMORY.MAXMANA > 0) AND ( (_POEMEMORY.CURMANA / _POEMEMORY.MAXMANA) < _SCRIPT_MP_VALUE ) ) {
				if ( (CheckPoeWindow() == true) AND (_POEMEMORY.BUFFLIST.HasKey("monster_mod_mana_siphoner") == false) ) {
					PressKey(_SCRIPT_MP_FLASK_KEY, 50)
				}
			}
		;__________________________________________________________________________________________

		;DROWNING__________________________________________________________________________________
			if ( _POEMEMORY.BUFFLIST.HasKey("tangle_drowning") == true ) {
				if ( _POEMEMORY.BUFFLIST["tangle_drowning"].DURATION < 0.8 ) {
					if ( (_SCRIPT_USE_LOGOUT == "yes") OR (_SCRIPT_USE_ESCAPE == "yes") ) {
						Disconnect(_SCRIPT_PLATFORM)
					}
					else {
						PressKey("Space", 500) ; Press Spacebar - try to safe from death
					}
				}
			}
		;__________________________________________________________________________________________

		;Life______________________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "Life") ) {
				; Flask usage with LIFE
				if ( ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP) < _SCRIPT_HP_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Logout based on LIFE
				if ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP)  < _SCRIPT_DC_VALUE ) {
					if (_SCRIPT_USE_LOGOUT == "yes"){
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							LatestTriggerValue := (_POEMEMORY.CURHP / _POEMEMORY.MAXHP)
							while ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP) == LatestTriggerValue ) {
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;ES________________________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "ES") ) {
				; Flask usage with ES
				if ( ( (_POEMEMORY.CURES / _POEMEMORY.MAXES) < _SCRIPT_ES_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Logout based on ES
				if ( (_POEMEMORY.CURES / _POEMEMORY.MAXES)  < _SCRIPT_DC_VALUE ) {
					if (_SCRIPT_USE_LOGOUT == "yes"){
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							LatestTriggerValue := (_POEMEMORY.CURES / _POEMEMORY.MAXES)
							while ( (_POEMEMORY.CURES / _POEMEMORY.MAXES) == LatestTriggerValue ) {
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;Life+ES (Flask HP)________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "Life+ES (Flask HP)") ) {
				; Flask usage on HP value
				if ( ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP) < _SCRIPT_HP_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Calculate combined HP + ES
				combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
				; Logout based on combined HP + ES
				if (combined_ratio < _SCRIPT_DC_VALUE) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
							LatestTriggerValue := combined_ratio
							while (combined_ratio == LatestTriggerValue) {
								; Recalculate combined ratio inside the loop
								combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;Life+ES (Flask ES)________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "Life+ES (Flask ES)") ) {
				; Flask usage with ES
				if ( ( (_POEMEMORY.CURES / _POEMEMORY.MAXES) < _SCRIPT_ES_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Calculate combined HP + ES
				combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
				; Logout based on combined HP + ES
				if (combined_ratio < _SCRIPT_DC_VALUE) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
							LatestTriggerValue := combined_ratio
							while (combined_ratio == LatestTriggerValue) {
								; Recalculate combined ratio inside the loop
								combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;MIND OVER MATTER__________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "MOM") ) {
				; Calculate the threshold based on whether the "monster_mod_mana_siphoner" buff is present
				if ( _POEMEMORY.BUFFLIST.HasKey("monster_mod_mana_siphoner") == true ) {
					; If the buff is present, increase the threshold by 20%
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE + 0.20
				} else {
					; Otherwise, use the original threshold
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE
				}
				; Logout based on MANA
				if ( (_POEMEMORY.CURMANA / _POEMEMORY.MAXMANA) < _MOM_DC_VALUE ) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if ( _SCRIPT_USE_ESCAPE == "yes" ) {
						if ( CheckPoeWindow() == true ) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							LatestTriggerValue := ( _POEMEMORY.CURMANA / _POEMEMORY.MAXMANA )
							while ( (_POEMEMORY.CURMANA / _POEMEMORY.MAXMANA) == LatestTriggerValue ) {
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;MIND OVER MATTER + LIFE___________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "MOM+Life") ) {
				; Flask usage on HP value
				if ( ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP) < _SCRIPT_HP_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Calculate the threshold based on whether the "monster_mod_mana_siphoner" buff is present
				if ( _POEMEMORY.BUFFLIST.HasKey("monster_mod_mana_siphoner") == true ) {
					; If the buff is present, increase the threshold by 20%
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE + 0.20
				} else {
					; Otherwise, use the original threshold
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE
				}
				; Calculate combined HP + MANA
				combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXMANA)
				; Logout based on combined HP + MANA
				if (combined_ratio < _MOM_DC_VALUE) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXMANA)
							LatestTriggerValue := combined_ratio
							while (combined_ratio == LatestTriggerValue) {
								; Recalculate combined ratio inside the loop
								combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXMANA)
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;MIND OVER MATTER + ES_____________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "MOM+ES") ) {
				; Flask usage on HP value
				if ( ( (_POEMEMORY.CURES / _POEMEMORY.MAXES) < _SCRIPT_ES_VALUE ) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Calculate the threshold based on whether the "monster_mod_mana_siphoner" buff is present
				if ( _POEMEMORY.BUFFLIST.HasKey("monster_mod_mana_siphoner") == true ) {
					; If the buff is present, increase the threshold by 20%
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE + 0.20
				} else {
					; Otherwise, use the original threshold
					_MOM_DC_VALUE := _SCRIPT_DC_VALUE
				}
				; Calculate combined HP + MANA
				combined_ratio := (_POEMEMORY.CURES + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXES + _POEMEMORY.MAXMANA)
				; Logout based on combined HP + MANA
				if (combined_ratio < _MOM_DC_VALUE) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							combined_ratio := (_POEMEMORY.CURES + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXES + _POEMEMORY.MAXMANA)
							LatestTriggerValue := combined_ratio
							while (combined_ratio == LatestTriggerValue) {
								; Recalculate combined ratio inside the loop
								combined_ratio := (_POEMEMORY.CURES + _POEMEMORY.CURMANA) / (_POEMEMORY.MAXES + _POEMEMORY.MAXMANA)
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________

		;LICH Eternal Life_________________________________________________________________________
			if ( (_SCRIPT_AUTOPOT_VERSION == "Lich - Eternal Life (HP)") ) {
				; Flask usage on HP value
				if ( ( (_POEMEMORY.CURHP / _POEMEMORY.MAXHP) < _SCRIPT_HP_VALUE ) AND (_POEMEMORY.CURES == 0) ) {
					if (CheckPoeWindow() == true) {
						PressKey(_SCRIPT_HP_FLASK_KEY, 50)
					}
				}
				; Calculate combined HP + ES
				combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
				; Logout based on combined HP + ES
				if (combined_ratio < _SCRIPT_DC_VALUE) {
					if (_SCRIPT_USE_LOGOUT == "yes") {
						Disconnect(_SCRIPT_PLATFORM)
					}
					if (_SCRIPT_USE_ESCAPE == "yes") {
						if (CheckPoeWindow() == true) {
							PressKey("Esc", 25)
							UserInputBlock(500)
							combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
							LatestTriggerValue := combined_ratio
							while (combined_ratio == LatestTriggerValue) {
								; Recalculate combined ratio inside the loop
								combined_ratio := (_POEMEMORY.CURHP + _POEMEMORY.CURES) / (_POEMEMORY.MAXHP + _POEMEMORY.MAXES)
								THREAD_WAIT(_TICK_UPDATE_CRITICAL)
							}
						}
						else { ; Tabbed out - disconnect for safety
							Disconnect(_SCRIPT_PLATFORM)
						}
					}
				}
			}
		;__________________________________________________________________________________________
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}
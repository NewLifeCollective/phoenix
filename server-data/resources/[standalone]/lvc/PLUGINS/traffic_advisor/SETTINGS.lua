--------------------TRAFFIC ADVISOR SETTINGS---------------------
ta_masterswitch = true
--	Determines if traffic_advisor plugin can be activated.
ta_combokey = false
--  Key that needs to be pressed in combination with registered key mapping. Set to false to disable. (default: disabled (false))
--  List of Controls: https://docs.fivem.net/docs/game-references/controls/
ta_sync_radius_default = 20


--[[ Documentation / Wiki: https://docs.luxartengineering.com/shared-plugins/traffic-advisor ]]

TA_ASSIGNMENTS = {
    ['DEFAULT'] = { },
    ['gameName'] = { 	lightbar = 3, 
              left = { on = { add = 8, remove = 7, repair = true }, off = { add = {}, remove = { 7, 8 } } }, 
              right = { on = { add = 7, remove = 8, repair = true }, off = { add = {}, remove = { 7, 8 } } }, 
              middle = { on = { add = { 7, 8 }, remove = {}, repair = true }, off = { add = {}, remove = { 7, 8 } } }, 
          },   
  }
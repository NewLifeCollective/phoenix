--------------------TRAFFIC ADVISOR SETTINGS---------------------
ta_masterswitch = true
--	Determines if traffic_advisor plugin can be activated.
ta_combokey = false
--  Key that needs to be pressed in combination with registered key mapping. Set to false to disable. (default: disabled (false))

--[[ Documentation / Wiki: https://github.com/TrevorBarns/luxart-vehicle-control/wiki/Traffic-Advisor ]]

TA_ASSIGNMENTS = {
  ['DEFAULT'] = { },
  ['2vdbuffalo4m'] = { 
    lightbar = -1,
	right = { on = { add = 1, remove = { 2, 7 }, repair = false }, off = { add = {}, remove = 1 } },
	left = { on = { add = { 2, 7 }, remove = 1, repair = false }, off = { add = {}, remove = 2  } },
  },
  ['2vdbuffalo4s'] = { 
    lightbar = -1,
	right = { on = { add = 1, remove = { 2, 7 }, repair = false }, off = { add = {}, remove = 1 } },
	left = { on = { add = { 2, 7 }, remove = 1, repair = false }, off = { add = {}, remove = 2  } },
  },  

}
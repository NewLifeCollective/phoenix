Config = {}

Config.comId = 'K2UU9F5R'
Config.apiKey = '9539f8d5-5594-4244-8edc-7504391b2171'
Config.radioUrl = 'https://sonoranradio.com' -- DO NOT CHANGE FROM 'https://sonoranradio.com' UNLESS YOU KNOW WHAT YOU ARE DOING (Developer)
Config.apiUrl = 'https://api.sonoranradio.com/' -- DO NOT CHANGE FROM 'https://api.sonoranradio.com/' UNLESS YOU KNOW WHAT YOU ARE DOING (Developer)
Config.debug = false
Config.allowUpdateWithPlayers = true
Config.enableCanary = false
Config.allowAutoUpdate = true
Config.chatter = true -- Hear chatter from other players if their radio is on
Config.towerRepairTimer = 20 -- Time in seconds to repair towers
Config.rackRepairTimer = 15  -- Time in seconds to repair server racks
Config.antennaRepairTimer = 15 -- Time in seconds to repair cell repeater antennas
Config.acePermSync = true -- Sync radio community auto-approval and permissions with ace permissions
Config.acePermsForServerRepair = false -- Restrict repairs for servers to an ace permission
Config.acePermsForTowerRepair = false -- Restrict repairs for towers to an ace permission
Config.acePermsForAntennaRepair = false -- Restrict repairs for cell repeater antennas to an ace permission
Config.acePermsForScanners = false -- Restrict using the scanner to an ace permission
Config.acePermsForRadio = true -- Restrict usage of the radio to an ace permission
Config.acePermsForRadioUsers = false -- Restrict usage of the radio users to an ace permission
Config.enforceRadioItem = false
Config.RadioItem = {		 -- Note: Changes to this item will require a server restart to take effect
	name = 'sonoran_radio',  -- Item name in your inventory
	label = 'Sonoran Radio', -- Label for the item in your inventory
	weight = 1, 			 -- Weight of the item in your inventory
	description = 'Communicate with others through the Sonoran Radio', -- Description of the item in your inventory
}
Config.ScannerItem = {
	name = 'sonoran_radio_scanner', -- Item ID
	label = 'Sonoran Radio Scanner', -- Label for the item in your inventory
	weight = 1, -- Weight of the item in your inventory
	description = 'Listen to radio chatter with the Sonoran Radio Scanner', -- Description of the item in your inventory
}
Config.disableRadioOnDeath = false -- Disables radio when dead
Config.restoreRadioStateWhenAlive = true -- Restore the radio on/off status when you revive or respawn
Config.deathDetectionMethod = 'auto' -- auto | manual | qbcore
Config.disableAnimation = false -- Disable the radio animation if you are using a custom radio animation script
Config.noPhysicalCellRepeaters = false -- Set to true to hide physical cell repeaters
Config.noPhysicalRacks = false -- Set to true to hide physical server racks
Config.noPhysicalTowers = false -- Set to true to hide physical towers
Config.talkSync = true -- Enable talking on the radio making you talk in game
Config.emergencyCallCommand = '911' -- Command suffix to start or stop an emergency call (i.e. '911' == /radio 911)
Config.luxartResourceName = 'lvc' -- Resource name for Luxart Vehicle Control (Required for siren control)

-- Notification Settings --
Config.notifications = {
	type = 'native', -- Available options: native, pNotify, okokNotify, or custom
	notificationTitle = 'SonoranRadio', -- Notification Title for methods that support it
	-- Uncomment line below and comment line 105 if you plan to use pNotify
	-- notificationMessage = "<b>SonoranRadio</b></br>{{MESSAGE}}"
	notificationMessage = '~b~SonoranRadio~w~\n{{MESSAGE}}', -- The text of the notification
	custom = function(notification) -- Custom notification function, only used if type is set to custom
		Utilities.Logging.logDebug('Custom notification function called with notification: ' .. notification)
		exports.pNotify:SendNotification({
			['type'] = 'info',
			['text'] = '<b style=\'color:blue\'>SonoranRadio</b><br/>Notification: ' .. notification .. ''
		})
	end
}

-- Default radio keybinds (these can be changed in GTA settings) --
Config.keybinds = {
	['toggle'] = '',
	['ptt'] = '\\',

	['power'] = '',
	['panic'] = '*',
	['nextChannel'] = '',
	['prevChannel'] = '',
	['talkAnim'] = '',
	['nextGroup'] = '',
	['prevGroup'] = '',
	['volUp'] = '',
	['volDown'] = ''
}

-- Radio Item Settings --
Config.frames = {
	permissionMode = 'ace', -- ace, qbcore, esx or none
	adminPermission = 'sonoranradio.admin', -- ACE permission required to use admin commands
	departments = {
		['sasp'] = {
			label = 'San Andreas State Patrol',
			permissions = {
				jobs = { -- Jobs that can use this department
					['police'] = {
						grades = { -- Job grades that can use this department
						0,	
						1,
						2,
						3,
						4,
						5,
						6,
						7
						}
					}
				},
				ace = { -- ACE Permissions that can use this department | ONLY EFFECTIVE IN ACE PERMISSION MODE
					'sonoranradio.sasp'
				}
			},
			-- Radio frames that can be used by this department
			allowedFrames = {
				'default',
				'signalpro',
				'voxguard',
				'hi-vis'
			}
		}
	}
}

-- Enable mobile repeaters
Config.enableVehicleRepeaters = true
-- Mobile repeater keybinds
Config.mobileRepeaterKeybind = {
	mapperType = 'keyboard', -- See: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/
	map = 'g', -- See: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/
	label = 'Toggle Radio Repeater'
}
-- Mobile repeater spawncodes
Config.repeaterVehicleSpawncodes = {
	{
		model = 'police',
		label = 'Police Vehicle',
		range = 200
	},
	{
		model = 'police2',
		label = 'Police Vehicle',
		range = 200
	},
	{	model = 'police5',
		label = 'Police Vehicle',
		range = 200
	}
}
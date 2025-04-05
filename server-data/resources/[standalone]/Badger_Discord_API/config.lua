Config = {
	Guild_ID = '1344861967982268547', -- Set to the ID of your guild (or your Primary guild if using Multiguild)
	Multiguild = false, -- Set to true if you want to use multiple guilds
	Guilds = {
		["NewLife"] = "1344861967982268547", -- Replace this with a name, like "main"
	},
	Bot_Token = GetConvar('perms_discord_token', ''),
	RoleList = {
		['lead'] = 1344861968032465029,
		['staff'] = 1347205327778746368,
		['leo'] = 1344861967982268551,
		['fireems'] = 1348179588802543659,
		['civilian'] = 1344861967982268550, -- Verified/Civilian/Tow
	},
	DebugScript = false,
	CacheDiscordRoles = true, -- true to cache player roles, false to make a new Discord Request every time
	CacheDiscordRolesTime = 60, -- if CacheDiscordRoles is true, how long to cache roles before clearing (in seconds)
}

Config.Splash = {
	Header_IMG = 'https://forum.cfx.re/uploads/default/original/3X/a/6/a6ad03c9fb60fa7888424e7c9389402846107c7e.png',
	Enabled = false,
	Wait = 10, -- How many seconds should splash page be shown for? (Max is 12)
	Heading1 = "Welcome to NewLife Collective",
	Heading2 = "Make sure to join our Discord and check out our website!",
	Discord_Link = 'https://discord.gg/nlcollective',
	Website_Link = 'https://badger.store',
}
exports.ox_target:addBoxZone({
	name = "mrpd_evidence",
	coords = vec3(473.25, -990.75, 26.5),
	size = vec3(1.0, 2.25, 1.0),
	rotation = 0.0,
})
{
	name = "mrpd_evidence",
	coords = vec3(473.35, -990.75, 26.55),
	size = vec3(1.0, 2.15, 0.75),
	rotation = 0.0,
},
{
	name = "mrpd_garage",
	coords = vec3(441.45, -989.7, 26.0),
	size = vec3(15.5, 11.5, 2.5),
	rotation = 0.0,
},
{
	name = "test",
	coords = vec3(441.5, -990.0, 26.0),
	size = vec3(15.5, 11.5, 2.5),
	rotation = 0.0,
},
local box = lib.zones.box({
	name = "mrpd_garage",
	coords = vec3(442.0, -989.9, 26.0),
	size = vec3(15.5, 11.5, 2.5),
	rotation = 0.0,
})
local poly = lib.zones.poly({
	name = "mrpd_garage",
	points = {
		vec3(448.89999389648, -984.40002441406, 26.0),
		vec3(434.29998779296, -984.54998779296, 26.0),
		vec3(434.14999389648, -996.20001220704, 26.0),
		vec3(449.0, -996.04998779296, 26.0),
	},
	thickness = 3.25,
})

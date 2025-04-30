Config = {}

-- Debug --
Config.Debug = false -- true or false if you want it

-- Base --
Config.Framework = 3 -- 1 - esx or 2 - qb or 3 - none, if none you have to set notify to other, allowed jobs to nil and you cant use items or inventory check
Config.FrameworkExport = 'qb-core' -- 'es_extended' or 'qb-core'
Config.Notify = 3 -- 1 - esx, 2 - qb or 3 - other
Config.Target = 1 --  1 - ox-target, 2 - qb-target or 3 - none
Config.QBTargetExport = 'qb-target' -- work only if you use qb-target
Config.TargetIcon = 'fa-solid fa-podcast' -- icon for target
Config.AllowedJobs = {'police'} -- You can add more or nil for everyone // if you use Config.Framework = 'none' you should this let it be on nil... // You can add table like this {'police', 'ambulance'} or nil or 'police' this only works for ox-target // qb-target settings is different, if you want to use multiple jobs you have to set {['police'] = 0, ['ambulance'] = 0} this means job.name and grade
Config.GradesOnly = false -- True or false, use only if you dont use target system, if you turn true you have to only use ['police'] = 0, ['ambulance'] = 4 etc... in AllowedJobs

-- Animation --
Config.Times = {
    addClamp = 10000, -- Time to put on wheelclamp
    removeClamp = 10000 -- Time to take off wheelclamp
}
-- Language --
Config.Language = {
    ['targetLabel'] = 'Put on/Put off Wheelclamp',
    ['displayText'] = 'Press ~INPUT_CONTEXT~ to put on/take off wheel clamp',
    ['noJob'] = 'You arent allowed person!',
    ['noItem'] = 'You dont have wheelclamp!'
}
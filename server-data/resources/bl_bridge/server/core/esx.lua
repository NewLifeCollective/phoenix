local Core = {}
local shared = exports["es_extended"]:getSharedObject()
local Utils = require 'utils'
local merge = Utils.table_merge

RegisterNetEvent('esx:playerLoaded', function(...)
    TriggerEvent('bl_bridge:server:playerLoaded', source, ...)
end)

AddEventHandler("esx:playerLoaded", function(playerId, xPlayer)
    TriggerEvent('bl_bridge:server:playerLoaded', playerId, xPlayer)
end)

AddEventHandler('esx:setAccountMoney', function(player, accountName, money)
    TriggerEvent('bl_bridge:server:updateMoney', player, accountName == 'money' and 'cash' or accountName, money, 'set')
end)

AddEventHandler('esx:removeAccountMoney', function(source, accountName, money)
    TriggerEvent('bl_bridge:server:updateMoney', source, accountName == 'money' and 'cash' or accountName, money, 'remove')
end)

AddEventHandler('esx:addAccountMoney', function(source, accountName, money)
    TriggerEvent('bl_bridge:server:updateMoney', source, accountName == 'money' and 'cash' or accountName, money, 'add')
end)

local inventoryFunctions = Framework.inventory
local coreFunctionsOverride = {
    getBalance = {
        originalMethod = 'getAccount',
        modifier = {
            effect = function(originalFun, type)
                return originalFun(type == 'cash' and 'money' or type).money
            end
        }
    },
    removeBalance = {
        originalMethod = 'removeAccountMoney',
        modifier = {
            effect = function(originalFun, type, amount)
                return originalFun(type == 'cash' and 'money' or type, amount)
            end
        }
    },
    setBalance = {
        originalMethod = 'setAccountMoney',
        modifier = {
            effect = function(originalFun, type, amount)
                return originalFun(type == 'cash' and 'money' or type, amount)
            end
        }
    },
    addBalance = {
        originalMethod = 'addAccountMoney',
        modifier = {
            effect = function(originalFun, type, amount)
                return originalFun(type == 'cash' and 'money' or type, amount)
            end
        }
    },
    setJob = {
        originalMethod = 'setJob',
    },
    
    job = {
        originalMethod = 'getJob',
        modifier = {
            executeFunc = true,
            effect = function(data)
                local job = data()
                return {name = job.name, label = job.label, onDuty = true, isBoss = false, grade = {name = job.grade, label = job.grade_label, salary = job.grade_salary}}
            end
        }
    },
    charinfo = {
        originalMethod = 'variables',
        modifier = {
            executeFunc = true,
            effect = function(data)
                return {firstname = data.firstName, lastname = data.lastName}
            end
        }
    },
    name = {
        originalMethod = 'getName',
        modifier = {
            executeFunc = true,
        }
    },
    id = {
        originalMethod = 'identifier',
        modifier = {
            executeFunc = true,
            effect = function(str)
                return str
            end
        }
    },
    gender = {
        originalMethod = 'variables',
        modifier = {
            executeFunc = true,
            effect = function(data)
                return data.sex == 'm' and 'male' or 'female'
            end
        }
    },
    dob = {
        originalMethod = 'variables',
        modifier = {
            executeFunc = true,
            effect = function(data)
                local dob = data.dateofbirth
                if type(dob) ~= 'string' then return end
                local month, day, year = dob:match("(%d+)/(%d+)/(%d+)")
                return ('%s/%s/%s'):format(month, day, year)
            end
        }
    },
}

local totalFunctionsOverride = inventoryFunctions and merge(inventoryFunctions.methods, coreFunctionsOverride) or coreFunctionsOverride

function Core.CommandAdd(name, permission, cb, suggestion, flags)
    shared.RegisterCommand(name, permission, cb, flags.allowConsole, suggestion)
end

Core.RegisterUsableItem = inventoryFunctions?.registerUsableItem or function(name, cb)
    shared.RegisterUsableItem(name, cb)
end

function Core.GetPlayer(src)
    local player = shared.GetPlayerFromId(src)
    if not player then return end
    local wrappedPlayer = Utils.retreiveStringIndexedData(player, totalFunctionsOverride, src)
    return wrappedPlayer
end

Core.Players = shared.Players
return Core
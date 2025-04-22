QBCore = nil
ESX = nil

Citizen.CreateThread(function()
    if Config.Enable_QBCore_Permissions.Check_By_Job or Config.Enable_QBCore_Permissions.Check_By_Permissions then
        QBCore = exports["qb-core"]:GetCoreObject()
    end

    if Config.Enable_ESX_Permissions then
        ESX = exports["es_extended"]:getSharedObject()
    end
end)

function PermissionCheck()
    local permission = false

    if Config.EveryoneHasPermission then
        return true
    end

    -- Role amount check
    if #Config.PermissionRoles < 1 then return print("You've not set up any roles for permissions in the config.lua") end

    -- ESX Job Permissions
    if Config.Enable_ESX_Permissions then
        if ESX == nil then return print("You've enabled ESX permissions, but the ESX framework has not been found...") end
        local IsLoaded = ESX.IsPlayerLoaded()
        if IsLoaded then
            local xPlayer = ESX.GetPlayerData()
            if xPlayer then
                for k, v in pairs(Config.PermissionRoles) do
                    if xPlayer.job.name == v then
                        permission = true
                        break
                    end
                end
            end
        else
            print("Could not check your permission because your player has not loaded in...")
        end
    end

    -- QBCore Job Based
    if Config.Enable_QBCore_Permissions.Check_By_Job then
        if QBCore == nil then return print("You've enabled QBCore job permissions, but the QBCore framework has not been found...") end
        local Player = QBCore.Functions.GetPlayerData()
        local jobName = Player.job.name
        -- local player = QBCore.Functions.GetPlayer(source)
        if Player then
            for k, v in pairs(Config.PermissionRoles) do
                if jobName == v then
                    permission = true
                    break
                end
            end
        end
    end

    return permission
end

function message(lineOne, lineTwo, lineThree, duration)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(lineOne)
    AddTextComponentSubstringPlayerName(lineTwo or "")
    AddTextComponentSubstringPlayerName(lineThree or "")
    EndTextCommandDisplayHelp(0, false, false, duration or 5000)
end

function notify(notificationText, notificationDuration, notificationPosition, notificationType)
    if Config.Enable_custom_messages then
        exports.bulletin:Send({ 
            message = notificationText,
            timeout = notificationDuration,
            position = notificationPosition,
            progress = true,
            theme = notificationType,
            flash = false
        })
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(notificationText)
        DrawNotification(true, true)
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function allToUpper(str)
    return (string.upper(str))
end


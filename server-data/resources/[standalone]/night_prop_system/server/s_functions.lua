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

function CheckPermission(source)
    local permission = false

    if Config.EveryoneHasPermission then
        return true
    end

    -- Role amount check
    if #Config.PermissionRoles < 1 then return print("You've not set up any roles for permissions in the config.lua") end

    -- Discord API Permissions
    if Config.Enable_Night_DiscordApi_Permissions then
        local isPermitted = exports.night_discordapi:IsMemberPartOfAnyOfTheseRoles(source, Config.PermissionRoles, false)
        if isPermitted then
            permission = true
        end
    end

    -- Ace Permissions
    if Config.Enable_Ace_Permissions then
        for k, v in ipairs(Config.PermissionRoles) do
            if IsPlayerAceAllowed(source, v) then
                permission = true
                break
            end
        end
    end

    -- ESX Job Permissions
    if Config.Enable_ESX_Permissions then
        if ESX == nil then return print("You've enabled ESX permissions, but the ESX framework has not been found...") end
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            for k, v in pairs(Config.PermissionRoles) do
                if xPlayer.job.name == v then
                    permission = true
                end
            end
        end
    end

    -- QBCore Job Based
    if Config.Enable_QBCore_Permissions.Check_By_Job then
        if QBCore == nil then return print("You've enabled QBCore job permissions, but the QBCore framework has not been found...") end
        local player = QBCore.Functions.GetPlayer(source)
        if player then
            for k, v in pairs(Config.PermissionRoles) do
                if player.PlayerData.job.name == v then
                    permission = true
                end
            end
        end
    end

    -- QBCore Permission based
    if Config.Enable_QBCore_Permissions.Check_By_Permissions then
        if QBCore == nil then return print("You've enabled QBCore group permissions, but the QBCore framework has not been found...") end
        local player = QBCore.Functions.GetPlayer(source)
        if player then
            for k, v in pairs(Config.PermissionRoles) do
                if QBCore.Functions.HasPermission(source, v) then
                    permission = true
                end
            end
        end
    end
    return permission
end

--============ Debug ============--

function DebugPrint(msg)
    if Config.Debug then
        if msg ~= nil then
            print("["..GetCurrentResourceName().."] "..msg)
        end
    end
end
-- Use qbx_core (underscore) directly
local QBCore = exports.qbx_core

-- Register /dgun command
RegisterCommand('dgun', function(source, args, rawCommand)
    local src = source
    -- Trigger client-side toggle (no permission check)
    TriggerClientEvent('tcr_entityremover:toggleDeleteGun', src)
end, false)

-- Register /dgun_suggest command to manually trigger suggestion
RegisterCommand('dgun_suggest', function(source, args, rawCommand)
    TriggerClientEvent('tcr_entityremover:addChatSuggestion', source)
end, false)

-- Add chat suggestion (server-side, fallback)
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', {
            name = '/dgun',
            help = 'Enable/Disable delete gun'
        })
        if Config.Debug then
        print("[DEBUG] Server-side chat suggestion added for /dgun")
        end
    end
end)

-- Register /dv command (no permission check)
RegisterCommand('dv', function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('tcr_entityremover:deleteVehicle', source)
end, false)

-- Register Chat Command
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', {
            name = '/dv',
            help = 'Delete Vehicle'
        })
        if Config.Debug then
        print("[DEBUG] Server-side chat suggestion added for /dv")
        end
    end
end)

-- Server-side vehicle deletion
RegisterNetEvent('tcr_entityremover:deleteVehicleServer', function(networkId)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(networkId)
    if DoesEntityExist(entity) and IsEntityAVehicle(entity) then
        if DeleteEntity(entity) then
            if Config.Debug then
                print("[DEBUG] Server-side vehicle deleted: NetID=" .. tostring(networkId))
            end
        else
            if Config.Debug then
                print("[DEBUG] Server-side vehicle deletion failed: NetID=" .. tostring(networkId))
            end
            TriggerClientEvent('QBCore:Notify', src, 'Failed to delete vehicle (server-side)', 'error', 5000)
        end
    else
        if Config.Debug then
            print("[DEBUG] Invalid or non-vehicle entity: NetID=" .. tostring(networkId))
        end
        TriggerClientEvent('QBCore:Notify', src, 'Invalid vehicle (server-side)', 'error', 5000)
    end
end)
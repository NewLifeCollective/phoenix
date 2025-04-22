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
        print("[DEBUG] Server-side chat suggestion added for /dgun")
    end
end)
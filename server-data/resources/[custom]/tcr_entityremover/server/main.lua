-- tcr_entityremover - A FiveM resource for NewLife Collective
-- Copyright (C) 2025 TheClassyR3dneck
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <https://www.gnu.org/licenses/>.

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

-- Register /dv Chat Command
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

-- Register /cleararea chat command
RegisterCommand('cleararea', function(source, args, rawCommand)
    local src = source 
    TriggerClientEvent('tcr_entityremover:clearArea', source)
end, false)

-- Register /clear area chat command
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', {
            name = '/cleararea',
            help = 'Clear Area'
        })
        if Config.Debug then
        print("[DEBUG] Server-side chat suggestion added for /cleararea")
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
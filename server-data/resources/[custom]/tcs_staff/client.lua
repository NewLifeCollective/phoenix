local blipsEnabled = false

RegisterCommand('toggleblips', function()
    TriggerServerEvent('tcr_staff:checkPermission')
end, false)

RegisterNetEvent('tcr_staff:receivePermission')
AddEventHandler('tcr_staff:receivePermission', function(hasPermission)
    if hasPermission then
        blipsEnabled = not blipsEnabled
        if blipsEnabled then
            createPlayerBlips()
        else
            removePlayerBlips()
        end
    else
        print("You do not have permission to toggle player blips.")
    end
end)

function createPlayerBlips()
    local players = GetActivePlayers()
    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local playerBlip = AddBlipForEntity(playerPed)
        SetBlipSprite(playerBlip, 1)  -- Set blip icon (1 for a dot)
        SetBlipColour(playerBlip, 3)  -- Set blip color (3 for green)
        SetBlipScale(playerBlip, 0.7)  -- Set the size of the blip
        SetBlipAsShortRange(playerBlip, true)  -- Only show blips near the player
    end
end

function removePlayerBlips()
    for _, blip in ipairs(GetActiveBlips()) do
        RemoveBlip(blip)
    end
end

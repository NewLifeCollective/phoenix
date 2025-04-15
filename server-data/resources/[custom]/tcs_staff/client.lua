local showBlips = false
local playerBlips = {}

RegisterCommand("toggleblips", function()
    if Config.OnlyAllowStaff and not IsPlayerAceAllowed(PlayerId(), Config.Permission) then
        print("You cannot use this.")
        return
    end

    showBlips = not showBlips
    if showBlips then
        print("Staff blips: ON")
        StartBlipLoop()
    else
        print("Staff blips: OFF")
        ClearBlips()
    end
end)

function StartBlipLoop()
    Citizen.CreateThread(function()
        while showBlips do
            Citizen.Wait(1000)
            ClearBlips()

            for _, id in ipairs(GetActivePlayers()) do
                if id ~= PlayerId() then
                    local ped = GetPlayerPed(id)
                    if DoesEntityExist(ped) then
                        local blip = AddBlipForEntity(ped)
                        SetBlipSprite(blip, Config.BlipSprite)
                        SetBlipScale(blip, Config.BlipScale)
                        SetBlipColour(blip, Config.BlipColor)
                        SetBlipCategory(blip, 7)

                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(GetPlayerName(id))
                        EndTextCommandSetBlipName(blip)

                        playerBlips[id] = blip
                    end
                end
            end
        end
        ClearBlips()
    end)
end

function ClearBlips()
    for _, blip in pairs(playerBlips) do
        RemoveBlip(blip)
    end
    playerBlips = {}
end

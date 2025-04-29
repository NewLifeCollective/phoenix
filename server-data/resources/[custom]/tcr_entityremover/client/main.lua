-- Use qbx_core (underscore) directly
local QBCore = exports.qbx_core
local isDeleteGunEnabled = false
local deleteGunTimeout = nil

-- Print script version to confirm correct file
print("[DEBUG] tcr_entityremover client.lua version: 2025-04-23")

-- Function to check if a weapon is allowed
local function isWeaponAllowed(weaponHash)
    local isAllowed = false
    for _, allowedWeapon in ipairs(Config.DeleteGun.Weapons) do
        if weaponHash == allowedWeapon then
            isAllowed = true
            break
        end
    end
    print("[DEBUG] Checking weapon: Hash=" .. tostring(weaponHash) .. ", Allowed=" .. tostring(isAllowed))
    return Config.DeleteGun.UseAllowList and isAllowed or not isAllowed
end

-- Function to check if vehicle is occupied by a player (allow NPC-occupied vehicles)
local function isVehiclePlayerOccupied(vehicle)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for seat = -1, maxSeats - 1 do
        local ped = GetPedInVehicleSeat(vehicle, seat)
        if ped ~= 0 then
            local isPlayer = IsPedAPlayer(ped)
            print("[DEBUG] Seat " .. seat .. ": Ped=" .. tostring(ped) .. ", IsPlayer=" .. tostring(isPlayer))
            if isPlayer then
                return true -- Player found, block deletion
            end
        end
    end
    return false -- No players, allow deletion (even if NPCs are present)
end

-- Add client-side chat suggestion
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
--        print("[DEBUG] Client-side chat suggestion added for /dgun")
    end
end)

-- Manual suggestion trigger
RegisterNetEvent('tcr_entityremover:addChatSuggestion', function()
    TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
   -- print("[DEBUG] Manual chat suggestion triggered for /dgun")
end)

-- Toggle delete gun
RegisterNetEvent('tcr_entityremover:toggleDeleteGun', function()
    isDeleteGunEnabled = not isDeleteGunEnabled
    
    -- Clear existing timeout
    if deleteGunTimeout then
        ClearTimeout(deleteGunTimeout)
        deleteGunTimeout = nil
    end
    
    if isDeleteGunEnabled then
        -- Show enabled notification
        lib.notify({
            title = 'Delete Gun',
            description = 'Delete Gun Enabled',
            type = 'success',
            duration = 5000
        })
        
        -- Set 30-second timeout
        deleteGunTimeout = SetTimeout(30000, function()
            isDeleteGunEnabled = false
            lib.notify({
                title = 'Delete Gun',
                description = 'Delete Gun Disabled (Auto Timeout)',
                type = 'inform',
                duration = 5000
            })
        end)
    else
        -- Show disabled notification
        lib.notify({
            title = 'Delete Gun',
            description = 'Delete Gun Disabled',
            type = 'inform',
            duration = 5000
        })
    end
end)

-- Handle shooting logic with raycasting and fallback
Citizen.CreateThread(function()
    while true do
        if isDeleteGunEnabled then
            local playerPed = PlayerPedId()
            local weaponHash = GetSelectedPedWeapon(playerPed)
            
            -- Check if player is shooting with an allowed weapon
            if IsPedShooting(playerPed) and isWeaponAllowed(weaponHash) then
                -- Try raycast first
                local startPos = GetPedBoneCoords(playerPed, 31086, 0.0, 0.0, 0.0) -- Player's head
                local endPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5000.0, 0.0) -- 5000 units forward
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(
                    StartShapeTestRay(startPos, endPos, -1, playerPed) -- -1 = all entities
                )
                
                print(string.format("[DEBUG] Raycast: StartPos=%s, EndPos=%s, Hit=%s, Entity=%s, IsVehicle=%s, EndCoords=%s, EntityType=%s, EntityModel=%s", 
                tostring(startPos), tostring(endPos), tostring(hit), tostring(entityHit), 
                tostring(IsEntityAVehicle(entityHit)), tostring(endCoords), 
                tostring(GetEntityType(entityHit)), entityHit and tostring(GetEntityModel(entityHit)) or "N/A"))
            
                
                -- Fallback to GetEntityPlayerIsAimingAt if raycast fails
                if not hit or not entityHit or not IsEntityAVehicle(entityHit) then
                    local success, aimedEntity = GetEntityPlayerIsAimingAt(PlayerId())
                    if success and DoesEntityExist(aimedEntity) then
                        entityHit = aimedEntity
                        hit = true
                        endCoords = GetEntityCoords(entityHit)
                        print(string.format("[DEBUG] Fallback Aiming: Entity=%s, IsVehicle=%s, EntityType=%s, EntityModel=%s", 
                            tostring(entityHit), tostring(IsEntityAVehicle(entityHit)), 
                            tostring(GetEntityType(entityHit)), tostring(GetEntityModel(entityHit))))
                    end
                end
                
                if hit and DoesEntityExist(entityHit) and IsEntityAVehicle(entityHit) then
                    print("[DEBUG] Vehicle detected, checking player occupancy")
                    if not isVehiclePlayerOccupied(entityHit) then
                        print("[DEBUG] No players in vehicle, attempting deletion")
                        -- Ensure network control and mission entity status
                        if NetworkGetEntityOwner(entityHit) == PlayerId() or NetworkRequestControlOfEntity(entityHit) then
                            SetEntityAsMissionEntity(entityHit, true, true)
                            DeleteVehicle(entityHit)
                            if not DoesEntityExist(entityHit) then
                                lib.notify({
                                    title = 'Delete Gun',
                                    description = 'Vehicle deleted',
                                    type = 'success',
                                    duration = 3000
                                })
                                print("[DEBUG] Vehicle deleted successfully")
                            else
                                lib.notify({
                                    title = 'Delete Gun',
                                    description = 'Failed to delete vehicle',
                                    type = 'error',
                                    duration = 3000
                                })
                                print("[DEBUG] Vehicle deletion failed")
                            end
                        else
                            lib.notify({
                                title = 'Delete Gun',
                                description = 'Cannot delete: No network control',
                                type = 'error',
                                duration = 3000
                            })
                            print("[DEBUG] No network control of vehicle")
                        end
                    else
                        lib.notify({
                            title = 'Delete Gun',
                            description = 'Cannot delete vehicle with players',
                            type = 'error',
                            duration = 3000
                        })
                        print("[DEBUG] Vehicle has players")
                    end
                else
                    print("[DEBUG] No vehicle detected")
                end
            end
        end
        Wait(isDeleteGunEnabled and 0 or 100) -- Optimize performance when disabled
    end
end)
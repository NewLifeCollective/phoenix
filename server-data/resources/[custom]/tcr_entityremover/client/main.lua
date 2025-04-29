-- Ensure qbx_core is loaded correctly
local QBCore = exports.qbx_core
local isDeleteGunEnabled = false
local deleteGunTimeout = nil

-- Print script version to confirm correct file (only in debug mode)
if Config.Debug then
    print("[DEBUG] tcr_entityremover client.lua version: 2025-04-23")
end

-- Vehicle enumeration helper
local function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, vehicle = FindFirstVehicle()
        local success
        repeat
            coroutine.yield(vehicle)
            success, vehicle = FindNextVehicle(handle)
        until not success
        EndFindVehicle(handle)
    end)
end

-- Function to check if a weapon is allowed
local function isWeaponAllowed(weaponHash)
    local isAllowed = false
    for _, allowedWeapon in ipairs(Config.DeleteGun.Weapons) do
        if weaponHash == allowedWeapon then
            isAllowed = true
            break
        end
    end
    if Config.Debug then
        print("[DEBUG] Checking weapon: Hash=" .. tostring(weaponHash) .. ", Allowed=" .. tostring(isAllowed))
    end
    return Config.DeleteGun.UseAllowList and isAllowed or not isAllowed
end

-- Function to check if vehicle is occupied by a player (allow NPC-occupied vehicles)
local function isVehiclePlayerOccupied(vehicle)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for seat = -1, maxSeats - 1 do
        local ped = GetPedInVehicleSeat(vehicle, seat)
        if ped ~= 0 then
            local isPlayer = IsPedAPlayer(ped)
            if Config.Debug then
                print("[DEBUG] Seat " .. seat .. ": Ped=" .. tostring(ped) .. ", IsPlayer=" .. tostring(isPlayer))
            end
            if isPlayer then
                return true -- Player found, block deletion
            end
        end
    end
    return false -- No players, allow deletion (even if NPCs are present)
end

-- Function to safely check if an entity exists and is valid
local function isEntityValid(entity)
    return DoesEntityExist(entity) and not IsEntityDead(entity)
end

-- Add client-side chat suggestion
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
        -- print("[DEBUG] Client-side chat suggestion added for /dgun") -- Commented out as per original
    end
end)

-- Manual suggestion trigger
RegisterNetEvent('tcr_entityremover:addChatSuggestion', function()
    TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
    -- print("[DEBUG] Manual chat suggestion triggered for /dgun") -- Commented out as per original
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
        -- Show enabled notification (always active)
        lib.notify({
            title = 'Delete Gun',
            description = 'Delete Gun Enabled',
            type = 'success',
            duration = 5000
        })
        
        -- Set 60-second timeout
        deleteGunTimeout = SetTimeout(60000, function()
            isDeleteGunEnabled = false
            lib.notify({
                title = 'Delete Gun',
                description = 'Delete Gun Disabled (Auto Timeout)',
                type = 'inform',
                duration = 5000
            })
        end)
    else
        -- Show disabled notification (always active)
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
        Citizen.Wait(0)
        if isDeleteGunEnabled then
            local playerPed = PlayerPedId()
            local weaponHash = GetSelectedPedWeapon(playerPed)
            
            -- Check if player is shooting with an allowed weapon
            if IsPedShooting(playerPed) and isWeaponAllowed(weaponHash) then
                -- Try raycast first, targeting vehicles and objects
                local startPos = GetPedBoneCoords(playerPed, 31086, 0.0, 0.0, 0.0) -- Player's head
                local endPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5000.0, 0.0) -- 5000 units forward
                local rayHandle = StartShapeTestRay(startPos, endPos, 10, playerPed) -- 10 = vehicles + objects
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                
                -- Validate entityHit immediately
                local isEntityHitValid = entityHit and entityHit ~= 0 and DoesEntityExist(entityHit)
                
                if Config.Debug then
                    print(string.format("[DEBUG] Raycast: StartPos=%s, EndPos=%s, Hit=%s, Entity=%s, IsValid=%s, IsVehicle=%s, EndCoords=%s", 
                        tostring(startPos), tostring(endPos), tostring(hit), tostring(entityHit), 
                        tostring(isEntityHitValid), tostring(IsEntityAVehicle(entityHit)), tostring(endCoords)))
                end
                
                -- Handle NPC driver if hit
                local vehicleToDelete = nil
                if isEntityHitValid and GetEntityType(entityHit) == 1 then -- 1 = ped
                    if Config.Debug then
                        print("[DEBUG] Hit a ped: " .. tostring(entityHit))
                    end
                    -- Check if ped is a vehicle driver
                    for vehicle in EnumerateVehicles() do
                        if GetPedInVehicleSeat(vehicle, -1) == entityHit then
                            vehicleToDelete = vehicle
                            if Config.Debug then
                                print("[DEBUG] Ped is driver of vehicle: " .. tostring(vehicle))
                            end
                            -- Delete the NPC driver
                            if NetworkRequestControlOfEntity(entityHit) then
                                SetEntityAsMissionEntity(entityHit, true, true)
                                DeleteEntity(entityHit)
                                Wait(50) -- Small delay to ensure ped deletion
                                if Config.Debug then
                                    print("[DEBUG] NPC driver deleted")
                                end
                            else
                                if Config.Debug then
                                    print("[DEBUG] Failed to get control of NPC driver")
                                end
                            end
                            break
                        end
                    end
                end
                
                -- Retry raycast if NPC was deleted or use original entity
                if vehicleToDelete then
                    -- Perform a new raycast to hit the vehicle
                    rayHandle = StartShapeTestRay(startPos, endPos, 2, playerPed) -- 2 = vehicles only
                    _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                    isEntityHitValid = entityHit and entityHit ~= 0 and DoesEntityExist(entityHit)
                    if Config.Debug then
                        print(string.format("[DEBUG] Post-NPC Raycast: Hit=%s, Entity=%s, IsValid=%s, IsVehicle=%s", 
                            tostring(hit), tostring(entityHit), tostring(isEntityHitValid), tostring(IsEntityAVehicle(entityHit))))
                    end
                end
                
                -- Fallback to GetEntityPlayerIsFreeAimingAt if raycast fails
                if not (hit and isEntityHitValid and IsEntityAVehicle(entityHit)) then
                    local success, aimedEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if success and aimedEntity and aimedEntity ~= 0 and DoesEntityExist(aimedEntity) then
                        entityHit = aimedEntity
                        isEntityHitValid = true
                        endCoords = GetEntityCoords(aimedEntity)
                        -- Check if fallback hit a ped driver
                        if GetEntityType(entityHit) == 1 then
                            for vehicle in EnumerateVehicles() do
                                if GetPedInVehicleSeat(vehicle, -1) == entityHit then
                                    vehicleToDelete = vehicle
                                    if NetworkRequestControlOfEntity(entityHit) then
                                        SetEntityAsMissionEntity(entityHit, true, true)
                                        DeleteEntity(entityHit)
                                        Wait(50)
                                        if Config.Debug then
                                            print("[DEBUG] Fallback: NPC driver deleted")
                                        end
                                    end
                                    entityHit = vehicle
                                    isEntityHitValid = DoesEntityExist(entityHit)
                                    break
                                end
                            end
                        end
                        if Config.Debug then
                            print(string.format("[DEBUG] Fallback Aiming: Entity=%s, IsValid=%s, IsVehicle=%s, EntityType=%s", 
                                tostring(entityHit), tostring(isEntityHitValid), tostring(IsEntityAVehicle(entityHit)), 
                                tostring(GetEntityType(entityHit))))
                        end
                    else
                        if Config.Debug then
                            print("[DEBUG] Fallback failed: No valid entity aimed at")
                        end
                        isEntityHitValid = false
                    end
                else
                    if Config.Debug then
                        print("[DEBUG] Raycast found a valid vehicle, skipping fallback")
                    end
                end
                
                if isEntityHitValid then
                    -- Additional entity validation
                    if not isEntityValid(entityHit) then
                        if Config.Debug then
                            print("[DEBUG] Entity is invalid or dead, skipping")
                        end
                        goto continue
                    end
                    
                    local entityType = GetEntityType(entityHit)
                    local isVehicle = IsEntityAVehicle(entityHit)
                    local entityModel = isVehicle and GetEntityModel(entityHit) or "N/A"
                
                    if Config.Debug then
                        print(string.format("[DEBUG] EntityHit: %s, Type=%s, IsVehicle=%s, Model=%s", 
                            tostring(entityHit), tostring(entityType), tostring(isVehicle), tostring(entityModel)))
                    end
                
                    if entityType == 2 and isVehicle then -- 2 = vehicle
                        if Config.Debug then
                            print("[DEBUG] Entity is a vehicle, continuing delete logic")
                        end
                
                        -- Confirm no players inside
                        if not isVehiclePlayerOccupied(entityHit) then
                            if Config.Debug then
                                print("[DEBUG] Vehicle is empty or NPC-controlled, trying to delete")
                            end
                            
                            -- Request network control with retry
                            local attempts = 0
                            while not NetworkHasControlOfEntity(entityHit) and attempts < 3 do
                                NetworkRequestControlOfEntity(entityHit)
                                Wait(100)
                                attempts = attempts + 1
                            end
                            if Config.Debug then
                                print("[DEBUG] Network control attempts: " .. attempts .. ", HasControl=" .. tostring(NetworkHasControlOfEntity(entityHit)))
                            end
                            
                            if NetworkHasControlOfEntity(entityHit) or NetworkGetEntityOwner(entityHit) == PlayerId() then
                                SetEntityAsMissionEntity(entityHit, true, true)
                                DeleteVehicle(entityHit)
                
                                Wait(500) -- Small wait to allow deletion
                                
                                if not DoesEntityExist(entityHit) then
                                    if Config.Debug then
                                        lib.notify({
                                            title = 'Delete Gun',
                                            description = 'Vehicle deleted successfully',
                                            type = 'success',
                                            duration = 3000
                                        })
                                        print("[DEBUG] Vehicle deleted")
                                    end
                                else
                                    if Config.Debug then
                                        lib.notify({
                                            title = 'Delete Gun',
                                            description = 'Failed to delete vehicle',
                                            type = 'error',
                                            duration = 3000
                                        })
                                        print("[DEBUG] Vehicle deletion failed")
                                    end
                                end
                            else
                                if Config.Debug then
                                    lib.notify({
                                        title = 'Delete Gun',
                                        description = 'Cannot get control of vehicle',
                                        type = 'error',
                                        duration = 3000
                                    })
                                    print("[DEBUG] Failed to get control of vehicle")
                                end
                            end
                        else
                            if Config.Debug then
                                lib.notify({
                                    title = 'Delete Gun',
                                    description = 'Cannot delete occupied vehicle',
                                    type = 'error',
                                    duration = 3000
                                })
                                print("[DEBUG] Vehicle is occupied by players")
                            end
                        end
                    else
                        if Config.Debug then
                            lib.notify({
                                title = 'Delete Gun',
                                description = 'This is not a vehicle',
                                type = 'error',
                                duration = 3000
                            })
                            print("[DEBUG] Entity is NOT a vehicle. EntityType=" .. tostring(entityType) .. ", Model=" .. tostring(entityModel))
                        end
                    end
                else
                    if Config.Debug then
                        print("[DEBUG] No valid entity hit")
                    end
                end
                ::continue::
            end
        end
    end
end)
-- Ensure qbx_core is loaded correctly
local QBCore = exports.qbx_core
local isDeleteGunEnabled = false
local deleteGunTimeout = nil

-- Print script version to confirm client script loaded
if Config.Debug then
    print("[DEBUG] tcr_entityremover client.lua loaded, version: 2025-04-23")
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

-- Function to check if vehicle is occupied by other players (exclude the driver if they are the player)
local function isVehiclePlayerOccupied(vehicle, excludePlayerPed)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for seat = -1, maxSeats - 1 do
        local ped = GetPedInVehicleSeat(vehicle, seat)
        if ped ~= 0 and ped ~= excludePlayerPed then
            local isPlayer = IsPedAPlayer(ped)
            if Config.Debug then
                print("[DEBUG] Seat " .. seat .. ": Ped=" .. tostring(ped) .. ", IsPlayer=" .. tostring(isPlayer))
            end
            if isPlayer then
                return true
            end
        end
    end
    return false
end

-- Function to check if vehicle has an NPC driver
local function isVehicleNPCOccupied(vehicle)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if driver ~= 0 and not IsPedAPlayer(driver) then
        if Config.Debug then
            print("[DEBUG] Vehicle has NPC driver: " .. tostring(driver))
        end
        return true
    end
    return false
end

-- Function to safely check if an entity exists and is valid
local function isEntityValid(entity)
    return DoesEntityExist(entity) and not IsEntityDead(entity)
end

-- Function to find a vehicle the player is touching
local function getTouchedVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for vehicle in EnumerateVehicles() do
        if isEntityValid(vehicle) and IsEntityAVehicle(vehicle) then
            local vehicleCoords = GetEntityCoords(vehicle)
            local distance = #(playerCoords - vehicleCoords)
            if distance <= 2.0 then
                if Config.Debug then
                    print("[DEBUG] Touched vehicle found: " .. tostring(vehicle) .. ", Distance=" .. tostring(distance))
                end
                return vehicle
            end
        end
    end
    return nil
end

-- Add client-side chat suggestions
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
        TriggerEvent('chat:addSuggestion', '/dv', 'Delete vehicle (driver seat or touching)')
        if Config.Debug then
            print("[DEBUG] Chat suggestions added for /dgun and /dv")
        end
    end
end)

-- Manual suggestion trigger
RegisterNetEvent('tcr_entityremover:addChatSuggestion', function()
    TriggerEvent('chat:addSuggestion', '/dgun', 'Enable/Disable delete gun')
    TriggerEvent('chat:addSuggestion', '/dv', 'Delete vehicle (driver seat or touching)')
    if Config.Debug then
        print("[DEBUG] Manual chat suggestions triggered for /dgun and /dv")
    end
end)

-- Toggle delete gun
RegisterNetEvent('tcr_entityremover:toggleDeleteGun', function()
    isDeleteGunEnabled = not isDeleteGunEnabled
    
    if deleteGunTimeout then
        ClearTimeout(deleteGunTimeout)
        deleteGunTimeout = nil
    end
    
    if isDeleteGunEnabled then
        lib.notify({
            title = 'Delete Gun',
            description = 'Delete Gun Enabled',
            type = 'success',
            duration = 5000
        })
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
        lib.notify({
            title = 'Delete Gun',
            description = 'Delete Gun Disabled',
            type = 'inform',
            duration = 5000
        })
    end
end)

-- Handle /dv command client-side
RegisterNetEvent('tcr_entityremover:deleteVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        -- Player is in a vehicle
        local seat = -1
        for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
            if GetPedInVehicleSeat(vehicle, i) == playerPed then
                seat = i
                break
            end
        end
        if seat == -1 then
            -- Player is in driver seat
            if Config.Debug then
                print("[DEBUG] Player in driver seat of vehicle: " .. tostring(vehicle))
            end
        else
            -- Player is in passenger seat
            lib.notify({
                title = 'Delete Vehicle',
                description = 'You must be the driver of the vehicle to delete it',
                type = 'error',
                duration = 5000
            })
            if Config.Debug then
                print("[DEBUG] Player in passenger seat: " .. tostring(seat))
            end
            return
        end
    else
        -- Player is not in a vehicle, check for touched vehicle
        vehicle = getTouchedVehicle()
        if not vehicle then
            lib.notify({
                title = 'Delete Vehicle',
                description = 'No vehicle found to delete',
                type = 'error',
                duration = 5000
            })
            if Config.Debug then
                print("[DEBUG] No touched vehicle found")
            end
            return
        end
        if Config.Debug then
            print("[DEBUG] Touched vehicle: " .. tostring(vehicle))
        end
    end
    
    -- Validate vehicle
    if not isEntityValid(vehicle) or not IsEntityAVehicle(vehicle) then
        lib.notify({
            title = 'Delete Vehicle',
            description = 'Invalid vehicle',
            type = 'error',
            duration = 5000
        })
        if Config.Debug then
            print("[DEBUG] Invalid vehicle: " .. tostring(vehicle))
        end
        return
    end
    
    -- Check for NPC occupancy
    if isVehicleNPCOccupied(vehicle) then
        lib.notify({
            title = 'Delete Vehicle',
            description = 'You cannot delete NPC-occupied vehicles',
            type = 'error',
            duration = 5000
        })
        if Config.Debug then
            print("[DEBUG] Vehicle is NPC-occupied")
        end
        return
    end
    
    -- Check for other player occupancy (exclude the player if in driver seat)
    if isVehiclePlayerOccupied(vehicle, playerPed) then
        lib.notify({
            title = 'Delete Vehicle',
            description = 'You cannot delete occupied vehicles',
            type = 'error',
            duration = 5000
        })
        if Config.Debug then
            print("[DEBUG] Vehicle is occupied by other players")
        end
        return
    end
    
    -- Attempt client-side deletion
    local networkId = NetworkGetNetworkIdFromEntity(vehicle)
    if NetworkRequestControlOfEntity(vehicle) then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
        Wait(500)
        if not DoesEntityExist(vehicle) then
            if Config.Debug then
                lib.notify({
                    title = 'Delete Vehicle',
                    description = 'Vehicle deleted',
                    type = 'success',
                    duration = 3000
                })
                print("[DEBUG] Vehicle deleted client-side: " .. tostring(vehicle))
            end
            return
        end
    end
    
    -- Fallback to server-side deletion
    if Config.Debug then
        print("[DEBUG] Client-side deletion failed, requesting server-side deletion: NetID=" .. tostring(networkId))
    end
    TriggerServerEvent('tcr_entityremover:deleteVehicleServer', networkId)
end)

-- Handle shooting logic with raycasting and fallback
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isDeleteGunEnabled then
            local playerPed = PlayerPedId()
            local weaponHash = GetSelectedPedWeapon(playerPed)
            
            if IsPedShooting(playerPed) and isWeaponAllowed(weaponHash) then
                local startPos = GetPedBoneCoords(playerPed, 31086, 0.0, 0.0, 0.0)
                local endPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5000.0, 0.0)
                local rayHandle = StartShapeTestRay(startPos, endPos, 10, playerPed)
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                
                local isEntityHitValid = entityHit and entityHit ~= 0 and DoesEntityExist(entityHit)
                
                if Config.Debug then
                    print(string.format("[DEBUG] Raycast: StartPos=%s, EndPos=%s, Hit=%s, Entity=%s, IsValid=%s, IsVehicle=%s, EndCoords=%s", 
                        tostring(startPos), tostring(endPos), tostring(hit), tostring(entityHit), 
                        tostring(isEntityHitValid), tostring(IsEntityAVehicle(entityHit)), tostring(endCoords)))
                end
                
                local vehicleToDelete = nil
                if isEntityHitValid and GetEntityType(entityHit) == 1 then
                    if Config.Debug then
                        print("[DEBUG] Hit a ped: " .. tostring(entityHit))
                    end
                    for vehicle in EnumerateVehicles() do
                        if GetPedInVehicleSeat(vehicle, -1) == entityHit then
                            vehicleToDelete = vehicle
                            if Config.Debug then
                                print("[DEBUG] Ped is driver of vehicle: " .. tostring(vehicle))
                            end
                            if NetworkRequestControlOfEntity(entityHit) then
                                SetEntityAsMissionEntity(entityHit, true, true)
                                DeleteEntity(entityHit)
                                Wait(50)
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
                
                if vehicleToDelete then
                    rayHandle = StartShapeTestRay(startPos, endPos, 2, playerPed)
                    _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                    isEntityHitValid = entityHit and entityHit ~= 0 and DoesEntityExist(entityHit)
                    if Config.Debug then
                        print(string.format("[DEBUG] Post-NPC Raycast: Hit=%s, Entity=%s, IsValid=%s, IsVehicle=%s", 
                            tostring(hit), tostring(entityHit), tostring(isEntityHitValid), tostring(IsEntityAVehicle(entityHit))))
                    end
                end
                
                if not (hit and isEntityHitValid and IsEntityAVehicle(entityHit)) then
                    local success, aimedEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if success and aimedEntity and aimedEntity ~= 0 and DoesEntityExist(aimedEntity) then
                        entityHit = aimedEntity
                        isEntityHitValid = true
                        endCoords = GetEntityCoords(aimedEntity)
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
                
                    if entityType == 2 and isVehicle then
                        if Config.Debug then
                            print("[DEBUG] Entity is a vehicle, continuing delete logic")
                        end
                
                        if not isVehiclePlayerOccupied(entityHit, playerPed) then
                            if Config.Debug then
                                print("[DEBUG] Vehicle is empty or NPC-controlled, trying to delete")
                            end
                            
                            local networkId = NetworkGetNetworkIdFromEntity(entityHit)
                            if NetworkRequestControlOfEntity(entityHit) then
                                SetEntityAsMissionEntity(entityHit, true, true)
                                DeleteVehicle(entityHit)
                                Wait(500)
                                if not DoesEntityExist(entityHit) then
                                    if Config.Debug then
                                        lib.notify({
                                            title = 'Delete Gun',
                                            description = 'Vehicle deleted successfully',
                                            type = 'success',
                                            duration = 3000
                                        })
                                        print("[DEBUG] Vehicle deleted client-side")
                                    end
                                    goto continue
                                end
                            end
                            if Config.Debug then
                                print("[DEBUG] Client-side deletion failed, requesting server-side deletion: NetID=" .. tostring(networkId))
                            end
                            TriggerServerEvent('tcr_entityremover:deleteVehicleServer', networkId)
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
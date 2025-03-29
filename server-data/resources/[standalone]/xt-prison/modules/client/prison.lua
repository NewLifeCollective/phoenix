local playerState           = LocalPlayer.state
local config                = require 'configs.client'
local prisonBreakcfg        = require 'configs.prisonbreak'
local prisonBreakModules    = require 'modules.client.prisonbreak'
local utils                 = require 'modules.client.utils'
local resources             = require 'bridge.compat.resources'

local inJail = false

local mainBlip
local PrisonZone

local prisonModules = {}

-- Set Jail Time --
function prisonModules.setJailTime(jailTime)
    if playerState.jailTime == jailTime then
        return true
    end

    playerState:set('jailTime', jailTime, true)

    while playerState.jailTime ~= jailTime do
        Wait(1)
    end

    return (playerState.jailTime == jailTime)
end

-- Create Prison Zone for Prison Break Distance Checks --
function prisonModules.createPrisonZone()
    PrisonZone = lib.points.new({
        coords = prisonBreakcfg.Center,
        distance =  prisonBreakcfg.Radius,
    })

    function PrisonZone:onExit()
        if inJail then
            inJail = false
            local alarm = lib.callback.await('xt-prison:server:setPrisonAlarms', false, true)
            if alarm then
                lib.notify({ title = locale('notify.escaped'), type = ' error' })
                TriggerServerEvent('xt-prison:server:triggerBreakout')
                config.Dispatch(prisonBreakcfg.Center)
            end
        end
    end

    if not resources.xt_prisonjobs then
        mainBlip = utils.createBlip('Prison', prisonBreakcfg.Center, 60, 0.7, 3)
    end
end

-- Removes All Prison Zones, Blips, etc --
function prisonModules.prisonCleanup()
    TriggerServerEvent('xt-prison:server:saveJailTime')
    PrisonZone:remove()
    prisonBreakModules.removeBlip()
    prisonBreakModules.removeHackZones()

    if DoesBlipExist(mainBlip) then
        RemoveBlip(mainBlip)
    end
end

-- Sets Player's Coords --
function prisonModules.setPlayerCoords(coords)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z - 0.9, 0, 0, 0, false)
    SetEntityHeading(cache.ped, coords.w)
    local dist = #(vec3(coords.x, coords.y, coords.z - 0.9) - GetEntityCoords(cache.ped))
    return (dist <= 5)
end

-- Entering Prison --
function prisonModules.enterPrison(setTime)
    local setServerJailTime = lib.callback.await('xt-prison:server:setJailStatus', false, setTime)
    if not setServerJailTime then
        return false
    end

    if config.RemoveJob then
        local removed = lib.callback.await('xt-prison:server:removeJob', false)
        if not removed then
            return false
        end
    end

    local setJailTime = prisonModules.setJailTime(setTime)
    if setJailTime then
        TriggerServerEvent('xt-prison:server:removeItems')
        local isLifer = lib.callback.await('xt-prison:server:liferCheck', false)

        DoScreenFadeOut(2000)
        while not IsScreenFadedOut() do Wait(25) end

        local RandomSpawn = config.Spawns[math.random(1, #config.Spawns)]
        lib.waitFor(function()
            if prisonModules.setPlayerCoords(RandomSpawn.coords) then
                FreezeEntityPosition(cache.ped, true)
                while not HasCollisionLoadedAroundEntity(cache.ped) do
                    Wait(0)
                end

                if HasCollisionLoadedAroundEntity(cache.ped) then
                    if config.EnablePrisonOutfits then
                        prisonModules.applyPrisonUniform()
                    end
                    inJail = true
                    return true
                end
            end
        end, 'your pc is dogshit', 10000)

        FreezeEntityPosition(cache.ped, false)

        TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)

        config.Emote(RandomSpawn.emote)

        DoScreenFadeIn(2000)
        while not IsScreenFadedIn() do Wait(25) end

        if config.EnterPrisonAlert.enable and not isLifer then
            CreateThread(function()
                local alertInfo = config.EnterPrisonAlert
                lib.alertDialog({
                    header = alertInfo.header,
                    content = (locale('input.prison_sentence')):format(setTime, alertInfo.content),
                    centered = true,
                    labels = { confirm = 'Close' }
                })
            end)
        elseif config.EnterPrisonAlert.enable and isLifer then
            lib.notify({ title = locale('notify.lifer'), type = 'error' })
        end

        if not isLifer then
            prisonModules.timeReductionLoop()
        end

        if resources.xt_prisonjobs then
            exports['xt-prisonjobs']:InitPrisonJob()
        end

        return true
    end

    return false
end

-- Exiting Prison (Automatically when Jail Time Hits 0) --
function prisonModules.exitPrison(isUnjailed)
    if playerState.jailTime <= 0 or isUnjailed then
        local setJailTime = prisonModules.setJailTime(0)
        if setJailTime then
            inJail = false

            DoScreenFadeOut(2000)
            while not IsScreenFadedOut() do Wait(25) end

            if config.EnablePrisonOutfits then
                config.ResetClothing()
            end

            prisonModules.setPlayerCoords(config.Freedom)  -- Teleports player automatically when time is up

            Wait(500)
            DoScreenFadeIn(2000)
            while not IsScreenFadedIn() do Wait(25) end

            TriggerServerEvent('xt-prison:server:returnItems')

            if resources.xt_prisonjobs then
                exports['xt-prisonjobs']:CleanupPrisonJob()
            end

            return true
        end
    end

    return false
end

-- Reduce Jail Time Loop --
function prisonModules.timeReductionLoop()
    CreateThread(function()
        while inJail do
            if playerState.jailTime > 0 then
                local newTime = (playerState.jailTime - 1)
                prisonModules.setJailTime(newTime)
            elseif playerState.jailTime <= 0 then
                lib.notify({
                    title = locale('notify.checkout'),
                    icon = 'fas fa-unlock',
                    type = 'success'
                })
                prisonModules.exitPrison(true)  -- Automatically release player when time runs out
                break
            end
            Wait(60000)
        end
    end)
end

function prisonModules.applyPrisonUniform()
    local outifitInfo = IsPedModel(cache.ped, 'mp_m_freemode_01') and config.PrisonOufits.male or config.PrisonOufits.female
    SetPedComponentVariation(cache.ped, 1, outifitInfo.mask.item, outifitInfo.mask.texture)                 -- Mask
    SetPedComponentVariation(cache.ped, 3, outifitInfo.arms.item, outifitInfo.arms.texture)                 -- Arms
    SetPedComponentVariation(cache.ped, 4, outifitInfo.pants.item, outifitInfo.pants.texture)               -- Pants
    SetPedComponentVariation(cache.ped, 6, outifitInfo.shoes.item, outifitInfo.shoes.texture)               -- Shoes
    SetPedComponentVariation(cache.ped, 7, outifitInfo.accessories.item, outifitInfo.accessories.texture)   -- Accessory
    SetPedComponentVariation(cache.ped, 8, outifitInfo.shirt.item, outifitInfo.shirt.texture)               -- Shirt
    SetPedComponentVariation(cache.ped, 11, outifitInfo.jacket.item, outifitInfo.jacket.texture)            -- Jacket
end

return prisonModules

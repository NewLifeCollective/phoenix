local announcement = nil
local announcementLines = {}
local displayTime = Config.Announcement.DisplayTime
local timer = 0
local header = Config.Announcement.Header
local placement = Config.Announcement.Placement
local peacetime = true -- match default server value
local currentAOP = Config.AOP.Default
local priorityStatus = Config.Priority.DefaultStatus
local priorityTimeRemaining = Config.Priority.CooldownMinutes * 60
local isAdmin = false

print("✅ TCR Utility client started")

function Draw2DText(x, y, text, scale, center)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    if center then SetTextJustification(0) end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

RegisterNetEvent('tcr_utility:Announce')
AddEventHandler('tcr_utility:Announce', function(msg)
    announcement = msg
    timer = 0
    announcementLines = {}

    if #msg > 70 then
        local line = ""
        for word in msg:gmatch("%S+") do
            if #line + #word + 1 >= 70 then
                table.insert(announcementLines, line)
                line = word .. " "
            else
                line = line .. word .. " "
            end
        end
        if line ~= "" then table.insert(announcementLines, line) end
    else
        table.insert(announcementLines, msg)
    end
end)

TriggerServerEvent('tcr_utility:CheckAdminStatus')
RegisterNetEvent('tcr_utility:SetPeacetime')
AddEventHandler('tcr_utility:SetPeacetime', function(state)
    peacetime = state
end)

RegisterNetEvent('tcr_utility:SetAOP')
AddEventHandler('tcr_utility:SetAOP', function(aop)
    currentAOP = aop
end)

RegisterNetEvent('tcr_utility:SetPriority')
AddEventHandler('tcr_utility:SetPriority', function(status, remaining)
    priorityStatus = status
    priorityTimeRemaining = remaining or 0
end)

RegisterNetEvent('tcr_utility:SetAdminStatus')
AddEventHandler('tcr_utility:SetAdminStatus', function(status)
    isAdmin = status
end)

CreateThread(function()
    while true do
        Wait(1000)
        if announcement then
            timer = timer + 1
            if timer >= displayTime then
                announcement = nil
                timer = 0
            end
        end

        if priorityStatus == "Cooldown" and priorityTimeRemaining > 0 then
            priorityTimeRemaining = priorityTimeRemaining - 1
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        -- HUD: AOP
        Draw2DText(0.02, 0.69, string.format("~w~AOP: ~y~%s", currentAOP), 0.55, false)

        -- HUD: Peacetime
        local ptStatus = peacetime and "~g~Enabled" or "~r~Disabled"
        Draw2DText(0.02, 0.72, string.format("~w~Peacetime: %s", ptStatus), 0.55, false)

        -- HUD: Priority
        local prioColor = "~w~"
        local statusLower = priorityStatus:lower()
        if statusLower == "active" then prioColor = "~r~"
        elseif statusLower == "cooldown" then prioColor = "~y~"
        elseif statusLower == "available" then prioColor = "~g~"
        elseif statusLower == "unavailable" then prioColor = "~o~" end

        local prioText = string.format("~w~Priority: %s%s", prioColor, priorityStatus)
        if priorityStatus == "Cooldown" and priorityTimeRemaining > 0 then
            local minutes = math.floor(priorityTimeRemaining / 60)
            local seconds = priorityTimeRemaining % 60
            prioText = string.format("~w~Priority: %s%s (%02d:%02d)", prioColor, priorityStatus, minutes, seconds)
        end
        Draw2DText(0.02, 0.66, prioText, 0.55, false)

        -- Announcement Overlay
        if announcement then
            local y = placement + 0.1
            Draw2DText(0.5, placement, header, 1.5, true)
            for _, line in ipairs(announcementLines) do
                Draw2DText(0.5, y, line, 0.8, true)
                y = y + 0.05
            end
        end

        -- Peacetime Restrictions
        if peacetime and not isAdmin then
            if IsControlPressed(0, 106) then
                SetNotificationTextEntry("STRING")
                AddTextComponentString("~r~Peacetime is enabled. You cannot shoot.")
                DrawNotification(true, false)
            end
            SetPlayerCanDoDriveBy(PlayerId(), false)
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 140, true)
        end
    end
end)

exports('GetPeaceTimeStatus', function()
    return peacetime
end)

exports('GetAOP', function()
    return currentAOP
end)

exports('GetPriorityStatus', function()
    return priorityStatus
end)

exports('GetPriorityTimeRemaining', function()
    return priorityTimeRemaining
end)

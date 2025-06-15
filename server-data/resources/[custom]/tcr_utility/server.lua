local peacetime = true 
local currentAOP = Config.AOP.Default
local priorityStatus = Config.Priority.DefaultStatus
local cooldownTimer = nil

local function sendMsg(src, msg)
    TriggerClientEvent('chat:addMessage', src, {
        args = {"^5[^3TCR^5] ^7" .. msg}
    })
end

RegisterNetEvent('tcr_utility:CheckAdminStatus', function()
    local src = source
    local isAdmin = IsPlayerAceAllowed(src, "tcr_utility.Admin")
    TriggerClientEvent('tcr_utility:SetAdminStatus', src, isAdmin)
end)
local function updateAllClients()
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent('tcr_utility:SetPeacetime', playerId, peacetime)
        TriggerClientEvent('tcr_utility:SetAOP', playerId, currentAOP)
        TriggerClientEvent('tcr_utility:SetPriority', playerId, priorityStatus, Config.Priority.CooldownMinutes * 60)
        TriggerClientEvent('tcr_utility:CheckAdminStatus', src)


        local isAdmin = IsPlayerAceAllowed(playerId, "tcr_utility.Admin")
        TriggerClientEvent('tcr_utility:SetAdminStatus', playerId, isAdmin)
    end
end

RegisterCommand(Config.Announcement.Command, function(source, args)
    if IsPlayerAceAllowed(source, Config.Announcement.AcePermission) then
        if #args > 0 then
            local msg = table.concat(args, " ")
            TriggerClientEvent("tcr_utility:Announce", -1, msg)
        else
            sendMsg(source, "^1ERROR: Usage: /" .. Config.Announcement.Command .. " <message>")
        end
    else
        sendMsg(source, "^1ERROR: You do not have permission to use this command.")
    end
end)

RegisterCommand(Config.AOP.Command, function(source, args)
    if IsPlayerAceAllowed(source, Config.AOP.AcePermission) then
        if #args > 0 then
            currentAOP = table.concat(args, " ")
            TriggerClientEvent("tcr_utility:SetAOP", -1, currentAOP)
            sendMsg(-1, "The AOP has been set to ^3" .. currentAOP .. "^7.")
            TriggerClientEvent("ox_lib:notify", -1, {
                title = "Area of Patrol Updated",
                description = "Please move to the new AOP or you may be kicked.",
                type = "warning",
                duration = 10000
            })
        else
            sendMsg(source, "^1ERROR: Usage: /" .. Config.AOP.Command .. " <zone>")
        end
    else
        sendMsg(source, "^1ERROR: You do not have permission to use this command.")
    end
end)

RegisterCommand(Config.Peacetime.Command, function(source)
    if IsPlayerAceAllowed(source, Config.Peacetime.AcePermission) then
        peacetime = not peacetime
        TriggerClientEvent("tcr_utility:SetPeacetime", -1, peacetime)
        if peacetime then
            sendMsg(-1, "Peacetime is now ^2ENABLED^7.")
        else
            sendMsg(-1, "Peacetime is now ^1DISABLED^7.")
        end
    else
        sendMsg(source, "^1ERROR: You do not have permission to toggle peacetime.")
    end
end)

RegisterCommand(Config.Priority.Command, function(source, args)
    if not IsPlayerAceAllowed(source, Config.Priority.AcePermission) then
        return sendMsg(source, "^1ERROR: You do not have permission to change priority status.")
    end

    local statusArg = args[1] and args[1]:lower()
    if not statusArg then
        return sendMsg(source, "^1ERROR: Usage: /" .. Config.Priority.Command .. " <active|cooldown|available|unavailable>")
    end

    if statusArg == "active" or statusArg == "ac" then
        priorityStatus = "Active"
        cooldownTimer = nil
        TriggerClientEvent("tcr_utility:SetPriority", -1, priorityStatus)
        sendMsg(-1, "^1PRIORITY ACTIVE^7 - You must wait until it ends.")

    elseif statusArg == "cooldown" or statusArg == "cd" then
        priorityStatus = "Cooldown"
        local seconds = Config.Priority.CooldownMinutes * 60
        TriggerClientEvent("tcr_utility:SetPriority", -1, priorityStatus, seconds)
        sendMsg(-1, "^3Priority Cooldown started for " .. Config.Priority.CooldownMinutes .. " minutes.")

        if cooldownTimer then
            StopResourceTimer(cooldownTimer)
        end
        cooldownTimer = CreateThread(function()
            Wait(seconds * 1000)
            priorityStatus = "Available"
            TriggerClientEvent("tcr_utility:SetPriority", -1, priorityStatus)
            sendMsg(-1, "^2Priority Cooldown ended. Priority is now Available.")
        end)

    elseif statusArg == "available" or statusArg == "av" or statusArg == "avail" then
        priorityStatus = "Available"
        cooldownTimer = nil
        TriggerClientEvent("tcr_utility:SetPriority", -1, priorityStatus)
        sendMsg(-1, "^2Priority is now AVAILABLE.")

    elseif statusArg == "unavailable" or statusArg == "un" then
        priorityStatus = "Unavailable"
        cooldownTimer = nil
        TriggerClientEvent("tcr_utility:SetPriority", -1, priorityStatus)
        sendMsg(-1, "^8Priority is now UNAVAILABLE.^7")

    else
        sendMsg(source, "^1ERROR: Invalid priority status. Use active, cooldown, available, or unavailable.")
    end
end)

AddEventHandler("playerJoining", function(playerId)
    TriggerClientEvent("tcr_utility:SetPeacetime", playerId, peacetime)
    TriggerClientEvent("tcr_utility:SetAOP", playerId, currentAOP)
    TriggerClientEvent("tcr_utility:SetPriority", playerId, priorityStatus, Config.Priority.CooldownMinutes * 60)

    local isAdmin = IsPlayerAceAllowed(playerId, "tcr_utility.Admin")
    TriggerClientEvent("tcr_utility:SetAdminStatus", playerId, isAdmin)
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

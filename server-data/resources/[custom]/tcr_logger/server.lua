-- See LICENSE
-- Copyright (C) 2025 TheClassyR3dneck


local webhookUrl = GetConvar('chat_log_webhook', '')
local adminhookUrl = GetConvar('admin_log_webhook', '')

local QBCore = exports['qb-core']:GetCoreObject()


-- Chat Log function
function SendToDiscord(message)
    if webhookUrl == '' then
        print('Error: Invalid chat_log_webhook set in env.cfg')
        return
    end
    local payload = {
        content = message,
        username = 'Phoenix Chat',
        avatar_url = 'https://media.discordapp.net/attachments/1347447044318695465/1347699231669878804/NLC_Logo_1.png?ex=67fd8db7&is=67fc3c37&hm=14bc3baf5ca48b1657eb45cd155f5f4cc8d3c8f7f7f22a7e2b3500f602002794&=&format=webp&quality=lossless&width=960&height=960'
    }
    PerformHttpRequest(webhookUrl, function(err, text, headers)
        if err ~= 200 and err ~= 204 then
            print('Error sending to chat log Discord: ' .. err .. ', Response: ' .. tostring(text))
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

-- Admin logs function
function SendToAdmin(playerName, discordId, ipAddress, fullName, phoneNumber, bankBalance, cash, jobName, jobTitle, jobGrade, citizenId, gangName, gangGrade)
    if adminhookUrl == '' then
        print('Error: Invalid admin_log_webhook set in env.cfg')
        return
    end
   -- print('SendToAdmin parameters: playerName=' .. tostring(playerName) .. ', discordId=' .. tostring(discordId) .. ', ipAddress=' .. tostring(ipAddress))
    

   local payload = {
    username = 'Phoenix Logs',
    avatar_url = 'https://media.discordapp.net/attachments/1347447044318695465/1347699231669878804/NLC_Logo_1.png?ex=67fd8db7&is=67fc3c37&hm=14bc3baf5ca48b1657eb45cd155f5f4cc8d3c8f7f7f22a7e2b3500f602002794&=&format=webp&quality=lossless&width=960&height=960',
    embeds = {{
        title = 'Character Spawned',
        color = 0x00FF00,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        fields = {
            { name = '**Player Info**', value = '', inline = false }, 
            { name = 'Player Name', value = playerName or 'Unknown', inline = true },
            { name = 'Discord ID', value = discordId or 'Unknown', inline = true },
            { name = 'IP Address', value = ipAddress or 'Unknown', inline = true },
            { name = '', value = '─────────────────────────────────────────────', inline = false },
            
            { name = '**Character Info**', value = '', inline = false }, 
            { name = 'Character Name', value = fullName or 'Unknown', inline = true },
            { name = 'Citizen ID', value = citizenId or 'Unknown', inline = true },
            { name = 'Phone Number', value = phoneNumber or 'Unknown', inline = true },
            { name = '', value = '─────────────────────────────────────────────', inline = false },
            
            { name = '**Financial Info**', value = '', inline = false }, 
            { name = 'Bank Balance', value = bankBalance or 'Unknown', inline = true },
            { name = 'Cash', value = cash or 'Unknown', inline = true },
            { name = '', value = '─────────────────────────────────────────────', inline = false },
            
            { name = '**Job Info**', value = '', inline = false },
            { name = 'Job Name', value = jobName or 'Unknown', inline = true },
            { name = 'Job Title', value = jobTitle or 'Unknown', inline = true },
            { name = 'Job Grade', value = jobGrade or 'Unknown', inline = true },
            { name = '', value = '─────────────────────────────────────────────', inline = false },
            
            { name = '**Gang Info**', value = '', inline = false }, 
            { name = 'Affiliated Gang', value = gangName or 'None', inline = true },
            { name = 'Gang Level', value = gangGrade or 'Unknown', inline = true },
            { name = '', value = '─────────────────────────────────────────────', inline = false }
        }
    }}
}
   -- print('Sending to admin webhook: ' .. json.encode(payload))
    PerformHttpRequest(adminhookUrl, function(err, text, headers)
        if err ~= 200 and err ~= 204 then
            print('Error sending to admin log Discord: ' .. err .. ', Response: ' .. tostring(text))
        else
          -- print('Admin webhook sent successfully')
           
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

function GetDiscordFromIdentifiers(src)
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local identifier = GetPlayerIdentifier(src, i)
        if string.find(identifier, "discord:") then
            return string.sub(identifier, 9) 
        end
    end
    return nil
end

-- Player clicks Connect to server
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local playerName = GetPlayerName(src) or 'Unknown'
    local discordId = GetDiscordFromIdentifiers(src) or 'Unknown'
    local ipAddress = GetPlayerEndpoint(src) or 'Unknown'
    local joinMessage = string.format('[%s] **%s** has joined the server', discordId, playerName)
    SendToDiscord(joinMessage)
end)

-- Player Load after Character Selection
RegisterNetEvent('QBCore:Server:PlayerLoaded', function(player)
    local src = player.PlayerData.source
    if not src then
        print('[tcr_logger] Error: Source not found in player data')
        return
    end

    local playerName = GetPlayerName(src) or 'Unknown'
    local discordId = GetDiscordFromIdentifiers(src) or 'Unknown'
    local ipAddress = GetPlayerEndpoint(src) or 'Unknown'
    local charinfo = player.PlayerData.charinfo
    local fullName = (charinfo.firstname or '') .. ' ' .. (charinfo.lastname or '')
    local phoneNumber = player.PlayerData.charinfo.phone
    local bankBalance = player.PlayerData.money.bank or 0
    local cash = player.PlayerData.money.cash or 0
    local jobName = player.PlayerData.job.name or 'Unknown'
    local jobTitle = player.PlayerData.job.type or 'Unk'
    local jobGrade = player.PlayerData.job.grade.name or 'Unknown'
    local citizenId = player.PlayerData.citizenid or 'Unknown'
    local gangName = player.PlayerData.gang.name or 'Unknown'
    local gangGrade = player.PlayerData.gang.grade.name or 'Unknown'

   --print('PlayerLoaded: src=' .. src .. ', playerName=' .. tostring(playerName) .. ', discordId=' .. tostring(discordId) .. ', ipAddress=' .. tostring(ipAddress) .. ', bankBalance=' .. tostring(bankBalance))
    SendToAdmin(playerName, discordId, ipAddress, fullName, phoneNumber, bankBalance, cash, jobName, jobTitle, jobGrade, citizenId, gangName, gangGrade)
end)

-- Player Disconnect
AddEventHandler('playerDropped', function(reason)
    local src = source
    local playerName = GetPlayerName(src)
    local discordId = GetDiscordFromIdentifiers(src) or 'Unknown'

    local leaveMessage = string.format('[%s] **%s** has left the server', discordId, playerName)
    SendToDiscord(leaveMessage)
end)

-- Player death (enhanced)
AddEventHandler('baseevents:onPlayerDied', function(killerId, deathData)
    local victimSrc = source
    local victimName = GetPlayerName(victimSrc) or 'Unknown'
    local victimDiscord = GetDiscordFromIdentifiers(victimSrc) or 'Unknown'

    local deathMessage = ''

    if killerId and killerId ~= victimSrc then
        local killerName = GetPlayerName(killerId) or 'Unknown'
        local killerDiscord = GetDiscordFromIdentifiers(killerId) or 'Unknown'
        local weaponHash = deathData and deathData.weapon or 0
        local weaponHex = string.format("0x%X", weaponHash)

        deathMessage = string.format(
            '[%s] **%s** was killed by [%s] **%s** using weapon hash: `%s`',
            victimDiscord, victimName, killerDiscord, killerName, weaponHex
        )
    else
        local weaponHash = deathData and deathData.weapon or 0
        local weaponHex = string.format("0x%X", weaponHash)

        deathMessage = string.format(
            '[%s] **%s** died (Weapon: `%s`)',
            victimDiscord, victimName, weaponHex
        )
    end

    SendToDiscord(deathMessage)
end)


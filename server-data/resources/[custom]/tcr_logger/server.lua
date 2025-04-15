local webhookUrl = GetConvar('chat_log_webhook', '')

RegisterCommand('testbadger', function(source)
    local discordId = GetDiscordFromIdentifiers(source)
    print('Player: ' .. GetPlayerName(source) .. ', Discord ID: ' .. (discordId or 'Unknown'))
end, false)

function SendToDiscord(message)
    if webhookUrl == "" then
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
            print('Error sending to Discord: ' .. err .. ', Response: ' .. tostring(text))
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('chatMessage', function(source, name, message)
    local playerName = GetPlayerName(source)
    local discordId = GetDiscordFromIdentifiers(source) or 'Unknown'

    local formattedMessage = string.format('[%s] **%s**: %s', discordId, playerName, message)
    SendToDiscord(formattedMessage)
end)

function GetDiscordFromIdentifiers(src)
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local identifier = GetPlayerIdentifier(src, i)
        if string.find(identifier, "discord:") then
            return string.sub(identifier, 9) 
        end
    end
    return nil
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local playerName = GetPlayerName(src)
    local discordId = GetDiscordFromIdentifiers(src) or 'Unknown'

    local joinMessage = string.format('[%s] **%s** has joined the server', discordId, playerName)
    SendToDiscord(joinMessage)
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local playerName = GetPlayerName(src)
    local discordId = GetDiscordFromIdentifiers(src) or 'Unknown'

    local leaveMessage = string.format('[%s] **%s** has left the server', discordId, playerName)
    SendToDiscord(leaveMessage)
end)

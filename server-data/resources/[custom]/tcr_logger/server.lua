local webhookUrl = GetConvar('chat_log_webhook', '')

RegisterCommand('testbadger', function(source)
    local nickname = exports.Badger_Discord_API:GetDiscordNickname(source) or 'Unknown'
    print('Player: ' .. GetPlayerName(source) .. ', Discord Nickname: ' .. nickname)
end, false)

function SendToDiscord(message)
    local payload = {
        content = message,
        username = 'Phoenix Chat',
        avatar_url = 'https://media.discordapp.net/attachments/1347447044318695465/1347699231669878804/NLC_Logo_1.png?ex=67fd8db7&is=67fc3c37&hm=14bc3baf5ca48b1657eb45cd155f5f4cc8d3c8f7f7f22a7e2b3500f602002794&=&format=webp&quality=lossless&width=960&height=960'
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers)
        if err == 200 or err == 204 then
        --    print('Message sent to Discord: ' .. message)
        else
            print('Error sending to Discord: ' .. err .. ', Response: ' .. tostring(text))
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('chatMessage')
AddEventHandler('chatMessage', function(source, name, message)
    local playerName = GetPlayerName(source)
    local discordName = 'Unknown'
    if exports.Badger_Discord_API and exports.Badger_Discord_API.GetDiscordNickname then
        local nickname = exports.Badger_Discord_API:GetDiscordNickname(source)
        if nickname then
            discordName = nickname
        end
    end
    
    local formattedMessage = string.format('[%s] **%s**: %s', discordName, playerName, message)

    SendToDiscord(formattedMessage)
    --print('Chat relayed to Discord: ' .. formattedMessage)
end)
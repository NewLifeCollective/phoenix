local miranda_toggled = false

RegisterCommand('miranda', function(source, args, raw)
    SendNuiMessage(json.encode({
        ["e"] = "toggle"
    }))

    miranda_toggled = not miranda_toggled

    SetNuiFocus(miranda, miranda_toggled)
end, false)
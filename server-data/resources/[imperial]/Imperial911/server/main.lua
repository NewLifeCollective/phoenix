RegisterNetEvent("Imperial:911Blip")
AddEventHandler("Imperial:911Blip", function(coords)
    local OnDutyUnitsFound = exports['ImperialDuty']:GetOnDutyUnits()
    for _, playerId in ipairs(OnDutyUnitsFound) do
        TriggerClientEvent("Imperial:911BlipForOnduty", playerId, coords)
    end
end)


RegisterNetEvent("Imperial:CallChatMessage")
AddEventHandler("Imperial:CallChatMessage", function(name, street, message, crossStreet, postal)
    local onDutyUnits = exports["ImperialDuty"]:GetOnDutyUnits()
    local chatMessage = {
        multiline = true,
        args = {"^8(Imperial911 - New Call For Service)", 
            "\nName: ^3" .. name .. "^7\nPostal: ^3" .. postal .. "^7\nStreet: ^3" .. street .. 
            "^7\nCross Street: ^3" .. crossStreet .. "^7\nInformation: ^3" .. message
        }
    }
    
    for _, playerId in ipairs(onDutyUnits) do
        TriggerClientEvent("chat:addMessage", playerId, chatMessage)
    end
end)

RegisterNetEvent("Imperial:Send911ToCad")
AddEventHandler("Imperial:Send911ToCad", function(data)
    local src = source

    local headers = {
        ["Content-Type"] = "application/json",
        ["APIKEY"] = GetConvar("imperialAPI", "")
    }

    local commId = GetConvar("imperial_community_id", "") 

    if not commId or commId == "" then
        TriggerClientEvent("notify", src, "Community ID is not set. Cannot send 911 call.")
        return
    end

    if not headers["APIKEY"] or headers["APIKEY"] == "" then
        TriggerClientEvent("notify", src, "API Key is not set. Cannot send 911 call.")
        return
    end

    data.commId = commId

    local url = "https://imperialcad.app/api/1.1/wf/911"

   
    PerformHttpRequest(url, function(statusCode, responseText, headers)
        if statusCode == 200 then
            print("911 Call Success")
            TriggerClientEvent("notify", src, "911 call successfully sent to CAD.")
        else
            print("Failed to send 911 call. Status Code: " .. statusCode)
            print("Error Response: " .. responseText)
            TriggerClientEvent("notify", src, "Failed to send 911 call. Status Code: " .. statusCode)
        end
    end, "POST", json.encode(data), headers)
end)


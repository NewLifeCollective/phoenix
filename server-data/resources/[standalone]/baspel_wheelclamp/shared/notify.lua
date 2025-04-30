notify = {}
local messageType = {
    succes = 'success',
    error = 'error',
    info = 'info',
    warn = 'warning'
}

if Config.Notify == Notify.ESX then
    notify.send = function(source, msg, type, time)
        if source ~= nil then
            if type == nil then
                type = messageType.info
            end
            if time == nil then
                time = 5000
            end
            TriggerClientEvent('esx:showNotification', source, msg, type, time)
        else
            ESX.ShowNotification(msg)
        end
    end
elseif Config.Notify == Notify.QBCore then
    notify.send = function(source, msg, type, time)
        if source ~= nil then
            if type == nil then
                type = messageType.info
            end
            if time == nil then
                time = 5000
            end
            TriggerClientEvent('QBCore:Notify', source, msg, type, time)
        else
            QBCore.Functions.Notify(mag, type, time)
        end
    end
elseif Config.Notify == Notify.Other then
    -- Your code here...
end
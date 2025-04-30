if Config.Framework == Framework.ESX then
    ESX = nil

    pcall(function() ESX = exports[Config.FrameworkExport].getSharedObject() end)
    if ESX == nil then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    getJob = function(src)
        logging.debug('Checked if player has job')
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.job.name
        end
    end

    getItem = function(src)
        logging.debug('Checked if player has item')
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            local item = xPlayer.getInventoryItem(Config.ItemName)
            return item.count > 0
        end
        return false
    end
    
    removeItem = function(src)
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.removeInventoryItem(Config.ItemName, 1)
        end
    end
    
    addItem = function(src)
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.addInventoryItem(Config.ItemName, 1)
        end
    end
end
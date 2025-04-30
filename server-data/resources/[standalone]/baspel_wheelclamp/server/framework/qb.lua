if Config.Framework == Framework.QBCore then
    QBCore = nil

    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkExport]:GetCoreObject()
    end

    
    getJob = function(src)
        logging.debug('Checked if player has job')
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.job.name
        end
    end

    getItem = function(src)
        logging.debug('Checked if player has item')
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            local item = Player.Functions.GetItemByName(Config.ItemName)
            if item then
                return item.amount > 0
            end
        end
        return false
    end
    
    removeItem = function(src)
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.RemoveItem(Config.ItemName, 1)
        end
    end
    
    addItem = function(src)
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.AddItem(Config.ItemName, 1)
        end
    end
end
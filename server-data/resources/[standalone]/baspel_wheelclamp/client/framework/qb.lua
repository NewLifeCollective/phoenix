if Config.Framework == Framework.QBCore then
    QBCore, JobData = nil, {}

    CreateThread(function()
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            if QBCore == nil then
                QBCore = exports[Config.FrameworkExport]:GetCoreObject()
            end
            Wait(100)
        end
    end)

    getJob = function()
        while JobData.name == nil do Wait(0) end
        return JobData.name
    end
    
    getGrade = function()
        while JobData.grade == nil do Wait(0) end
        return JobData.grade
    end
end
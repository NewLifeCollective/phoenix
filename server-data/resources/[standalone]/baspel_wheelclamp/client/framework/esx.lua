if Config.Framework == Framework.ESX then
    ESX, JobData = nil, {}

    CreateThread(function()
        while ESX == nil do
            pcall(function() ESX = exports[Config.FrameworkExport]:getSharedObject() end)
            if ESX == nil then
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            end
            Wait(100)
        end
        JobData = ESX.PlayerData.job or {}

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(xPlayer)
            JobData = xPlayer.job or {}
        end)

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function(job)
            --local lastJob = getJob()
            JobData = job or {}
        end)
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
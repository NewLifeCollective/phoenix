ClampedVehs = {}

CreateThread(function()
    Wait(5000)
    if Config.SaveIntoDatabase then
        if setupDatabase() then
            logging.debug('Database loaded')
        else
            logging.error('Database failed to load')
        end
        Wait(5000)
        checkIfVinExists()
        ClampedVehs = getClampedVehs()

        logging.info('Loaded ' .. #ClampedVehs .. ' clamped vehicles')
    end
end)
RegisterServerEvent('tcr_staff:checkPermission')
AddEventHandler('tcr_staff:checkPermission', function()
    local source = source
    local hasPermission = IsPlayerAceAllowed(source, 'playerblips.use')
    TriggerClientEvent('tcr_staff:receivePermission', source, hasPermission)
end)
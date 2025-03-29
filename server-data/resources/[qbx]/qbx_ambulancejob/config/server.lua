return {
    doctorCallCooldown = 1, -- Time in minutes for cooldown between doctors calls
    wipeInvOnRespawn = false, -- Enable to disable removing all items from player on respawn
    depositSociety = function(society, amount)
        exports['nfs-billing']:depositSociety(('society_%s'):format(society), amount)
    end
}
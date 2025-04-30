if Config.Target == Target.QB then
    boneId = nil

    if not Config.AllowedJobs then
        exports[Config.QBTargetExport]:AddTargetBone('wheel_lf', {
            options = {
                {
                    icon = Config.TargetIcon,
                    label = Config.Language['targetLabel'],
                    canInteract = function(entity, distance, data)
                        boneId = GetEntityBoneIndexByName(entity, 'wheel_lf')
                        return boneId ~= -1
                    end,
                    action = function(entity)
                        local netId = NetworkGetNetworkIdFromEntity(entity)
                        TriggerServerEvent(triggerName('checkClamp'), netId)
                    end
                }
            },
            distance = 1
        })
    else
        exports[Config.QBTargetExport]:AddTargetBone('wheel_lf', {
            options = {
                {
                    icon = Config.TargetIcon,
                    label = Config.Language['targetLabel'],
                    job = Config.AllowedJobs,
                    canInteract = function(entity, distance, data)
                        boneId = GetEntityBoneIndexByName(entity, 'wheel_lf')
                        return boneId ~= -1
                    end,
                    action = function(entity)
                        local netId = NetworkGetNetworkIdFromEntity(entity)
                        TriggerServerEvent(triggerName('checkClamp'), netId)
                    end
                }
            },
            distance = 1
        })
    end
end
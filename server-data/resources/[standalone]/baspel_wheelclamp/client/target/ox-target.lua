if Config.Target == Target.OX then
    local ox_target = exports.ox_target
    boneId = nil

    if not Config.AllowedJobs then
        ox_target:addGlobalVehicle({
            {
                icon = Config.TargetIcon,
                label = Config.Language['targetLabel'],
                bones = {'wheel_lf'},
                canInteract = function(entity, distance, coords, name)
                    boneId = GetEntityBoneIndexByName(entity, 'wheel_lf')
                    if boneId ~= -1 then
                        return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.5 or #(coords - GetEntityBonePosition_2(entity, GetEntityBoneIndexByName(entity, 'wheel_lf'))) < 0.72
                    end
                end,
                onSelect = function(data)
                    local netId = NetworkGetNetworkIdFromEntity(data.entity)
                    TriggerServerEvent(triggerName('checkClamp'), netId)
                end
            }
        })
    else
        ox_target:addGlobalVehicle({
            {
                icon = Config.TargetIcon,
                label = Config.Language['targetLabel'],
                bones = {'wheel_lf'},
                groups = Config.AllowedJobs,
                canInteract = function(entity, distance, coords, name)
                    boneId = GetEntityBoneIndexByName(entity, 'wheel_lf')
                    if boneId ~= -1 then
                        return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.5 or #(coords - GetEntityBonePosition_2(entity, GetEntityBoneIndexByName(entity, 'wheel_lf'))) < 0.72
                    end
                end,
                onSelect = function(data)
                    local netId = NetworkGetNetworkIdFromEntity(data.entity)
                    TriggerServerEvent(triggerName('checkClamp'), netId)
                end
            }
        })
    end
end
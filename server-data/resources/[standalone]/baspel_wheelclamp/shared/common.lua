--- @param event string
function triggerName(event)
    return string.format('mining:%s', event)
end
logging = {}
local messageType = {
    debug = 'DEBUG',
    error = 'ERROR',
    info = 'INFO',
    warn = 'WARN',
}

logging.debug = function(msg)
    if Config.Debug then
        print('^2| ' .. messageType.debug .. ' |^0 ' .. msg)
    end
end

logging.error = function(msg)
    print('^8| ' .. messageType.error .. ' |^0 ' .. msg)
end

logging.warn = function(msg)
    print('^3| ' .. messageType.warn .. ' |^0 ' .. msg)
end

logging.info = function(msg)
    print('^5| ' .. messageType.info .. ' |^0 ' .. msg)
end


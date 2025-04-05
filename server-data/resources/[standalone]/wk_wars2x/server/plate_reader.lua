---@class RateLimit
---@field [number] boolean

---@class PlateCache
---@field expires number When the cache entry expires (game timer value)
---@field info PlateInfo The cached plate information

---@type RateLimit
local rateLimits = {}

---@type table<string, PlateCache>
local platesCache = {}

---@type string
local commId = GetConvar("imperial_community_id", "")

---@type string
local apiKey = GetConvar("imperialAPI", "")

---@type table<string, string>
local headers = {
    ["Content-Type"] = "application/json",
    ["APIKEY"] = apiKey
}

local GetGameTimer = GetGameTimer

---@type string
local url = "https://imperialcad.app/api/1.1/wf/checkplate"

assert(commId ~= "", "imperial_community_id is not set as a valid convar")
assert(apiKey ~= "", "imperialAPI is not set as a valid convar")

local CACHE_DURATION_MS = 600000        -- 10 minutes
local RATE_LIMIT_MS = 3000              -- 3 seconds
local CLEANUP_GRACE_PERIOD_MS = 900000  -- 15 minutes
local CACHE_CLEANUP_INTERVAL_MS = 60000 -- 1 minute

---Validates if a plate string meets requirements
---@param plate string The plate to validate
---@return boolean valid Whether the plate is valid
local function validatePlate(plate)
    return string.len(plate) <= 8 and type(plate) == "string"
end

---Applies a rate limit to a source for 5 seconds
---@param source number The source to rate limit
local function applyRateLimit(source)
    rateLimits[source] = true
    SetTimeout(RATE_LIMIT_MS, function()
        rateLimits[source] = nil
    end)
end

---Sets the cached plate information
---@param plate string The plate to cache
---@param info PlateInfo The plate information to cache
local function setCache(plate, info)
    if not plate or not info then return end

    platesCache[plate] = {
        expires = GetGameTimer() + CACHE_DURATION_MS,
        info = info
    }
end

---Gets the cached plate information
---@param plate string The plate to get the cache for
---@return PlateInfo|nil cachedData The cached plate information or nil if not found
local function getCache(plate)
    if not plate then return nil end

    local cache = platesCache[plate]
    if not cache then return nil end

    if cache.expires > GetGameTimer() then
        return cache.info
    else
        platesCache[plate] = nil
        return nil
    end
end

---@class PlateResponse
---@field status string The API response status
---@field response PlateInfo The plate information response

---@class PlateInfo
---@field owner string The registered owner's name
---@field plate string The license plate number
---@field stolen boolean Whether the vehicle is stolen
---@field insurance boolean Whether the vehicle is insured
---@field insurance_status? string Current insurance status ('ACTIVE'/'EXPIRED'/etc)
---@field business boolean If it is a vehicle reg
---@field reg_status string Current registration status ('ACTIVE'/'EXPIRED'/etc)
---@field owner_wanted boolean Any active warrants for the owner
---@field owner_dl_status string Driver's license status ('ACTIVE'/'SUSPENDED'/etc)

---Scans a license plate and returns vehicle/owner information
---@param source number The source requesting the scan
---@param plate string The plate to scan
---@return PlateInfo|false response The plate info or false if error
lib.callback.register("wk:scanPlate", function(source, plate)
    if not source or not plate then return false end

    if not validatePlate(plate) then
        lib.print.error(("Invalid plate: %s"):format(plate))
        return false
    end
    if rateLimits[source] then
        lib.print.warn(("Rate limit hit for source: %s"):format(source))
        return false
    end

    local cachedData = getCache(plate)

    if cachedData then return cachedData end

    applyRateLimit(source)

    local bodyData = {
        communityId = commId,
        plate = plate
    }

    lib.print.info(("Making API request for plate %s"):format(plate))
    local respCode, resultData, respHeaders, errorData = PerformHttpRequestAwait(url, 'POST', json.encode(bodyData),
        headers)

    if respCode == 404 or respCode == 400 then
        lib.print.warn(("Plate is not found on CAD: %s"):format(plate))
        return false
    end
    if errorData or not resultData then
        lib.print.error(("Imperial API returned an error: %s"):format(json.encode(errorData)))
        lib.print.error(("Imperial API returned a non-200 response code: %s"):format(respCode))
        lib.print.error(("Imperial API returned a non-200 response code: %s"):format(json.encode(respHeaders)))
        lib.print.error(("Imperial API returned a non-200 response code: %s"):format(json.encode(resultData)))
        return false
    end

    ---@type PlateResponse
    local data = json.decode(resultData)

    if data.status ~= "success" then
        lib.print.error(("Imperial API returned a non-success response: %s"):format(json.encode(data)))
        return false
    end

    local plateInfo = data.response

    setCache(plate, plateInfo)
    return plateInfo
end)

local function cleanupCache()
    local currentTime = GetGameTimer()

    for plate, data in pairs(platesCache) do
        local expires = data.expires and data.expires or 0
        local gracePeriod = expires + CLEANUP_GRACE_PERIOD_MS

        if gracePeriod <= currentTime then
            platesCache[plate] = nil
        end
    end
end

CreateThread(function()
    while true do
        Wait(CACHE_CLEANUP_INTERVAL_MS)
        cleanupCache()
    end
end)

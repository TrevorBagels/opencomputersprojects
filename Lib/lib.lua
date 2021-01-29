lib = {}

--I don't take any credit for any of these functions. Most of these are things I stole off the internet that I feel should always be available when programming, and here they are all in one file.


local serialization = require "serialization"
local io = require"io"


function lib.realTime() -- stolen from Kristopher38 on an OpenComputers discord server. 
    local tmpName = os.tmpname()
    local tmpFile = filesystem.open(tmpName, "a") -- touch file
    if tmpFile then
        tmpFile:close()
        local timestamp = filesystem.lastModified(tmpName) / 1000
        filesystem.remove(tmpName)
        return timestamp
    else
        return 0
    end
end



function lib.input(prompt, numberize, bool)
    local i = nil
    while true do
        io.write(prompt)
        i = io.read()
        if numberize then i = tonumber(i) end
        if bool then
            if tostring(i):lower() == "y" then i = true else i = false; end
        end
        if type(i) ~= "number" and numberize == true then i = nil end 
        if i ~= nil then break end
    end
    return i
end

function lib.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function lib.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
    return s .. '} '
    else
        return tostring(o)
    end
end

function lib.formatRF(amount)
    if amount > 1000000 then return tostring(round(amount / 1000000, 3)) .. "MRF" end
    if amount > 1000 then return tostring(round(amount / 1000, 3)) .. "kRF" end
    return tostring(amount) .. "RF"
end

function lib.save(data, filename)
    local file = io.open(filename, "w")
    file:write(serialization.serialize(data))
    file:close()
    print("Saved!")
end

function lib.load(filename)
    local file = io.open(filename, "r")
    return serialization.unserialize(file:read())
end

function lib.split(pString, pPattern)
    local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
end

return lib
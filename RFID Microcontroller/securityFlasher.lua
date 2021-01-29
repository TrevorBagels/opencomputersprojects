local colors = require "colors"
local component = require "component"
local args = {...}
local os, io = require("os"), require("io")

if #args == 0 then print("Usage: securityFlasher [code] [displayName] [range(optional)] [color(optional)]"); os.exit() end

local color = "white"
local range = 3

if args[3] ~= nil then range = tonumber(args[3]) end
if args[4] ~= nil then color = args[4] end

local fr = io.open("security.lua", "r")
local lines = {}
for line in fr:lines() do
    table.insert(lines, line)
end
fr:close()

table.insert(lines, 1, "local code = \"" .. args[1] .. "\";local range = " .. range .. ";\n")

local f = io.open("securityeeprom.lua", "w")
for _, line in ipairs(lines) do 
    f:write(line .. "\n")
end
f:close()

print("Flashing to EEPROM with code: " .. args[1])
os.execute("flash -q securityeeprom.lua " .. args[2])
print("Done!")

print("Press enter to write the code to a card. Type q and press enter to quit.")
while true do
    local i = io.read()
    if i == "q" then break else
        component.os_cardwriter.write(args[1], args[2], false, colors[color])
        print("Wrote to card!")
    end
end
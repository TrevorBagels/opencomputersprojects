local event = require "event"
local serialization = require "serialization"
local collected = {}

function save(data, filename)
  local addData = {}
  local file = io.open(filename, "r")
  if file ~= nil then print("Appending data to already existing data."); file:close(); file = nil; addData = load(filename); for k,v in pairs(addData) do if data[k] == nil then data[k] = v; end; end; end;
  local file = io.open(filename, "w")
  file:write(serialization.serialize(data))
  file:close()
  print("Saved!")
end
function load(file)
    local file = io.open(file, "r")
    return serialization.unserialize(file:read())
end

print("Press Q when you're ready to save")
while true do
  local evt, address, name = event.pull()
  if evt == "key_up" and name == string.byte("q") then 
    break
  end
  if evt == "component_added" then 
    print("You've added a new component: " .. name)
    io.write("What would you like to name this component?\n> ")
    local setName = io.read()
    collected[setName] = {name=setName, address=address, componentType=name}
  end
end
io.write("What would you like to name the file containing this configuration?\n> ")
local filename = io.read()
save(collected, filename)
print("Done!")
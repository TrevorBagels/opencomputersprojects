local cconfig = {}
local io = require "io"
local component = require "component"
local serialization = require "serialization"
function cconfig.load(filename)
    local file = io.open(filename, "r")
    local data = serialization.unserialize(file:read())
    local components = {}
    for k,v in pairs(data) do
        components[v.name] = component.proxy(v.address)
    end
    return components
end
return cconfig
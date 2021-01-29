--local code = "CODEGOESHERE"; local range = 3
local sCode = "flhafdlhkjfadshjlflhasljdfjkhsdafsdlfhlhfdashkljflhjkasdfhkljhjlkasdflhjkfda" --change this to whatever you want, and use the code to access literally every scanner you make with this. 
local door, rfid = component.proxy(component.list("os_doorcontroller")()), component.proxy(component.list("os_rfidreader")())

 while true do
    local data = rfid.scan(range)
    local auth = false
    if type(data) == "table" then
        for _, i in pairs(data) do
            if i.data == sCode or i.data == code then auth = true end
        end
    end
    if auth then door.open() else door.close() end
    computer.pullSignal(2)
 end
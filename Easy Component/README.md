Simply download or paste these scripts into your current working directory

To add components, just run `configure.lua`. Then, add components to the computer. Once a component becomes available, the program will prompt you to enter a name for that component. After that, feel free to add another component, and do it again and again until you've added all the components you need. Press `q` to finish adding components. You'll be prompted to enter a filename for the data to be saved to. If data has already been saved to an existing file, using that file's name will append new components to it.
To access the components in a script, do this:
```
--assuming we saved the component names to "devices.txt"
local myComponents = require("cconfig").load("devices.txt") --loads the components
myComponents["device #1"].doThing() --assume doThing is a function of whatever component "device #1" is.
```

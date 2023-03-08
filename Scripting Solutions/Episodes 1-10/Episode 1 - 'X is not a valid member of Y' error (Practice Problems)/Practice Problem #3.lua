-- Practice Problem #3 (Server-sided / Server Script Code)

--[[ Necessary objects to set up before solving:

Create a Script (with "RunContext" property set to "Legacy" or "Server"). Place inside of the "ServerScriptService" Service. Copy the code from line 9 and beyond and paste it into the Script.

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function lookForObject()
	--[[ For this example, imagine the code in this function 
		is in a completely different script from the code
		that starts on line #20 and beyond
	--]]
	
	local theExampleFolder = ReplicatedStorage["Example Folder"]
	theExampleFolder.Name = "Renamed Example Folder"
	
	if ReplicatedStorage:FindFirstChild("Renamed Example Folder") then
		warn("Success!") 
		print("You've solved "..script.Name)
	end
end
coroutine.wrap(lookForObject)()

-- Imagine the new script starts here

task.wait(2)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local exampleFolder = Instance.new("Folder")
exampleFolder.Name = "Example Folder"
exampleFolder.Parent = ReplicatedStorage

--[[

This is Episode 1 of Emancyphur's Scripting Solutions Tutorial Series!

The full list of practice problem models from this series can be
found through the description of the Roblox group that posted this model.

]]--

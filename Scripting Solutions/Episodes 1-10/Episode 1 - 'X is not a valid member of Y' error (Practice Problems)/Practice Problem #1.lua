-- Practice Problem #1 (Server-sided / Server Script Code)

--[[ Necessary objects to set up before solving:

Create a Script (with "RunContext" property set to "Legacy" or "Server"). Place inside of the "ServerScriptService" Service. Copy the code from line 10 and beyond and paste it into the Script.
Create a "RemoteEvent" (don't change the name). Place inside of the "ReplicatedStorage" Service.

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage.RemotEvent
RemoteEvent.name = "Practice Problem Example"


if RemoteEvent.Name == "Practice Problem Example" then
	warn("Success!") 
	print("You've solved "..script.Name)
end

--[[

This is Episode 1 of Emancyphur's Scripting Solutions Tutorial Series!

The full list of practice problem models from this series can be
found through the description of the Roblox group that posted this model.

]]--

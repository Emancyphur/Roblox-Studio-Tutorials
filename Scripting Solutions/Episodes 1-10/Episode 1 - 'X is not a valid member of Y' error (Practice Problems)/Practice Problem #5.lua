-- Practice Problem #5 (Server-sided / Server Script Code)

--[[ Necessary objects to set up before solving:

Create a Script (with "RunContext" property set to "Legacy" or "Server"). Place inside of the "ServerScriptService" Service. Copy the code from line 12 and beyond and paste it into the Script.
Create a "Model" (don't change the name). Place inside of the "Workspace" Service.
Create an "Atmosphere" object (don't change the name). Place inside of the "ReplicatedStorage" Service.
Create a "Part" and rename it to "Example". Place inside of the "ServerStorage" Service.

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

coroutine.wrap(function()
	print("Waiting 7 seconds until moving the Part called 'Example' to the Workspace...")
	task.wait(7)
	ServerStorage.example.Parent = workspace.Model["New Folder"]
	warn("The Part has been moved to the Workspace!")
end)()

local function testFunction()
	if ReplicatedStorage.atmosphere then
		local newObject = Instance.new("Folder")
		newObject.Name = "new Folder"
		newObject.Parent = ReplicatedStorage -- Hmmm, is this the correct spot to place the object?
		
		local exampleObject = workspace.Exammple
		exampleObject.Names = "Updated Example"
	end
end
testFunction()


local solutionCheck1 = workspace.Model:FindFirstChild("New Folder")
local solutionCheck2 = solutionCheck1:FindFirstChild("Updated Example")
if solutionCheck1 and solutionCheck2 then
	warn("Success!") 
	print("You've solved "..script.Name)
end

--[[

This is Episode 1 of Emancyphur's Scripting Solutions Tutorial Series!

The full list of practice problem models from this series can be
found through the description of the Roblox group that posted this model.



This model / script was originally published to the Roblox Creator Marketplace by the following group: Emancyphur

IF the model that contains this script was NOT published by either:
1. The group called "Emancyphur"
2. The user named "Emancyphur"
3. Or the user named "StrongBigeMan9"
it may have been modified from its original state; in that case, use AT YOUR OWN RISK!

]]--

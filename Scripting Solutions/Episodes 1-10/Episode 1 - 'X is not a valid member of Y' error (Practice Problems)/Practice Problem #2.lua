-- Practice Problem #2 (Server-sided / Server Script Code)

--[[ Necessary objects to set up before solving:

Create a Script (with "RunContext" property set to "Legacy" or "Server"). Place inside of the "ServerScriptService" Service. Copy the code from line 12 and beyond and paste it into the Script.
Create a "Folder" (don't change the name). Place inside of the "Workspace" Service.
Create a "Model" (don't change the name). Place inside of the "Folder".
Create a "Part" (it also should be named "Part", not to be confused with MeshParts and etc.). Place inside of the "Model".

]]--

local Part = workspace.Part
local clonedPart = Part:Clones()
clonedPart.Name = "A brand new part!"
clonedPart.Parent = workspace.Folder


if workspace.Folder:FindFirstChild("A brand new part!") then
	warn("Success!") 
	print("You've solved "..script.Name)
end

--[[

This is Episode 1 of Emancyphur's Scripting Solutions Tutorial Series!

The full list of practice problem models from this series can be
found through the description of the Roblox group that posted this model.

]]--

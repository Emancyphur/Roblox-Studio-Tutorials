-- Practice Problem #4 (Client-sided / LocalScript Code)
-- (When playtesting, choose "Play" or "Play Here" and NOT "Run" mode)
-- ("Run" mode is a server-sided playtest, which wouldn't work with this)

--[[ Necessary objects to set up before solving:

Create a LocalScript. Place inside of the "StarterPlayerScripts" folder, which can be found inside of the "StarterPlayer" Service. Copy the code from line 12 and beyond and paste it into the LocalScript.
Create a "ScreenGui" (don't change the name). Place inside of the "ServerStorage" Service.

]]--

local ServerStorage = game:GetService("ServerStorage")
local ScreenGui = ServerStorage.ScreenGui

ScreenGui.Destroying:Connect(function()
	warn("Success!") 
	print("You've solved "..script.Name)
end)

ScreenGui:Destroying()

--[[

This is Episode 1 of Emancyphur's Scripting Solutions Tutorial Series!

The full list of practice problem models from this series can be
found through the description of the Roblox group that posted this model.

]]--

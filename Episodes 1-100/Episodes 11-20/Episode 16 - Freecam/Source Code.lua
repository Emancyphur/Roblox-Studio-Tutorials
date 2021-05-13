--[[

Episode 16 - How to Freecam/Spectate in your game (Cinematic Camera)
Tutorial Link: ( https://youtu.be/7aqTd3PzWWM )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Disabling Built-in Freecam.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Freecam = ReplicatedStorage:WaitForChild("Freecam")

Players.PlayerAdded:Connect(function(plyr)
	Freecam:FireClient(plyr)
end)



------ LocalScript ------

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Freecam = ReplicatedStorage:WaitForChild("Freecam")

Freecam.OnClientEvent:Connect(function()
	local PlayerGui = player:WaitForChild("PlayerGui")
	local camera = PlayerGui:FindFirstChild("Freecam")
		if camera then camera:Destroy()
	end
end)

--[[ 
This is Episode 16 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

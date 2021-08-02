--[[

Episode 4 - Jailbreak Prison Escape Script
Tutorial Link: ( https://youtu.be/5DaDfDkKRyo )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Team Custom Characters System.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")

local Teams = game:GetService("Teams")
local Prisoner = Teams.Prisoner
local Criminal = Teams.Criminal

local EscapeBrick = script.Parent

EscapeBrick.Touched:Connect(function(touch)
	
	local player = Players:GetPlayerFromCharacter(touch.Parent)
	
	if player then
		if player.Team == Prisoner then
			player.Team = Criminal
		end
	end
end)

--[[ 
This is Episode 4 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

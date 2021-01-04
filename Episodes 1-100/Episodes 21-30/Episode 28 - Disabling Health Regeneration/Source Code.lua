--[[

Episode 28 - Disabling Health Regeneration
Tutorial Link: ( https://youtu.be/sv6bBYWgJec )

This is the second option for disabling health regeneration in your Roblox game.
For comments that explain every line, please refer to the "Commented Version" below the "Non-Commented Version" on this page

]]--

------ Non-Commented Version ------


local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(Character)
		
		local ScriptCheck = Character:FindFirstChild("Health")
		
		if ScriptCheck and ScriptCheck:IsA("Script") then
			ScriptCheck:Destroy()
		end
	end)
end)


------ Commented Version ------
-- Place this script into the "ServerScriptService"

local Players = game:GetService("Players") -- References the Players service

Players.PlayerAdded:Connect(function(player) -- Activates a function whenever someone joins the game -- the player that joined can be referenced by "player"
	player.CharacterAdded:Connect(function(Character) -- Activates a function whenever a player's Character respawns -- the Character that respawned can be referenced by "Character"
		
		local ScriptCheck = Character:FindFirstChild("Health") -- Creates a varible that will look through the Character for something called "Health"
		
		if ScriptCheck and ScriptCheck:IsA("Script") then -- If the script finds something called "Health" inside of the Character and the item is a script, then...
			ScriptCheck:Destroy() -- The "Health" script will be destroyed
		end -- Ends the "if ScriptCheck and "ScriptCheck:IsA("Script")" then statement
	end) -- Ends CharacterAdded function
end) -- Ends PlayerAdded function


--[[ 
This is Episode 28 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

--[[

Episode 31 - How to make Hats/Accessories
Tutorial Link: ( https://youtu.be/DmsbnwtaVi0 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Welding & Accessory Resources.rbxm" file in the folder that contains this Source Code

]]--

------ Touched Event Server Script ------

local Players = game:GetService("Players")

local Handle = script.Parent
local Accessory = Handle.Parent

Handle.Touched:Connect(function(object)
	local player = Players:GetPlayerFromCharacter(object.Parent)

	if player then

		local Character = player.Character or player.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if Character and Humanoid then
			
			Humanoid:AddAccessory(Accessory)
			
			script:Destroy()
		end
	end
end)


------ ClickDetector Server Script ------

local ClickDetector = script.Parent
local Handle = ClickDetector.Parent
local Accessory = Handle.Parent

ClickDetector.MouseClick:Connect(function(player)

	local Character = player.Character or player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Character and Humanoid then
		
		Humanoid:AddAccessory(Accessory)
		
		ClickDetector:Destroy()
	end
end)


------ ProximityPrompt Server Script ------

local ProximityPrompt = script.Parent
local Handle = ProximityPrompt.Parent
local Accessory = Handle.Parent

ProximityPrompt.TriggerEnded:Connect(function(player)

	local Character = player.Character or player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Character and Humanoid then
		
		Humanoid:AddAccessory(Accessory)
		
		ProximityPrompt:Destroy()
	end
end)

--[[ 
This is Episode 31 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

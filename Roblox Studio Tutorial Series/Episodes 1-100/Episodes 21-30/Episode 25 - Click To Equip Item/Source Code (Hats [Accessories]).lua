--[[

Episode 25 - Click to Equip Hat, Clothing, & Tools
Tutorial Link: ( https://youtu.be/eWmmZdBM8MY )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Click to Equip Hat, Clothing, & Tools.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local ServerStorage = game:GetService("ServerStorage")
local RealHats = ServerStorage.RealHats:GetChildren()

local FakeHats = workspace:WaitForChild("FakeHats"):GetChildren()

local function GiveHat(player,FakeHat)
	
	local Character = player.Character or player.CharacterAdded:Wait()
	local HatCheck = Character:FindFirstChild(FakeHat.Name)
	local Humanoid = Character:WaitForChild("Humanoid")
	
	--Humanoid:RemoveAccessories() -- Optionally removes the Accessories of the player when this function is run. Remove the two "--" at the very beginning of the line if you want this to be activated
	
	if not HatCheck then
		for i,RealHat in pairs(RealHats) do
			if FakeHat.Name == RealHat.Name then
				local ClonedHat = RealHat:Clone()
				Humanoid:AddAccessory(ClonedHat)
			end
		end
	end
end

for i,FakeHat in pairs(FakeHats) do
	
	local Handle = FakeHat:FindFirstChild("Handle")
	local ClickDetector = Handle:FindFirstChildOfClass("ClickDetector")
	
	if Handle and ClickDetector then
		ClickDetector.MouseClick:Connect(function(player)
			GiveHat(player,FakeHat)
		end)
	end
end

--[[ 
This is Episode 25 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

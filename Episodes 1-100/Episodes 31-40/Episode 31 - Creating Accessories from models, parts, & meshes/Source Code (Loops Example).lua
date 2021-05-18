--[[

Episode 31 - How to make Hats/Accessories
Tutorial Link: ( https://youtu.be/DmsbnwtaVi0 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Welding & Accessory Resources.rbxm" file in the folder that contains this Source Code


This example is from Episode 25 of my Roblox Studio Tutorial series.
The directory for that Episode can be found here: [ https://github.com/Asians-FTW/ROBLOX-Studio-Tutorials/tree/main/Episodes%201-100/Episodes%2021-30/Episode%2025%20-%20Click%20To%20Equip%20Item ]

]]--

------ Server Script ------

local ServerStorage = game:GetService("ServerStorage")

local folderCheck = script:FindFirstChild("RealHats")

if folderCheck then
	folderCheck.Parent = ServerStorage
end

local RealHats = ServerStorage.RealHats
local FakeHats = workspace["Equipping Accessories Examples"]["Loops Example"]["Hats Setup"].FakeHats

local function GiveHat(player, FakeHat)
	
	local Character = player.Character or player.CharacterAdded:Wait()
	local HatCheck = Character:FindFirstChild(FakeHat.Name)
	local Humanoid = Character:WaitForChild("Humanoid")
	
	if Character and Humanoid and not HatCheck then
		for i,RealHat in pairs(RealHats:GetChildren()) do
			if FakeHat.Name == RealHat.Name then
				local ClonedHat = RealHat:Clone()
				Humanoid:AddAccessory(ClonedHat)
			end
		end
	end
end


for i, FakeHat in pairs(FakeHats:GetChildren()) do
	
	local Handle = FakeHat:FindFirstChild("Handle")
	local ClickDetector = Handle:FindFirstChildOfClass("ClickDetector")
	
	if Handle and ClickDetector then
		ClickDetector.MouseClick:Connect(function(player)
			GiveHat(player, FakeHat)
		end)
	end
end

--[[ 
This is Episode 31 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

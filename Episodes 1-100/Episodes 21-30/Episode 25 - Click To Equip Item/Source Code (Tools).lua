--[[

Episode 25 - Click to Equip Hat, Clothing, & Tools
Tutorial Link: ( https://youtu.be/eWmmZdBM8MY )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Click to Equip Hat, Clothing, & Tools.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local ServerStorage = game:GetService("ServerStorage")
local RealTools = ServerStorage.RealTools:GetChildren()

local FakeTools = workspace:WaitForChild("FakeTools"):GetChildren()

local function GiveTools(player,FakeTool)
	
	local Backpack = player.Backpack
	local Character = player.Character or player.CharacterAdded:Wait()
	
	local BackpackCheck = Backpack:FindFirstChild(FakeTool.Name)
	local CharacterCheck = Character:FindFirstChild(FakeTool.Name)
	
	if Backpack and not BackpackCheck or CharacterCheck then
		for i,RealTool in pairs(RealTools) do
			if FakeTool.Name == RealTool.Name then
				local ClonedTool = RealTool:Clone()
				ClonedTool.Parent = Backpack
			end
		end
	end
end

for i,FakeTool in pairs(FakeTools) do
	
	local Handle = FakeTool:FindFirstChild("Handle")
	local ClickDetector = Handle:FindFirstChildOfClass("ClickDetector")
	
	if Handle and ClickDetector then
		ClickDetector.MouseClick:Connect(function(player)
			GiveTools(player,FakeTool)
		end)
	end
end

--[[ 
This is Episode 25 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

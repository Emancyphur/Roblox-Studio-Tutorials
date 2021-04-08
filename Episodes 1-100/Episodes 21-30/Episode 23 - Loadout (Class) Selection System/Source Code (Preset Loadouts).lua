--[[

Episode 23 - Loadout/Class Selection System (Preset/Custom for each player)
Tutorial Link: ( https://youtu.be/LjETISdUBp8 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Loadout Selection System.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeLoadout = ReplicatedStorage:WaitForChild("ChangeLoadout")

local ServerStorage = game:GetService("ServerStorage")
local Loadouts = ServerStorage:WaitForChild("Loadouts")
local ServerLoadouts = Loadouts:GetChildren()


local Requirements = {

	["Swordsman"] = 0,
	["Brickbattler"] = 0,
	
}


local function ChangePlayerLoadout(player,Text,Frame)
	
	local textCheck = type(Text) == "string"
	local frameCheck = Frame:IsA("Frame")
	
	if textCheck and frameCheck then
		
		local leaderstats = player:FindFirstChild("leaderstats")
		local Level = leaderstats:FindFirstChild("Level")


		local function LeaderstatsCheck(requirement)
			if leaderstats and Level then

				if Level.Value and Level.Value >= requirement then
					return true
				end

			else
				return false
			end
		end
		
		for name,requirement in pairs(Requirements) do
			
			local textCheck = Text == name
			local checkRequirements = LeaderstatsCheck(requirement)
			
			if textCheck and checkRequirements then
				
				local playerLoadout = player:FindFirstChild("Loadouts")
				local loadout = playerLoadout:FindFirstChild("loadout")
				
				if playerLoadout and loadout then
					loadout.Value = name
					return loadout
				end
			end
		end
	end
end
ChangeLoadout.OnServerInvoke = ChangePlayerLoadout


local function GiveLoadout(player)
	
	local playervalues = player:WaitForChild("Loadouts"):GetChildren()
	local Backpack = player:WaitForChild("Backpack")
	
	local Character = player.Character or player.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")
	
	for i,LoadoutsFolder in pairs(ServerLoadouts) do
		for i,PlayerValue in pairs(playervalues) do
			if PlayerValue.Value == LoadoutsFolder.Name then
				
				local NewLoadout = LoadoutsFolder:GetChildren()
				
				for i,Item in pairs(NewLoadout) do
					
					local Clone = Item:Clone()
						
					local CharacterCheck = Character:FindFirstChild(Item.Name)
					local BackpackCheck = Backpack:FindFirstChild(Item.Name)
						
					Humanoid:UnequipTools()
						
					if Item:IsA("Tool") and not CharacterCheck or BackpackCheck then
						Clone.Parent = Backpack
					end
				end
			end
		end
	end
end


Players.PlayerAdded:Connect(function(player)
	
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = player
	
	local Level = Instance.new("IntValue")
	Level.Name = "Level"
	Level.Parent = Leaderstats
	Level.Value = "0"
	

	
	local Loadouts = Instance.new("Folder")
	Loadouts.Name = "Loadouts"
	Loadouts.Parent = player

	local Value1 = Instance.new("StringValue")
	Value1.Name = "loadout"
	Value1.Parent = Loadouts
	Value1.Value = "No Loadout"
	
	player.CharacterAdded:Connect(function(character)
		GiveLoadout(player)
	end)
end)



------ LocalScript ------
local ScreenGui = script.Parent
local Menu = ScreenGui.Menu
local MainFrame = ScreenGui:WaitForChild("MainFrame")
local TextLabels = MainFrame.TextLabels:GetChildren()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeLoadout = ReplicatedStorage:WaitForChild("ChangeLoadout")



Menu.Activated:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

local function ChangePlayerLoadout(Text,Frame)
	print("Sending "..Text.." from a button inside of "..Frame.Name)
	
	local NewLoadout = ChangeLoadout:InvokeServer(Text,Frame)
	
	for i,Label in pairs(TextLabels) do
		if Label:IsA("TextLabel") and NewLoadout ~= nil and NewLoadout.Name == Label.Name then
			Label.Text = NewLoadout.Value
		end
	end
end

for i,Item in pairs(MainFrame:GetDescendants()) do
	if Item:IsA("TextButton") then
		
		local Frame = Item.Parent
		local Text = Item.Text
		
		Item.Activated:Connect(function()	
			ChangePlayerLoadout(Text,Frame)
		end)
	end
end

--[[ 
This is Episode 23 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

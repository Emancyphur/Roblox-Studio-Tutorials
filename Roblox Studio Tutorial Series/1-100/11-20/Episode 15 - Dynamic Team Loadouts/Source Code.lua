--[[

Episode 15 - Dynamic Team Loadouts/Team-Only Tools
Tutorial Link: ( https://youtu.be/DpBTmWHkXbo )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Dynamic Team Loadouts.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")

local TeamLoadouts = require(script.Parent.TeamLoadoutsModule)


local function PlayerJoin(player)
	
	player:GetPropertyChangedSignal("Neutral"):Connect(function()
		if player.Neutral then
			
			local Backpack = player:WaitForChild("Backpack")
			local Character = player.Character or player.CharacterAdded:Wait()
			
			if Backpack then
				TeamLoadouts.ClearItems(player,Backpack)
			end
			
			if Character then
				TeamLoadouts.ClearItems(player,Character)
			end
			
		end
	end)
	
	
	
	player.CharacterAdded:Connect(function(Character)
		
		
		TeamLoadouts.GiveItems(player)
		
		
		local Backpack = player:WaitForChild("Backpack")
		
		
		
		local function IndividualItemCheck(Item)
			
			if Item:IsA("Tool") then
				
				TeamLoadouts.ClearItems(player,nil,Item)
			end
		end
		
		
		Character.ChildAdded:Connect(IndividualItemCheck)
		Backpack.ChildAdded:Connect(IndividualItemCheck)
		
		
		
	end)
	
end


for _,player in ipairs(Players:GetPlayers()) do
	coroutine.wrap(PlayerJoin)(player)
end


Players.PlayerAdded:Connect(PlayerJoin)



------ ModuleScript ------

local TeamLoadouts = {}

local ServerStorage = game:GetService("ServerStorage")
local MainFolder = ServerStorage.MainFolder

local Teams = game:GetService("Teams")


local function UpdateTeamLoadouts(ToolName,TeamName)
	
	if ToolName and TeamName then
		
		if not TeamLoadouts[ToolName] then
			TeamLoadouts[ToolName] = TeamName
		end
	end
end



local function UpdateTeamList(TeamFolder)
	
	if TeamFolder:IsA("Folder") and Teams:FindFirstChild(TeamFolder.Name) then
		
		
		TeamFolder.ChildAdded:Connect(function(Item)
			if Item:IsA("Tool") then
				UpdateTeamLoadouts(Item.Name,TeamFolder.Name)
			end
		end)
		
		
		
		TeamFolder.ChildRemoved:Connect(function(Item)
			if Item:IsA("Tool") and TeamLoadouts[Item.Name] then
				TeamLoadouts[Item.Name] = nil
			end
		end)
		
		
		
		for _,Item in ipairs(TeamFolder:GetChildren()) do
			if Item:IsA("Tool") then
				UpdateTeamLoadouts(Item.Name,TeamFolder.Name)
			end
		end
		
		
	end
end


MainFolder.ChildAdded:Connect(UpdateTeamList)

for _,TeamFolder in ipairs(MainFolder:GetChildren()) do
	UpdateTeamList(TeamFolder)
end






local MainFunctions = {}


function MainFunctions.ClearItems(player,Container,IndividualItem)
	
	if player:IsA("Player") then


		local function ItemCheck(Item)
			
			local LoadoutCheck = TeamLoadouts[Item.Name]
			
			if LoadoutCheck then
				
				if player.Neutral or not player.Team then
					Item:Destroy()
					
					
				elseif player.Team and not player.Neutral then
					if player.Team.Name ~= LoadoutCheck then
						Item:Destroy()
					end
				end
			end
		end
		
		
		
		if IndividualItem then
			
			if IndividualItem:IsA("Tool") then
				wait()
				ItemCheck(IndividualItem)
			end
			
			
			
			
		elseif Container then
			
			for _,Item in ipairs(Container:GetChildren()) do
				
				if Item:IsA("Tool") then
					ItemCheck(Item)
				end
			end
		end
		
		
	end
end




function MainFunctions.GiveItems(player)
	
	if player:IsA("Player") then
		
		local Backpack = player:WaitForChild("Backpack")
		local Character = player.Character or player.CharacterAdded:Wait()
		
		
		MainFunctions.ClearItems(player,Backpack)
		MainFunctions.ClearItems(player,Character)
		
		
		if player.Team and not player.Neutral then
			
			local TeamFolder = MainFolder:FindFirstChild(player.Team.Name)
			
			if TeamFolder then
				
				for _,Tool in ipairs(TeamFolder:GetChildren()) do
					
					local BackpackCheck = Backpack:FindFirstChild(Tool.Name)
					local CharacterCheck = Character:FindFirstChild(Tool.Name)
					
					if not BackpackCheck and not CharacterCheck then
						
						local ClonedTool = Tool:Clone()
						ClonedTool.Parent = Backpack
					end
				end
			end
		end
	end
end



local function TeamChange(Team)
	
	Team.PlayerAdded:Connect(MainFunctions.GiveItems)
	
end


Teams.ChildAdded:Connect(function(Team)
	
	if Team:IsA("Team") then
		TeamChange(Team)
	end
	
end)


for _,Team in ipairs(Teams:GetTeams()) do
	TeamChange(Team)
end


return MainFunctions

--[[ 
This is Episode 15 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

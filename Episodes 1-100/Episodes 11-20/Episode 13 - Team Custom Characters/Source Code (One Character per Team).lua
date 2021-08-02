--[[

Episode 13 - Team Custom Characters System
Tutorial Link: ( https://youtu.be/dkXCWZdZR-s )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Team Custom Characters System.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local ServerStorage = game:GetService("ServerStorage")
local TeamCharacters = ServerStorage:WaitForChild("TeamCharacters")

local RespawnDelay = 2.5

local RespawnConnections = {}
local CharacterPositions = {}
local RigTypes = {}

Players.CharacterAutoLoads = false

local FirstSpawn = {}


local function AnimatorCreator()

	for i,Character in pairs(TeamCharacters:GetChildren()) do
		
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		
		if not Humanoid then
			
			local NewHumanoid = Instance.new("Humanoid")
			NewHumanoid.Name = "Humanoid"
			NewHumanoid.RigType = Enum.HumanoidRigType.R15
			NewHumanoid.Parent = Character
			warn("A Humanoid object has been created for "..Character.Name..". An R15 Humanoid was added by default. \nIf you are using an R6 Character, please manually add one into the Custom Character while editing, then select it, go into its Properties, and change 'RigType' to R6")
			
			Humanoid = Character:FindFirstChildOfClass("Humanoid")
		end
		
		if Humanoid and not Humanoid:FindFirstChild("Animator") then
			warn("No Animator object in Humanoid for "..Character.Name.." -- creating one so Animations replicate to server")
			
			local AnimateLocalScript = Character:FindFirstChild("Animate")
			
			if not AnimateLocalScript then warn("No Animate LocalScript detected for "..Character.Name.." please add one for this Character so that it will have proper Animations")
			
			elseif AnimateLocalScript then
				
				local Animator = Instance.new("Animator")
				Animator.Parent = Humanoid
			end
		end
	end
end

AnimatorCreator()
TeamCharacters.ChildAdded:Connect(AnimatorCreator)





local function RespawnPlayer(player,LoadCharacter)
	
	if RespawnConnections[player] then
		RespawnConnections[player]:Disconnect()
		RespawnConnections[player] = nil
	end
	
	if LoadCharacter then
		wait(RespawnDelay)
		LoadCharacter(player)
	end
end





local function LoadCharacter(player,NewTeam)

	if RigTypes[player] == nil then
		print("No RigType available")
		
		player:LoadCharacter()
		
		local Character = player.Character or player.CharacterAdded:Wait()
		local Humanoid = Character:WaitForChild("Humanoid")
		local RigType = Humanoid.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6"
		
		RigTypes[player] = RigType
		LoadCharacter(player)
		
	elseif RigTypes[player] ~= nil then
		
		if player.Neutral == true or not player.Team then player:LoadCharacter() warn(player.Name.." does not have a team/has the 'Neutral' property set to true.\nThe player.Neutral property must be set to false and the player needs a team to be spawned in as a custom character")
		
		elseif player.Team and player.Neutral == false then
		
			local RigType = RigTypes[player]
		
			local FindTeamCharacter = TeamCharacters:FindFirstChild(player.Team.Name..RigType)
			
			if FindTeamCharacter and NewTeam ~= true then
				
				print("Teamcharacter found for "..player.Name.." on "..player.Team.Name)
				
				local NewCharacter = FindTeamCharacter:Clone()
			
				NewCharacter.Name = player.Name
				player.Character = NewCharacter
			-------------------------------------------------------------------------------------------
				local SpawnpointsFolder = workspace:FindFirstChild(player.Team.Name.."Spawnpoints")
				
				if not SpawnpointsFolder then warn("No spawnpoints folder found for "..player.Team.Name..", please follow the instructions around line 90 of the script to resolve this")
					
				elseif SpawnpointsFolder then
	
					local Spawnpoints = SpawnpointsFolder:GetChildren()
					local RandomSpawn = Spawnpoints[math.random(1,#Spawnpoints)]
					warn(RandomSpawn)
					
					if RandomSpawn.Position ~= nil then
						player.Character:SetPrimaryPartCFrame(RandomSpawn.CFrame + Vector3.new(0,2,0))
					end
				end
			-------------------------------------------------------------------------------------------
				NewCharacter.Parent = game.Workspace
				
				if FirstSpawn[player] == true and RigTypes[player] == "R6" then
					FirstSpawn[player] = nil
					
					wait(1)
					
					LoadCharacter(player)
				end
				
				
			elseif FindTeamCharacter and NewTeam == true then
				
				print("Teamcharacter found for "..player.Name.." on "..player.Team.Name)
				
				CharacterPositions[player] = player.Character:FindFirstChild("HumanoidRootPart").CFrame
				
				local NewCharacter = FindTeamCharacter:Clone()
				
				NewCharacter.Name = player.Name
				player.Character = NewCharacter
				player.Character:WaitForChild("HumanoidRootPart").CFrame = CharacterPositions[player]
				NewCharacter.Parent = game.Workspace
				
				if FirstSpawn[player] == true and RigTypes[player] == "R6" then
					FirstSpawn[player] = nil

					wait(1)

					LoadCharacter(player)
				end
				
			else player:LoadCharacter() print("No Teamcharacter found for "..player.Name.." on "..player.Team.Name)
				
			end
		end
	end
	
	local Character = player.Character or player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChild("Humanoid")
	RespawnConnections[player] = Humanoid.Died:Connect(function()
		RespawnPlayer(player, LoadCharacter)
	end)
end





for i,Team in pairs(Teams:GetTeams()) do
	Team.PlayerAdded:Connect(function(player)

		if not RigTypes[player] then
			warn("No RigType found for a player! The FirstCharacterLoad function needs to finish its task")

		elseif RigTypes[player] then
			LoadCharacter(player,true)
		end
	end)
end





local function FirstCharacterLoad(player)
	print("FirstCharacterLoad function is running")
	
	if RigTypes[player] ~= Enum.HumanoidRigType.R15 and "R15" or "R6" then
			
		local Character = player.Character or player.CharacterAdded:Wait()
		local Humanoid = Character:WaitForChild("Humanoid")
		local RigType = Humanoid.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6"
			
		RigTypes[player] = RigType
		warn("Hey, RigType has been added")
		
		if RigType == "R6" then
			FirstSpawn[player] = true
		end
		
		Character.Parent = nil
		LoadCharacter(player)
		
	elseif RigTypes[player] == Enum.HumanoidRigType.R15 and "R15" or "R6" then
		print("Heyo, it's already there!")
		print(RigTypes[player])
	end
end



for i,player in pairs(Players:GetPlayers()) do
	player:LoadCharacter()
	FirstCharacterLoad(player)
end



Players.PlayerAdded:Connect(function(player)
	player:LoadCharacter()
	FirstCharacterLoad(player)
end)

Players.PlayerRemoving:Connect(function(player)
	RespawnConnections[player] = nil
	CharacterPositions[player] = nil
	RigTypes[player] = nil
end)

--[[ 
This is Episode 13 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

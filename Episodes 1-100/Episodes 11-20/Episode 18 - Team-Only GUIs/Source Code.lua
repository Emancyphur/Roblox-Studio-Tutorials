--[[

Episode 18 - Team-Only GUIs (Different GUIs for each team)
Tutorial Link: ( https://youtu.be/m-Ng1XVPFuw )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Team-Only GUIs.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Teams = game:GetService("Teams")

local RunService = game:GetService("RunService")

local function updateGuis(player)
	
	RunService.Stepped:Wait()
	
	local PlayerGui = player:WaitForChild("PlayerGui")
	
	local function guiCheck(onTeam)
		for _, Item in ipairs(PlayerGui:GetChildren()) do
			
			local attributeCheck = Item:GetAttribute("Team")
			if attributeCheck then
				
				for _, Team in ipairs(Teams:GetTeams()) do
					if attributeCheck == Team.Name then
						if onTeam == true and player.Team.Name ~= attributeCheck then
							Item:Destroy()
							
						elseif onTeam == false then
							Item:Destroy()
						end
					end
				end
			end
		end
	end
	
	
	if not player.Team or player.Neutral == true then
		guiCheck(false)
		
	elseif player.Team and player.Neutral == false then
		guiCheck(true)
		
		local guiFolder = ServerStorage:FindFirstChild(player.Team.Name)
		
		if guiFolder and guiFolder:IsA("Folder") then
			
			for _, Gui in ipairs(guiFolder:GetChildren()) do
				if not PlayerGui:FindFirstChild(Gui.Name) then
					local clonedGui = Gui:Clone()
					clonedGui.Parent = PlayerGui
				end
			end
		end
	end
end



local function playerJoin(player)
	
	local function activateGuiCheck()
		updateGuis(player)
	end
	
	activateGuiCheck()
	
	player.CharacterAdded:Connect(activateGuiCheck)
	
	player:GetPropertyChangedSignal("TeamColor"):Connect(activateGuiCheck)
end



for _, player in ipairs(Players:GetPlayers()) do
	coroutine.wrap(playerJoin)(player)
end

Players.PlayerAdded:Connect(playerJoin)

--[[ 
This is Episode 18 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

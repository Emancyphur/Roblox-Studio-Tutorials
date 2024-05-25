--[[

Episode 29 - Custom Health Bar
Tutorial Link: ( https://youtu.be/RzPi-uHslP8 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Custom Health Bar Model.rbxm" file in the folder that contains this Source Code
(That file contains the tutorial model that was uploaded to the Roblox website)

]]--

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local MainFrame = script.Parent
local TextLabels = MainFrame.TextLabels
local Frames = MainFrame.Frames

local HealthText = TextLabels.HealthTextLabel
local HealthBar = Frames.HealthBar


local TweenService = game:GetService("TweenService")
local Info = TweenInfo.new(
	
	0.2,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.In,
	0,
	false,
	0
	
)

local function UpdateHealthBar()
	
	local Character = player.Character
	local Humanoid = Character:WaitForChild("Humanoid")
	
	HealthText.Text = math.round(Humanoid.Health)
	
	local percent = Humanoid.Health / Humanoid.MaxHealth * 0.794
	local Goal = {
		
		Size = UDim2.new(percent, 0, HealthBar.Size.Y.Scale, 0)
		
	}
	
	local Tween = TweenService:Create(HealthBar,Info,Goal)
	Tween:Play()
	
	local ActualHealth = Humanoid.Health / Humanoid.MaxHealth
	
	if ActualHealth < 0.2 then
		HealthBar.BackgroundColor3 = Color3.fromRGB(0,0,170)
		
	elseif ActualHealth < 0.5 then
		HealthBar.BackgroundColor3 = Color3.fromRGB(0,170,0)
		
	elseif ActualHealth > 0.5 then
		HealthBar.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
end


local function CharacterRespawned(Character)
	
	UpdateHealthBar()
	
	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.HealthChanged:Connect(UpdateHealthBar)
end

player.CharacterAdded:Connect(CharacterRespawned)

if player.Character then
	CharacterRespawned(player.Character)
end

--[[ 
This is Episode 29 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.

(But since you're reading this on the GitHub, you're already here!)
]]--

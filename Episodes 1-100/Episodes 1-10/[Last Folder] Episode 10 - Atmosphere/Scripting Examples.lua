-- These are the general examples for updating the Atmosphere object through scripting

-- Server Script Example
local Lighting = game:GetService("Lighting")
local Atmosphere = Lighting:FindFirstChild("Atmosphere")

Atmosphere.Density = 0.433
Atmosphere.Offset = 0
Atmosphere.Glare = 6.5
Atmosphere.Haze = 2.56
Atmosphere.Color = Color3.fromRGB(85, 85, 127)
Atmosphere.Decay = Color3.fromRGB(76, 89, 92)




-- ProximityPrompt Example
local Lighting = game:GetService("Lighting")
local Atmosphere = Lighting:FindFirstChild("Atmosphere")

local ProximityPrompt = script.Parent
ProximityPrompt.TriggerEnded:Connect(function()
	Atmosphere.Density = 0.433
	Atmosphere.Offset = 0
	Atmosphere.Glare = 6.5
	Atmosphere.Haze = 2.56
	Atmosphere.Color = Color3.fromRGB(85, 85, 127)
	Atmosphere.Decay = Color3.fromRGB(76, 89, 92)
end)




-- LocalScript Example #1 (StarterPlayerScripts folder)
local Lighting = game:GetService("Lighting")
local Atmosphere = Lighting:FindFirstChild("Atmosphere")

Atmosphere.Density = 0.643
Atmosphere.Offset = 0
Atmosphere.Glare = 2.44
Atmosphere.Haze = 2.56
Atmosphere.Color = Color3.fromRGB(0, 0, 0)
Atmosphere.Decay = Color3.fromRGB(85, 85, 127)




-- LocalScript Example #2 (StarterPlayerScripts folder)
local Lighting = game:GetService("Lighting")
local Atmosphere = Lighting:FindFirstChild("Atmosphere")

local randomNumber = math.random(1, 100)

if randomNumber == 50 then -- This updates the Atmosphere only if the randomly selected number is 50
	Atmosphere.Density = 0.643
	Atmosphere.Offset = 0
	Atmosphere.Glare = 2.44
	Atmosphere.Haze = 2.56
	Atmosphere.Color = Color3.fromRGB(0, 0, 0)
	Atmosphere.Decay = Color3.fromRGB(85, 85, 127)
end

--[[

This is Episode 10 of Emancyphur's Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through this GitHub Repository.

]]--

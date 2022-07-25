local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local Zone = require(ReplicatedStorage.Zone)

if not Lighting:FindFirstChildOfClass("Atmosphere") then
	warn("There wasn't an Atmosphere object in the Lighting! Creating a new one...")
	local newAtmosphere = Instance.new("Atmosphere")
	newAtmosphere.Name = "Atmosphere"
	newAtmosphere.Parent = Lighting
end

local Atmosphere = Lighting.Atmosphere
local atmosphereZones = workspace.AtmosphereZones


local defaultAtmosphere = {
	Density = Atmosphere.Density,
	Offset = Atmosphere.Offset,
	Color = Atmosphere.Color,
	Decay = Atmosphere.Decay,
	Glare = Atmosphere.Glare,
	Haze = Atmosphere.Haze
}


local function CreateZone(container)
	local customZone = Zone.new(container)
	customZone:bindToGroup("EnterOnlyOneZoneAtATime")
	
	customZone.localPlayerEntered:Connect(function()
		local transition = TweenService:Create(Atmosphere, TweenInfo.new(1), container:GetAttributes())
		transition:Play()
	end)
	
	customZone.localPlayerExited:Connect(function()
		local transition = TweenService:Create(Atmosphere, TweenInfo.new(1), defaultAtmosphere)
		transition:Play()
	end)
	
	
	local connection
		
	local function DestroyZone()
		customZone:unbindFromGroup("EnterOnlyOneZoneAtATime")
		customZone:destroy()
			
		connection:Disconnect()
		connection = nil
	end
		
	connection = container.AncestryChanged:Connect(function()
		if container.Parent ~= atmosphereZones then
			DestroyZone()
		end
	end)
		
	container.Destroying:Connect(DestroyZone)
end


for _, container in ipairs(atmosphereZones:GetChildren()) do
	CreateZone(container)
end

atmosphereZones.ChildAdded:Connect(CreateZone)

--[[

This is Episode 10 of Emancyphur's Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through this GitHub Repository.

]]--

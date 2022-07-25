-- This is an optional resource for adding Attributes to the custom zones
-- Instructions for this and creating the custom zones can be found in the "Instructions" LocalScript within the "Custom Atmosphere Zones" folder from the "Atmosphere Resources" model file

local function CreateAttributes()
	local atmosphereAttributes = {
		Density = 0,
		Offset = 0,
		Color = Color3.fromRGB(255,255,255),
		Decay = Color3.fromRGB(255,255,255),
		Glare = 0,
		Haze = 0
	}

	for _, container in pairs(workspace.AtmosphereZones:GetChildren()) do
		
		local totalAttributesAdded = 0
		
		for attributeName, defaultValue in pairs(atmosphereAttributes) do
			
			if not container:GetAttribute(attributeName) then
				totalAttributesAdded += 1
				container:SetAttribute(attributeName, defaultValue)
			end
		end
		
		warn("Successfully added "..totalAttributesAdded.." Attributes for "..container.Name)
	end
end
CreateAttributes()

--[[

This is Episode 10 of Emancyphur's Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through this GitHub Repository.

]]--

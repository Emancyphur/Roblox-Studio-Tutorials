local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local allowedPlayers = {1, 2, 3, 32150440}
local MarketplaceService = game:GetService("MarketplaceService")

local function playerJoin(player)
	
	if
		MarketplaceService:UserOwnsGamePassAsync(player.UserId, 1)
		or table.find(allowedPlayers, player.UserId)

	then
		
		local Freecam = ServerStorage:FindFirstChild("Freecam")
		
		if not Freecam then
			warn("Freecam ScreenGui is not in the ServerStorage")
			return
		end
		
		
		local function giveFreecamAccess()
			
			local PlayerGui = player:WaitForChild("PlayerGui")
			local freecamCheck = PlayerGui:FindFirstChild("Freecam")
			
			if not freecamCheck then

				local newFreecam = Freecam:Clone()
				task.delay(1, function()
					newFreecam.Parent = PlayerGui
				end)
				
			end
		end
		
		giveFreecamAccess()
		player.CharacterAdded:Connect(giveFreecamAccess)
	end
end


for _, player in ipairs(Players:GetChildren()) do
	task.spawn(playerJoin, player)
end

Players.PlayerAdded:Connect(playerJoin)

--[[ 
This is Episode 16 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the description of the Roblox group that posted this model.
]]--

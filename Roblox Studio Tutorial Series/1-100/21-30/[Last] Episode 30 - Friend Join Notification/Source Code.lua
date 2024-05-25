--[[

Episode 30 - Friend Join Notification
Tutorial Link: ( https://youtu.be/wuBjzOcVy2I )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Friend Join Notification LocalScript.rbxm" file in the folder that contains this Source Code
(That file contains the tutorial model that was uploaded to the Roblox website)

]]--

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local player = Players.LocalPlayer


local imageType = Enum.ThumbnailType.HeadShot
local imageSize = Enum.ThumbnailSize.Size420x420

local function createNotification(newPlayer)
	
	local success, avatarIcon, isReady = pcall(function()
		return Players:GetUserThumbnailAsync(newPlayer.UserId, imageType, imageSize)
	end)
	
	local templateTable = {
		
		Title = "A friend joined!",
		Text = (newPlayer.Name.." is here!"),
		Icon = "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420",
		Duration = 10
	}
	
	if success and avatarIcon and isReady then
		templateTable["Icon"] = avatarIcon
	end
	
	StarterGui:SetCore("SendNotification", templateTable)
end


Players.PlayerAdded:Connect(function(newPlayer)
	
	local retryAttempts = 5
	local retryDelay = 1
	
	local success, friendCheck
	
	
	while not success and retryAttempts > 0 do
		
		success, friendCheck = pcall(function()
			return player:IsFriendsWith(newPlayer.UserId)
		end)
		
		retryAttempts -= 1
		wait(retryDelay)
	end
	
	if success and friendCheck then
		createNotification(newPlayer)
	end
end)

--[[ 
This is Episode 30 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

local function destroyFreecam()
	
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local PlayerGui = player:WaitForChild("PlayerGui")
	
	local Freecam = PlayerGui:WaitForChild("Freecam", 5)

	if Freecam then
		Freecam:Destroy()
		warn("Freecam Destroyed!")
	end

	script:Destroy()
end

task.delay(2, destroyFreecam)

--[[ 
This is Episode 16 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the description of the Roblox group that posted this model.
]]--

--[[

Episode 25 - Click to Equip Hat, Clothing, & Tools
Tutorial Link: ( https://youtu.be/eWmmZdBM8MY )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Click to Equip Hat, Clothing, & Tools.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Clothing = workspace:WaitForChild("Clothing"):GetChildren()

local function NewClothing(player,FirstClothing,SecondClothing)
	
	local Character = player.Character or player.CharacterAdded:Wait()
	local Shirt = Character:FindFirstChildOfClass("Shirt")
	local Pants = Character:FindFirstChildOfClass("Pants")
	
	if not Shirt then
		local NewShirt = Instance.new("Shirt")
		NewShirt.Name = "Shirt"
		NewShirt.Parent = Character
		Shirt = Character:FindFirstChildOfClass("Shirt")
	end
	
	if not Pants then
		local NewPants = Instance.new("Pants")
		NewPants.Name = "Pants"
		NewPants.Parent = Character
		Pants = Character:FindFirstChildOfClass("Pants")
	end
	
	
	
	
	if Shirt and Pants then
		
		if FirstClothing:IsA("Shirt") and SecondClothing and SecondClothing:IsA("Pants") then
			Shirt.ShirtTemplate = FirstClothing.ShirtTemplate
			Pants.PantsTemplate = SecondClothing.PantsTemplate
			
		elseif FirstClothing:IsA("Shirt") then
			Shirt.ShirtTemplate = FirstClothing.ShirtTemplate
		
		elseif FirstClothing:IsA("Pants") then
			Pants.PantsTemplate = FirstClothing.PantsTemplate
		end
	end
end

for i,CharacterTemplate in pairs(Clothing) do
	
	local ClickDetector = CharacterTemplate:FindFirstChildOfClass("ClickDetector")
	local Shirt = CharacterTemplate:FindFirstChildOfClass("Shirt")
	local Pants = CharacterTemplate:FindFirstChildOfClass("Pants")
	
	if ClickDetector then
		
		if Shirt and Pants then
			ClickDetector.MouseClick:Connect(function(player)
				NewClothing(player,Shirt,Pants)
			end)
			
		elseif Shirt then
			ClickDetector.MouseClick:Connect(function(player)
				NewClothing(player,Shirt)
			end)
			
		elseif Pants then
			ClickDetector.MouseClick:Connect(function(player)
				NewClothing(player,Pants)
			end)
		end
	end
end

--[[ 
This is Episode 25 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

--[[

Episode 31 - How to make Hats/Accessories
Tutorial Link: ( https://youtu.be/DmsbnwtaVi0 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Welding & Accessory Resources.rbxm" file in the folder that contains this Source Code

]]--

------ Updating Tags Server Script ------

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

local newFolder = ServerStorage:FindFirstChild("Welded Accessories")


local function updateTag(addToTag)

	if newFolder then
		for _, Item in ipairs(newFolder:GetChildren()) do

			local classNameCheck = Item:IsA("Accessory")

			if classNameCheck then

				local tagCheck = CollectionService:HasTag(Item, "Accessory")

				if addToTag and not tagCheck then
					CollectionService:AddTag(Item, "Accessory")
					print(Item.Name.." has been granted the 'Accessory' tag")
					
				elseif tagCheck and not addToTag then
					CollectionService:RemoveTag(Item, "Accessory")
					print(Item.Name.." no longer has the 'Accessory' tag")
				end
			end
		end

	else
		warn("'Welded Accessories' folder does not exist in the ServerStorage")
	end
end


local function updateAccessories(addToTag)
	
	local boolCheck = typeof(addToTag) == "boolean"
	
	if boolCheck then
		updateTag(addToTag)
		
	else
		warn("Value sent through is not a bool.\n 'true' or 'false' are the only allowed values for this function")
	end
end

updateAccessories(true)


------ Equipping Accessories Server Script ------

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")


local function instanceCheck(Accessory)
	
	local classNameCheck = Accessory:IsA("Accessory")
	
	if classNameCheck then
		for _, Item in ipairs(Accessory:GetDescendants()) do
			
			local clickDetector = Item:IsA("ClickDetector")
			local proximityPrompt = Item:IsA("ProximityPrompt")
			
			if clickDetector or proximityPrompt then
				return Item
			end
		end
	end
end




local function addAccessory(player, Accessory)
	local Character = player.Character or player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local accessoryCheck = Character:FindFirstChild(Accessory.Name)

	if Character and Humanoid and not accessoryCheck then
		
		-- Consider cloning the Accessory for certain use cases, instead
		
		local clone = Accessory:Clone()

		CollectionService:RemoveTag(clone, "Accessory")

		Humanoid:AddAccessory(clone)
		
		return clone

	elseif accessoryCheck then
		print(player.Name.." already has this Accessory!")
	end
end


local ClickDetectorConnections = {}
local TouchedEventConnections = {}
local ProximityPromptConnections = {}




local function updateAccessory(Accessory)
		
	local classNameCheck = Accessory:IsA("Accessory")
	local Handle = Accessory:FindFirstChild("Handle")
		
	if classNameCheck and Handle then
			
		local instanceCheck = instanceCheck(Accessory)
		
		if instanceCheck and instanceCheck.ClassName == "ClickDetector" then
			
			local function clickDetectorEvent(player)
				local successCheck = addAccessory(player, Accessory)

				if successCheck then
					local clickDetector = successCheck.Handle:FindFirstChildOfClass("ClickDetector")

					if clickDetector then
						clickDetector:Destroy()
					end
				end
			end
			
			ClickDetectorConnections[Accessory.Name] = instanceCheck.MouseClick:Connect(clickDetectorEvent)
			

		elseif instanceCheck and instanceCheck.ClassName == "ProximityPrompt" then
			
			local function proximityPromptEvent(player)
				local successCheck = addAccessory(player, Accessory)

				if successCheck then
					local ProximityPrompt = successCheck.Handle:FindFirstChildOfClass("ProximityPrompt")

					if ProximityPrompt then
						ProximityPrompt:Destroy()
					end
				end
			end
			
			ProximityPromptConnections[Accessory.Name] = instanceCheck.TriggerEnded:Connect(proximityPromptEvent)


		else
			
			local function touchedEvent(object)
				
				local player = Players:GetPlayerFromCharacter(object.Parent)

				if player then
					local successCheck = addAccessory(player, Accessory)

					if successCheck then
						local scriptCheck = successCheck.Handle:FindFirstChildOfClass("Script")

						if scriptCheck then
							scriptCheck:Destroy()
						end
					end

				else

					if TouchedEventConnections[Accessory.Name] then
						TouchedEventConnections[Accessory.Name]:Disconnect()
					end

					TouchedEventConnections[Accessory.Name] = Handle.Touched:Connect(touchedEvent)
				end
			end


			TouchedEventConnections[Accessory.Name] = Handle.Touched:Connect(touchedEvent)
		end
	end
end


local function disconnectEvents(Accessory)
	
	local ClickDetectorConnection = ClickDetectorConnections[Accessory.Name]
	local ProximityPromptConnection = ProximityPromptConnections[Accessory.Name]
	local TouchedEventConnection = TouchedEventConnections[Accessory.Name]
	
	
	if ClickDetectorConnection then
		warn("Disconnected ClickDetectorConnection from "..Accessory.Name)
		ClickDetectorConnection:Disconnect()
		
	elseif ProximityPromptConnection then
		warn("Disconnected ProximityPromptConnection from "..Accessory.Name)
		ProximityPromptConnection:Disconnect()
		
	elseif TouchedEventConnection then
		warn("Disconnected TouchedEventConnection from "..Accessory.Name)
		TouchedEventConnection:Disconnect()
	end
end




for _, Item in ipairs(CollectionService:GetTagged("Accessory")) do
	updateAccessory(Item)
end



CollectionService:GetInstanceAddedSignal("Accessory"):Connect(function(newItem)
	updateAccessory(newItem)
end)

CollectionService:GetInstanceRemovedSignal("Accessory"):Connect(function(oldItem)
	disconnectEvents(oldItem)
end)

--[[ 
This is Episode 31 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

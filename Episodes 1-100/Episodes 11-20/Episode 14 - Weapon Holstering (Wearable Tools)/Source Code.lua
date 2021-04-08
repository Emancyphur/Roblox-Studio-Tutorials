--[[

Episode 14 - Item Holstering/Wearable Tools
Tutorial Link: ( https://youtu.be/7_My5xBzQZ4 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Item Holstering System.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local Players = game:GetService("Players")

local ServerStorage = game:GetService("ServerStorage")
local Items = ServerStorage.Items

local HolsteringSystem = require(script.Parent.HolsteringModule)



local function ItemHolstering(player)
	
	player.CharacterAdded:Connect(function(Character)
		
		player.CharacterRemoving:Connect(function(char)
			char:Destroy()
		end)
		
		
		
		
		local Backpack = player:WaitForChild("Backpack")
		
		
		
		
		Character.ChildAdded:Connect(function(NewItem)
			
			if NewItem:IsA("Tool") then
				
				local AccessoryCheck = Character:FindFirstChild(NewItem.Name.."Accessory")
				
				if AccessoryCheck then
					HolsteringSystem.Holster(AccessoryCheck,1)
				
				elseif not AccessoryCheck then
					
					local ToolList = HolsteringSystem.GetToolList()
					
					if ToolList then
						
						local TableCheck = table.find(ToolList,NewItem.Name)
						local Accessories = Items:FindFirstChild("Accessories")
						
						if TableCheck and Accessories then
							
							local Accessory = Accessories:FindFirstChild(NewItem.Name.."Accessory")
							local Humanoid = Character:WaitForChild("Humanoid")
							
							if Accessory and Humanoid then
								
								local ClonedAccessory = Accessory:Clone()
								HolsteringSystem.Holster(ClonedAccessory,1,true,Humanoid)
							end
						end
					end
				end
			end
		end)
		
		
		
		
		
		local function ItemRemoved(OldItem,OldContainer)
			
			if OldItem:IsA("Tool") then
				
				local AccessoryCheck = Character:FindFirstChild(OldItem.Name.."Accessory")
				
				if AccessoryCheck and OldContainer == Backpack then
					if OldItem.Parent ~= Character then
						warn(OldItem.Name.." has left the Backpack and it's not in the Character. The accessory is being destroyed")
						AccessoryCheck:Destroy()
					end
					
					
				elseif AccessoryCheck and OldContainer == Character then
					if OldItem.Parent ~= Backpack then
						warn(OldItem.Name.." has left the Character and it's not in the Backpack. The accessory is being destroyed")
						AccessoryCheck:Destroy()
						
					elseif OldItem.Parent == Backpack then
						HolsteringSystem.Holster(AccessoryCheck,0)
					end
				end
			end
		end
		
		
		
		Character.ChildRemoved:Connect(function(OldItem)
			ItemRemoved(OldItem,Character)
		end)
		
		Backpack.ChildRemoved:Connect(function(OldItem)
			ItemRemoved(OldItem,Backpack)
		end)
		
		
		
	end)
end


for _,player in pairs(Players:GetPlayers()) do
	coroutine.wrap(ItemHolstering)(player)
end


Players.PlayerAdded:Connect(ItemHolstering)



------ ModuleScript ------

local ServerStorage = game:GetService("ServerStorage")
local Items = ServerStorage.Items



local ToolList = {}

local function UpdateItemList(NewItem)
	
	local ToolsFolder = Items:FindFirstChild("Tools")
	
	if ToolsFolder then
		
		if NewItem and not table.find(ToolList,NewItem.Name) then
			table.insert(ToolList,NewItem.Name)
			
		else
			
			for _,Tool in ipairs(ToolsFolder:GetChildren()) do
				
				if not table.find(ToolList,Tool.Name) then
					table.insert(ToolList,Tool.Name)
				end
			end
		end
	end
end

UpdateItemList()

Items.Tools.ChildAdded:Connect(function(NewItem)
	if NewItem:IsA("Tool") then
		UpdateItemList(NewItem)
	end
end)






local HolsterSystem = {}


function HolsterSystem.GetToolList()
	return ToolList
end


function HolsterSystem.Holster(Accessory,Transparency,AddToCharacter,Humanoid)
	
	local AccessoryCheck = typeof(Accessory) == "Instance" and Accessory:IsA("Accessory")
	local TransparencyCheck = typeof(Transparency) == "number" and Transparency >= 0 and Transparency <= 1
	
	if AccessoryCheck and TransparencyCheck then
		
		for _,Item in ipairs(Accessory:GetDescendants()) do
			if Item:IsA("BasePart") then
				Item.Transparency = Transparency
			end
		end
	end
	
	
	local AddToCharacterCheck = typeof(AddToCharacter) == "boolean" and AddToCharacter
	local HumanoidCheck = typeof(Humanoid) == "Instance" and Humanoid:IsA("Humanoid")
	
	if
		AccessoryCheck
		and AddToCharacterCheck
		and HumanoidCheck then
		
		Humanoid:AddAccessory(Accessory)
		
	end
end


return HolsterSystem

--[[ 
This is Episode 14 of the tutorial series that teaches you ROBLOX Studio fundamentals!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

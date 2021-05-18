--[[

Episode 31 - How to make Hats/Accessories
Tutorial Link: ( https://youtu.be/DmsbnwtaVi0 )

This is the non-annotated version of the script.
For comments that explain every line, please refer to the "Welding & Accessory Resources.rbxm" file in the folder that contains this Source Code

]]--

------ Server Script ------

local ServerStorage = game:GetService("ServerStorage")

local function applyWelds(Accessory)
	
	local Handle = Accessory.Handle
	Handle.Anchored = false
	
	for _, descendant in ipairs(Accessory:GetDescendants()) do
		
		
		if
			descendant:IsA("Weld")
			or descendant:IsA("ManualWeld")
			or descendant:IsA("WeldConstraint")
		then
			descendant:Destroy()
		end
		
		
		local descendantCheck = descendant:IsA("BasePart") and descendant.Name ~= "Handle"

		if descendantCheck then
			descendant.Anchored = false
			
			local WeldConstrant = Instance.new("WeldConstraint")
			WeldConstrant.Parent = Handle
			WeldConstrant.Part0 = Handle
			WeldConstrant.Part1 = descendant
		end
	end
	
	warn("Welding complete for "..Accessory.Name.."!")
end


local function setup()
	
	local originalFolder = ServerStorage:FindFirstChild("Original Accessories")
	local newFolder = ServerStorage:FindFirstChild("Welded Accessories")
	
	if not originalFolder then
		local originalAccessoriesFolder = Instance.new("Folder")
		originalAccessoriesFolder.Name = "Original Accessories"
		originalAccessoriesFolder.Parent = ServerStorage
		
		originalFolder = ServerStorage:FindFirstChild("Original Accessories")
	end
	
	if not newFolder then
		local newAccessoriesFolder = Instance.new("Folder")
		newAccessoriesFolder.Name = "Welded Accessories"
		newAccessoriesFolder.Parent = ServerStorage
		
		newFolder = ServerStorage:FindFirstChild("Welded Accessories")
	end
	
	
	for _, item in ipairs(ServerStorage:GetChildren()) do
		local accessoryCheck = item:IsA("Accessory")
		local handleCheck = item:FindFirstChild("Handle")
		
		if accessoryCheck and handleCheck then
			
			local clonedAccessory = item:Clone()
			clonedAccessory.Parent = newFolder
			item.Parent = originalFolder
			
			applyWelds(clonedAccessory)
		end
	end
	
end

setup()

--[[ 
This is Episode 31 of the Roblox Studio Tutorial Series!

The full list of instructional scripts from this series can be
found through the ROBLOX group that posted this model.
]]--

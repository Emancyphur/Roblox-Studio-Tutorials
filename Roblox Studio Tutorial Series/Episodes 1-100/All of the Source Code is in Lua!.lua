(More specifically, Luau, which you can find from the following Roblox GitHub page):

https://roblox.github.io/luau/

------ The "Code" below is just for funsies :) ------

local GitHub = Internet:GetWebsite("GitHub")

local Profile = GitHub["Asians-FTW"]
local MyRepository = Profile["ROBLOX-Studio-Tutorials"]

local EpisodeList = MyRepository["Episodes 1-100"]
local SourceCodeNote = EpisodeList["All of the Source Code is in Lua!.lua"]

local function hi(Reader)
    print("Hi there! Thanks for reading this "..Reader.Name..". I hope you are having a fantastic day :)")
    
    if Reader.DayQuality ~= "Good" or not Reader.DayQuality >= "Good" then
       print("I hope everything gets better soon, no matter what it is. Take every day of life one step at a time -- the rhythm will lead the way.")
   end
end

SourceCodeNote.ReaderAdded:Connect(hi)
SourceCodeNote.ReaderRemoving:Connect(function(Reader)
    print("Thanks for stopping by "..Reader.Name.."! I hope that I have been able to help :)")
end)

--[[

This is the GitHub that contains the contents from Asians FTW's ROBLOX Studio tutorial series!
Thanks for reading!

- Asians FTW

]]--

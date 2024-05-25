(More specifically, Luau, which you can find from the following Roblox GitHub page):

https://roblox.github.io/luau/

------ The "Code" below is just for funsies :) ------

local GitHub = Internet:GetWebsite("GitHub")

local Profile = GitHub["Emancyphur"]
local MyRepository = Profile["Roblox-Studio-Tutorials"]

local ChosenPlaylist = MyRepository["Roblox Studio Tutorial Series"]
local EpisodeList = ChosenPlaylist["Episodes 1-100"]
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

This is the GitHub Repository that contains the contents from Emancyphur's Roblox Studio Tutorial Series!
Thanks for reading!

- Emancyphur

]]--

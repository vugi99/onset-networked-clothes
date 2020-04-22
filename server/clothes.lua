

local defaultClothesPreset = nil
local defaultCustomClothes = nil

local checked = {}
local timers = {}

local function IsCustomValid(customtbl)
   if customtbl then
      local avalisgood
      for k,v in pairs(customtbl) do
         if v ~= nil then
            return true
         end
      end
   end
   return false
end

function SetPlayerNetworkedClothingPreset(ply,presetnb)
   if presetnb then
      local presetnb = tonumber(presetnb)
      local PlayerClothes = {}
      PlayerClothes.type = "preset"
      PlayerClothes.clothes = presetnb
      SetPlayerPropertyValue(ply, "NetworkedClothes", PlayerClothes,true)
      return true
   end
   return false
end

function SetPlayerNetworkedCustomClothes(ply,customclothingtbl)
   if IsCustomValid(customclothingtbl) then
      local PlayerClothes = {}
      PlayerClothes.type = "custom"
      PlayerClothes.clothes = customclothingtbl
      SetPlayerPropertyValue(ply, "NetworkedClothes", PlayerClothes,true)
      return true
   end
   return false
end

local function Spawntimer(ply,spawnx,spawny,spawnz,spawnh)
    local x,y,z = GetPlayerLocation(ply)
    local h = GetPlayerHeading(ply)
    if x ~= spawnx or y ~= spawny or z ~= spawnz or spawnh ~= h then
       if defaultClothesPreset ~= nil then
          SetPlayerNetworkedClothingPreset(ply,defaultClothesPreset)
       elseif IsCustomValid(defaultCustomClothes) then
          SetPlayerNetworkedCustomClothes(ply,defaultCustomClothes)
       end
       for i,v in ipairs(timers) do
          if v.ply == ply then
             DestroyTimer(v.id)
             table.remove(timers,i)
          end
       end
    end
end

local function isChecked(ply)
   for i,v in ipairs(checked) do
      if v == ply then
         return true
      end
   end
   return false
end

AddEvent("OnPlayerSpawn",function(ply)
    if not isChecked(ply) then
       table.insert(checked,ply)
       local spawnx,spawny,spawnz = GetPlayerLocation(ply)
       local spawnh = GetPlayerHeading(ply)
       local timer = CreateTimer(Spawntimer,80,ply,spawnx,spawny,spawnz,spawnh) -- wait until the player has fully loaded
       local tbl = {}
       tbl.ply = ply 
       tbl.id = timer
       table.insert(timers,tbl)
    end
end)

AddEvent("OnPlayerQuit",function(ply)
    for i,v in ipairs(checked) do
       if v == ply then
          table.remove(checked,i)
       end
    end
end)
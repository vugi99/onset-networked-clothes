

local defaultClothesPreset = nil
local defaultCustomClothes = nil

local ready = {}
local checked = {}
local timers = {}
local pendingclothes = {}

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

local function isReady(ply)
   for i,v in ipairs(ready) do
      if v == ply then
         return true
      end
   end
   return false
end

local function AddPendingClothes(ply,PlayerClothes)
   for i,v in ipairs(pendingclothes) do
      if v.ply == ply then
         table.remove(pendingclothes,i)
         break
      end
   end
   local Pending = {}
   Pending.ply = ply
   Pending.Clothes = PlayerClothes
   table.insert(pendingclothes,Pending)
end

local function SetPending(ply)
   for i,v in ipairs(pendingclothes) do
      if v.ply == ply then
         SetPlayerPropertyValue(ply, "NetworkedClothes", v.Clothes,true)
         table.remove(pendingclothes,i)
         break
      end
   end
end

function SetPlayerNetworkedClothingPreset(ply,presetnb)
   if (presetnb and IsValidPlayer(ply)) then
      local presetnb = tonumber(presetnb)
      local PlayerClothes = {}
      PlayerClothes.type = "preset"
      PlayerClothes.clothes = presetnb
      if isReady(ply) then
         SetPlayerPropertyValue(ply, "NetworkedClothes", PlayerClothes,true)
      else
          AddPendingClothes(ply,PlayerClothes)
      end
      return true
   end
   return false
end

function SetPlayerNetworkedCustomClothes(ply,customclothingtbl)
   if (IsCustomValid(customclothingtbl) and IsValidPlayer(ply)) then
      local PlayerClothes = {}
      PlayerClothes.type = "custom"
      PlayerClothes.clothes = customclothingtbl
      if isReady(ply) then
         SetPlayerPropertyValue(ply, "NetworkedClothes", PlayerClothes,true)
      else
         AddPendingClothes(ply,PlayerClothes)
      end
      return true
   end
   return false
end

function SetNPCNetworkedClothingPreset(npc,presetnb)
   if (presetnb and IsValidNPC(npc)) then
      local presetnb = tonumber(presetnb)
      local NPCClothes = {}
      NPCClothes.type = "preset"
      NPCClothes.clothes = presetnb
      SetNPCPropertyValue(npc, "NetworkedClothes", NPCClothes,true)
      return true
   end
   return false
end

function SetNPCNetworkedCustomClothes(npc,customclothingtbl)
   if (IsCustomValid(customclothingtbl) and IsValidNPC(npc)) then
      local NPCClothes = {}
      NPCClothes.type = "custom"
      NPCClothes.clothes = customclothingtbl
      SetNPCPropertyValue(npc, "NetworkedClothes", NPCClothes,true)
      return true
   end
   return false
end

local function Spawntimer(ply,spawnx,spawny,spawnz,spawnh)
    local x,y,z = GetPlayerLocation(ply)
    local h = GetPlayerHeading(ply)
    if (x ~= spawnx or y ~= spawny or z ~= spawnz or spawnh ~= h) then
       if defaultClothesPreset ~= nil then
          SetPlayerNetworkedClothingPreset(ply,defaultClothesPreset)
       elseif IsCustomValid(defaultCustomClothes) then
          SetPlayerNetworkedCustomClothes(ply,defaultCustomClothes)
       end
       table.insert(ready,ply)
       for i,v in ipairs(timers) do
          if v.ply == ply then
             DestroyTimer(v.id)
             table.remove(timers,i)
          end
       end
       SetPending(ply)
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
       local timer = CreateTimer(Spawntimer,80,ply,spawnx,spawny,spawnz,spawnh) -- wait until the player has fully loaded or it won't work as expected for him
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
    for i,v in ipairs(ready) do
      if v == ply then
         table.remove(ready,i)
      end
   end
end)
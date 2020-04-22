
local function IsValidPlayerEvenLocal(ply)
   if (IsValidPlayer(ply) or GetPlayerId() == ply) then
      return true
   else
      return false
   end
end

local function customlogic(sk,part)
   if part[1] == nil then
      sk:SetSkeletalMesh(nil)
   elseif part[1] ~= false then
      sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(part[1]))
   end
   if part[2] then
      sk:SetRelativeScale3D(FVector(part[2][1], part[2][2], part[2][3]))
   end
   if part[3] then
      sk:SetRelativeRotation(FRotator(part[3][1], part[3][2], part[3][3]))
   end
   if part[4] then
      sk:SetRelativeLocation(FVector(part[4][1], part[4][2], part[4][3]))
   end
   if part[5] then
      if (part[5][1] and part[5][2]) then
         sk:SetMaterial(part[5][2], UMaterialInterface.LoadFromAsset(part[5][1]))
      end
   end
end

local function SetClothes(ply,plyclothestbl)
   if plyclothestbl then
      if plyclothestbl.type ~= nil then
         if plyclothestbl.type == "preset" then
           SetPlayerClothingPreset(ply, plyclothestbl.clothes)
         elseif plyclothestbl.type == "custom" then
            local clothes = plyclothestbl.clothes
            if clothes.body then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Body")
               customlogic(sk,clothes.body)
            end
            if clothes.clothing0 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing0")
               customlogic(sk,clothes.clothing0)
            end
            if clothes.clothing1 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing1")
               customlogic(sk,clothes.clothing1)
            end
            if clothes.clothing2 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing2")
               customlogic(sk,clothes.clothing2)
            end
            if clothes.clothing3 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing3")
               customlogic(sk,clothes.clothing3)
            end
            if clothes.clothing4 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing4")
               customlogic(sk,clothes.clothing4)
            end
            if clothes.clothing5 then
               local sk = GetPlayerSkeletalMeshComponent(ply, "Clothing5")
               customlogic(sk,clothes.clothing5)
            end
         end
      end
   end
end

AddEvent("OnPlayerNetworkUpdatePropertyValue",function(ply,pname,pval)
    if (IsValidPlayerEvenLocal(ply) and pname == "NetworkedClothes") then
       SetClothes(ply,pval)
    end
end)

AddEvent("OnPlayerStreamIn",function(ply)
   SetClothes(ply,GetPlayerPropertyValue(ply, "NetworkedClothes"))
end)

AddEvent("OnPlayerSpawn",function()
   SetClothes(GetPlayerId(),GetPlayerPropertyValue(GetPlayerId(), "NetworkedClothes"))
end)
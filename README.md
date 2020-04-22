# onset-networked-clothes

#### Informations
* This package can be used to set networked clothes

#### Config
* if you want to put default clothes to players (when they spawn) you can use defaultClothesPreset or defaultCustomClothes variables at the start of clothes.lua
* defaultClothesPreset = preset id
* defaultCustomClothes = Custom Clothes Table

#### Custom Clothes Table Structure
* a Custom Clothes Table Should be like that
```
{
    body = false,
    clothing0 = false,
    clothing1 = false,
    clothing2 = false,
    clothing3 = false,
    clothing4 = false,
    clothing5 = false
}
```
* for each part you can do :
```
-- false = don't change , nil = destroy thing (you can only put nil at skeletal mesh path)
{
   nil, -- skeletal mesh path
   {1,1,1}, -- relative scale or put false
  {0,0,0}, -- relative rotation or put false 
   false, -- relative location or put false
   false -- {material path , material slot} or put false
} 
```
* Example :
```
{
   body = {"/Game/CharacterModels/SkeletalMesh/BodyMerged/HZN_CH3D_Normal04_LPR",{1.3,1.3,1.3},false,false,{"/Game/CharacterModels/Materials/HZN_Materials/M_HZN_Body_NoShoesLegsTorso",0}},
   clothing0 = {"/Game/CharacterModels/SkeletalMesh/HZN_CH3D_Hair_Business_LP"},
   clothing1 = {"/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalShirt_LPR"},
   clothing2 = {"/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_FormalPants_LPR"},
   clothing3 = {"/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_BusinessShoes_LPR"},
   clothing4 = {"/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_TacticalGlasses_LPR",false,false,{0.0, 0.0, 3.5}}
}
```
#### Developers
* Get Networked clothes
```
-- server,client
GetPlayerPropertyValue(player, "NetworkedClothes")
-- returns a table
-- returned tables can be like this
--[[
{
   type = "preset",
   clothes = presetid
}
{
   type = "custom",
   clothes = Custom Clothes Table
}
]]--
```
* You need to include onset-networked-clothes files to your package to use functions
* Set Networked Clothing Preset
```
-- server
SetPlayerNetworkedClothingPreset(player,presetid)
return true on success , false on error
```
* Set Networked Custom Clothes
```
-- server
SetPlayerNetworkedCustomClothes(player,Custom Clothes Table)
return true on success , false on error
```

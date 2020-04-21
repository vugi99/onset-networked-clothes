# onset-networked-clothes

#### Informations
* This package can be used to set networked clothes

#### Config
* if you want to put default clothes to players (when they spawn) you can use defaultClothesPreset or defaultCustomClothes variables at the start of clothes.lua
* defaultClothesPreset = preset id
* defaultCustomClothes = Custom Clothes Table

#### Custom Clothes Table Structure
* a Custom Clothes Table must be at least
```
{
    body = false,
    clothing0 = false,
    clothing1 = false,
    clothing2 = false,  -- never put nil for them or it won't work
    clothing3 = false,
    clothing4 = false,
    clothing5 = false
}
```
* for each part you can do :
```
-- false = don't change , nil = destroy thing (you can only put nil at skeletal mesh path)
{nil, -- skeletal mesh path
{1,1,1}, -- relative scale or put false
{0,0,0}, -- relative rotation or put false 
false, -- relative location or put false
false} -- {material path , material slot} or put false
```
* Example :
```
{
    body = {"/Game/CharacterModels/Female/Meshes/SK_Female01"},
    clothing0 = {"/Game/CharacterModels/Female/Meshes/SK_Hair01"},
    clothing1 = {"/Game/CharacterModels/Female/Meshes/HZN_CH3D_Prison-Guard_LPR"},
    clothing2 = {"/Game/CharacterModels/Female/Meshes/HZN_Outfit_Piece_DenimPants_LPR"},
    clothing3 = {"/Game/CharacterModels/Female/Meshes/SK_Shoes01"},
    clothing4 = false,
    clothing5 = false
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
   type = "preset"
   clothes = presetid
}
{
   type = "custom"
   clothes = Custom Clothes Table
}
]]--
```
* You need to include onset-networked-clothes files to your package to use functions
* Set Networked Clothing Preset
```
--server
SetPlayerNetworkedClothingPreset(player,presetid)
return true on success , false on error
```
* Set Networked Custom Clothes
```
--server
SetPlayerNetworkedCustomClothes(player,Custom Clothes Table)
return true on success , false on error
```

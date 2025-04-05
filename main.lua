-- @description TaalTools Main Menu
-- @author Taal
-- @version 1.0
-- @about
--   Collection of tools for REAPER
-- @provides
--   [main] main.lua

package.path = package.path .. ";" .. reaper.GetResourcePath() .. "/Scripts/TaalTools/lib/?.lua"
local utils = require("utils")

local function showMenu()
  local menu = "TaalTools Menu\n"
  menu = menu .. "1. Drum Multichannel Track Splitter\n"
  menu = menu .. "2. Bus Creator"
  
  local choice = reaper.ShowMessageBox(menu, "TaalTools", 1)
  if choice == 1 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/scripts/Drums_MultiChannelSplitter.lua")
  elseif choice == 2 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/scripts/Bus_Creator.lua")
  end
end

showMenu()

-- @description TaalTools Main Menu
-- @author Taal
-- @version 1.0
-- @about
--   Collection of tools for REAPER
-- @provides
--   [main] main.lua

package.path = package.path .. ";" .. reaper.GetResourcePath() .. "lib/?.lua"
local utils = require("utils")

local function showMenu()
  local menu = "TaalTools Menu\n"
  menu = menu .. "1. Drum Multichannel Track Splitter\n"
  menu = menu .. "2. Bus Creator\n"
  menu = menu .. "3. Volume Up (0.5dB)\n"
  menu = menu .. "4. Volume Down (0.5dB)\n"
  menu = menu .. "5. MIDI Trigger"
  
  local choice = reaper.ShowMessageBox(menu, "TaalTools", 1)
  if choice == 1 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/scripts/Drums_MultiChannelSplitter.lua")
  elseif choice == 2 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/scripts/Bus_Creator.lua")
  elseif choice == 3 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/Scripts/VolumeUp.lua")
  elseif choice == 4 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/Scripts/VolumeDown.lua")
  elseif choice == 5 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/scripts/MIDI_Trigger.lua")
  end
end

showMenu()

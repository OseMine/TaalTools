-- @description TaalTools Main Menu
-- @author Taal
-- @version 1.0
-- @about
--   Collection of tools for REAPER
-- @provides
--   [main] main.lua

function msg(m)
  reaper.ShowConsoleMsg(tostring(m) .. "\n")
end

local function showMenu()
  local menu = "TaalTools Menu\n"
  menu = menu .. "1. Drum Multichannel Track Splitter"
  
  local choice = reaper.ShowMessageBox(menu, "TaalTools", 1)
  if choice == 1 then
    dofile(reaper.GetResourcePath() .. "/Scripts/TaalTools/Drums_MultiChannelSplitter.lua")
  end
end

showMenu()

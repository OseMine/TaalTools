-- @description TaalTools - Drum Trigger (Crash 2)
-- @author Taal
-- @version 1.0

local info = debug.getinfo(1,'S').source:match[[^@?(.*[\/])[^\/]-$]]
package.path = package.path .. ";" .. info .. "?.lua"
local midi_utils = require("midi_utils")

function Main()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  midi_utils.trigger_note(57) -- Crash 2 note
end

if not preset_file_init then
  local _, file, sec, cmd = reaper.get_action_context()
  preset_file_init = true
  Main()
end
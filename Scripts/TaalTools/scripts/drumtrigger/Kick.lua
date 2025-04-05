-- @description TaalTools - Drum Trigger (Kick)
-- @description TaalTools - Drum Trigger (Kick)
-- @version 1.0

package.path = package.path .. ";" .. reaper.GetResourcePath() .. "/Scripts/TaalTools/lib/?.lua"
local midi_utils = require("midi_utils")

function Main()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  midi_utils.trigger_note(36) -- Kick drum note
end

if not preset_file_init then
  local _, file, sec, cmd = reaper.get_action_context()
  preset_file_init = true
  Main()
end
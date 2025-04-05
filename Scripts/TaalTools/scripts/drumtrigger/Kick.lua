-- @description TaalTools - Drum Trigger (Kick)
-- @author Taal
-- @version 1.0

local info = debug.getinfo(1, "S")
local script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
package.path = package.path .. ";" .. script_path .. "../../lib/?.lua"
local midi_utils = require("midi_utils")

function Main()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  reaper.StuffMIDIMessage(0, 0x90, 36, 127) -- Note On
  midi_utils.sleep(10) -- Wait 10ms
  reaper.StuffMIDIMessage(0, 0x80, 36, 0) -- Note Off
end

if not preset_file_init then
  local _, file, sec, cmd = reaper.get_action_context()
  preset_file_init = true
  Main()
end
-- @description TaalTools - Drum Trigger (Kick)
-- @author Taal
-- @version 1.0

function Main()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  -- Send MIDI note for Kick (note 36)
  reaper.StuffMIDIMessage(0, 0x90, 36, 127) -- Note On
  reaper.defer(function() 
    reaper.StuffMIDIMessage(0, 0x80, 36, 0) -- Note Off
  end)
end

if not preset_file_init then
  local _, file, sec, cmd = reaper.get_action_context()
  preset_file_init = true
  Main()
end

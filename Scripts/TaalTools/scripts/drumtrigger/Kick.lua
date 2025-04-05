-- @description TaalTools - Drum Trigger (Kick)
-- @author Taal
-- @version 1.0
-- @about
--   Triggers MIDI note for Kick Drum (MOD Drum)

function triggerKick()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  -- Send MIDI note for Kick (note 36)
  reaper.StuffMIDIMessage(0, 0x90, 36, 127)
  reaper.Sleep(10)  
  reaper.StuffMIDIMessage(0, 0x80, 36, 0)
end

triggerKick()

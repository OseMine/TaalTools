-- @description TaalTools - Drum Trigger (Splash 3)
-- @author Taal
-- @version 1.0

function triggerMIDINote()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  -- Send MIDI note for Splash (note 55)
  reaper.StuffMIDIMessage(0, 0x90, 55, 127)
  reaper.Sleep(10)
  reaper.StuffMIDIMessage(0, 0x80, 55, 0)
end

triggerMIDINote()

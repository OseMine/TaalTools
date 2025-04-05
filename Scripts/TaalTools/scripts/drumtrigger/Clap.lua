-- @description TaalTools - Drum Trigger (Clap)
-- @author Taal
-- @version 1.0

function triggerMIDINote()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  -- Send MIDI note for Clap (note 39)
  reaper.StuffMIDIMessage(0, 0x90, 39, 127)
  reaper.Sleep(10)
  reaper.StuffMIDIMessage(0, 0x80, 39, 0)
end

triggerMIDINote()

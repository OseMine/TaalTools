-- @description TaalTools - MIDI Note Trigger
-- @author Taal
-- @version 1.0
-- @about
--   Triggers MIDI notes on the selected track. Perfect for use with Stream Deck and OSC.

function triggerMIDINote(noteNum)
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end

  -- Get track MIDI input
  local midiInput = reaper.CreateTrackSend(nil, track)
  
  -- Send MIDI note on
  reaper.StuffMIDIMessage(0, 0x90, noteNum, 127)
  
  -- Wait a tiny bit
  reaper.Sleep(10)
  
  -- Send MIDI note off
  reaper.StuffMIDIMessage(0, 0x80, noteNum, 0)
end

-- Default trigger for testing (middle C = note 60)
-- When using with Stream Deck, bind different note numbers to different buttons
triggerMIDINote(60)

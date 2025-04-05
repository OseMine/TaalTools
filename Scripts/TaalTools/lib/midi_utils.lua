local midi_utils = {}

function midi_utils.sleep(duration)
  local start = os.time()
  while os.time() - start < duration/1000 do end
end

function midi_utils.trigger_note(note_num)
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then return end
  
  -- Note On
  reaper.StuffMIDIMessage(0, 0x90, note_num, 127)
  
  -- Register Note Off for next defer cycle
  reaper.defer(function()
    reaper.StuffMIDIMessage(0, 0x80, note_num, 0)
  end)
end

return midi_utils

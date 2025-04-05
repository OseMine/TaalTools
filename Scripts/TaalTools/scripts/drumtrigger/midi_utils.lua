local midi_utils = {}

function midi_utils.trigger_note(note_num)
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then return end
  
  reaper.StuffMIDIMessage(0, 0x90, note_num, 127) -- Note On
  reaper.defer(function()
    reaper.StuffMIDIMessage(0, 0x80, note_num, 0) -- Note Off
  end)
end

return midi_utils

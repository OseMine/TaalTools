-- @description TaalTools - Drum Trigger (Tom 3)
-- @author Taal
-- @version 1.0
note = 43

function triggerDrum()
  -- Add your drum trigger logic here
  -- This function will be called to trigger the drum sound
end

function onMidiEvent(event)
  if event.type == "note_on" and event.note == note then
    triggerDrum()
  end
end

-- Register the MIDI event handler
reaper.MIDIEditor_OnCommand(reaper.MIDIEditor_GetActive(), onMidiEvent)

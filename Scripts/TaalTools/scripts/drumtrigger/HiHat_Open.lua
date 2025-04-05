-- @description TaalTools - Drum Trigger (Closed HiHat)
-- @author Taal
-- @version 1.0

function Main()
    local track = reaper.GetSelectedTrack(0, 0)
    if not track then
      reaper.ShowMessageBox("Please select a track!", "Error", 0)
      return
    end
    
    -- Send MIDI note for Closed HiHat (note 42)
    reaper.StuffMIDIMessage(0, 0x90, 46, 127) -- Note On
  reaper.Sleep(10) -- Wait 10ms
    reaper.StuffMIDIMessage(0, 0x80, 46, 0) -- Note Off
  end
  
  if not preset_file_init then
    local _, file, sec, cmd = reaper.get_action_context()
    preset_file_init = true
    Main()
  end
  
-- @description TaalTools - Drum Trigger (Tom 2)
-- @author Taal
-- @version 1.0

function Main()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
    return
  end
  
  reaper.StuffMIDIMessage(0, 0x90, 45, 127) -- Note On
  reaper.Sleep(10) -- Wait 10ms
  reaper.StuffMIDIMessage(0, 0x80, 45, 0) -- Note Off
end

if not preset_file_init then
  local _, file, sec, cmd = reaper.get_action_context()
  preset_file_init = true
  Main()
end

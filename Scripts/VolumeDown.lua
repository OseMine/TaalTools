-- @description TaalTools - Decrease Volume Slightly
-- @author Taal
-- @version 1.0
-- @about
--   Decreases selected track volume by 0.5dB

local function adjustVolume()
  -- Get selected track count
  local numSelectedTracks = reaper.CountSelectedTracks(0)
  
  if numSelectedTracks == 0 then
    reaper.ShowMessageBox("No track selected!", "Error", 0)
    return
  end
  
  reaper.Undo_BeginBlock()
  
  -- Process all selected tracks
  for i = 0, numSelectedTracks - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    local currentVol = reaper.GetMediaTrackInfo_Value(track, "D_VOL")
    local newVol = currentVol * 10^(-0.5/20) -- Decrease by 0.5dB
    reaper.SetMediaTrackInfo_Value(track, "D_VOL", newVol)
  end
  
  reaper.Undo_EndBlock("Decrease Volume Slightly", -1)
  reaper.UpdateArrange()
end

adjustVolume()

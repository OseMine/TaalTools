-- @description TaalTools - Bus Creator
-- @author Taal
-- @version 1.0
-- @about
--   Creates a bus track and routes selected tracks to it

function createBusForSelectedTracks()
    local numSelectedTracks = reaper.CountSelectedTracks(0)
    
    if numSelectedTracks == 0 then
        reaper.ShowMessageBox("Please select at least one track!", "Error", 0)
        return
    end
    
    reaper.Undo_BeginBlock()
    
    -- Create new bus track at the top
    reaper.InsertTrackAtIndex(0, true)
    local busTrack = reaper.GetTrack(0, 0)
    reaper.GetSetMediaTrackInfo_String(busTrack, "P_NAME", "BUS", true)
    
    -- Process each selected track
    for i = 0, numSelectedTracks - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        
        -- Disable Master/Parent Send
        reaper.SetMediaTrackInfo_Value(track, "B_MAINSEND", 0)
        
        -- Create send to bus track
        local sendIdx = reaper.CreateTrackSend(track, busTrack)
        
        -- Set send to channels 1/2
        reaper.SetTrackSendInfo_Value(track, 0, sendIdx, "I_SRCCHAN", 0)
        reaper.SetTrackSendInfo_Value(track, 0, sendIdx, "I_DSTCHAN", 0)
        reaper.SetTrackSendInfo_Value(track, 0, sendIdx, "D_VOL", 1.0)
    end
    
    reaper.Undo_EndBlock("Create bus track and route selected tracks", -1)
end

createBusForSelectedTracks()

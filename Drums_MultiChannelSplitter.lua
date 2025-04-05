-- @description TaalTools - Drum Multichannel Track Splitter
-- @author Taal
-- @version 1.0
-- @about
--   # Drum Multichannel Track Splitter
--   Creates 15 stereo tracks from a multichannel drum recording with proper naming, coloring and routing.
--   Supports standard drum recording setup with channels 3-32.
-- @changelog
--   - Initial release
-- @provides
--   [script] ./Drums_MultiChannelSplitter.lua
-- @link
--   Forum Thread https://forum.cockos.com/showthread.php?t=xxx

-- This script creates 15 new stereo tracks and routes audio from the currently selected track.

-- Define color conversion function
local function hexToReaperColor(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1,2), 16)
    local g = tonumber(hex:sub(3,4), 16)
    local b = tonumber(hex:sub(5,6), 16)
    return reaper.ColorToNative(r, g, b)|0x1000000
end

-- Define drum channel names and colors
local drumNames = {
  "Kick",           -- 3-4 #ee65cb
  "Snare",          -- 5-6 #f3d161
  "Tom 1",          -- 7-8 #54d362
  "Tom 2",          -- 9-10 #54d362
  "Tom 3",          -- 11-12 #54d362
  "Floor Tom 1",    -- 13-14 #54d362
  "Floor Tom 2",    -- 15-16 #54d362
  "HiHat",          -- 17-18 #00b6f1
  "Ride",           -- 19-20 #00b6f1
  "Crash",          -- 21-22 #00b6f1
  "Splash",         -- 23-24 #00b6f1
  "China",          -- 25-26 #00b6f1
  "Extra",          -- 27-28 #f3d161
  "OH",             -- 29-30 #1edfad
  "Room"            -- 31-32 #1edfad
}

local drumColors = {
    "#ee65cb",  -- Kick
    "#f3d161",  -- Snare
    "#54d362",  -- Tom 1
    "#54d362",  -- Tom 2
    "#54d362",  -- Tom 3
    "#54d362",  -- Floor Tom 1
    "#54d362",  -- Floor Tom 2
    "#00b6f1",  -- HiHat
    "#00b6f1",  -- Ride
    "#00b6f1",  -- Crash
    "#00b6f1",  -- Splash
    "#00b6f1",  -- China
    "#f3d161",  -- Extra
    "#1edfad",  -- OH
    "#1edfad"   -- Room
}

-- Get the selected track
local selectedTrack = reaper.GetSelectedTrack(0, 0)
if not selectedTrack then
  reaper.ShowMessageBox("No track selected!", "Error", 0)
  return
end

-- First set the source track to have enough channels
reaper.SetMediaTrackInfo_Value(selectedTrack, "I_NCHAN", 32)

-- Disable Master/Parent Send for source track
reaper.SetMediaTrackInfo_Value(selectedTrack, "B_MAINSEND", 0)

-- Number of new tracks to be created
local numNewTracks = 15

-- The source track (which provides the audio) has channels from 3 to 32 in stereo pairs
local firstOutputChannel = 3
local lastOutputChannel = 32

-- Check if the selected track has enough channels
local trackChannels = reaper.GetMediaTrackInfo_Value(selectedTrack, "I_NCHAN")
if trackChannels < 32 then
  reaper.ShowMessageBox("The source track doesn't have enough channels (minimum 32 channels required).", "Error", 0)
  return
end

-- Create 15 new stereo tracks and route the channels correctly
for i = 1, numNewTracks do
  -- Create new track
  reaper.InsertTrackAtIndex(reaper.CountTracks(0), true)
  local newTrack = reaper.GetTrack(0, reaper.CountTracks(0) - 1)

  -- Set new track to stereo
  reaper.SetMediaTrackInfo_Value(newTrack, "I_RECINPUT", 3) -- Enable stereo channels
  reaper.SetMediaTrackInfo_Value(newTrack, "I_NCHAN", 2) -- Set track to stereo (2 channels)

  -- Disable MIDI on new track
  reaper.SetMediaTrackInfo_Value(newTrack, "I_MIDIHWOUT", -1)
  reaper.SetMediaTrackInfo_Value(newTrack, "I_PERFFLAGS", 1)

  -- Calculate the correct channels for routing (stereo pair)
  local startChannel = firstOutputChannel + (i - 1) * 2
  local endChannel = startChannel + 1

  -- Audio from the source track
  local sendIndex = reaper.CreateTrackSend(selectedTrack, newTrack)
  
  -- Set the routing of the channels correctly for the send
  reaper.SetMediaTrackInfo_Value(selectedTrack, "I_NCHAN", 32)  -- ensure source has 32 channels
  reaper.SetMediaTrackInfo_Value(newTrack, "I_NCHAN", 2)  -- ensure destination is stereo
  
  -- Set up the routing (using 0-based channel numbers)
  local sourceStartChan = startChannel - 1  -- converts to 0-based channel number
  reaper.SetTrackSendInfo_Value(selectedTrack, 0, sendIndex, "I_SRCCHAN", sourceStartChan)
  reaper.SetTrackSendInfo_Value(selectedTrack, 0, sendIndex, "I_DSTCHAN", 0)
  
  -- Set volume and mode
  reaper.SetTrackSendInfo_Value(selectedTrack, 0, sendIndex, "D_VOL", 1.0)
  reaper.SetTrackSendInfo_Value(selectedTrack, 0, sendIndex, "I_SENDMODE", 0)
  
  -- Name and color the new track
  reaper.GetSetMediaTrackInfo_String(newTrack, "P_NAME", drumNames[i], true)
  reaper.SetTrackColor(newTrack, hexToReaperColor(drumColors[i]))
end

reaper.Undo_EndBlock("Create 15 new stereo tracks and route", -1)
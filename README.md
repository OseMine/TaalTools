# TaalTools

A collection of tools for REAPER.

## Installation

1. Install [ReaPack](https://reapack.com/)
2. Add this repository to ReaPack:
   - Extensions > ReaPack > Import repositories...
   - Paste URL: 
   ```
   https://raw.githubusercontent.com/OseMine/TaalTools/main/index.xml
   ```
3. Install TaalTools:
   - Extensions > ReaPack > Browse packages
   - Find "TaalTools" and install

## Tools

### Drums MultiChannel Splitter
Creates 15 stereo tracks from a multichannel drum recording with proper naming, coloring and routing.
Supports standard drum recording setup with channels 3-32.
Script name: `Drums_MultiChannelSplitter.lua`

### Bus Creator
Creates a new bus track and automatically routes all selected tracks to it. The selected tracks will have their master/parent send disabled and their channels 1/2 routed to the bus track.
Script name: `Bus_Creator.lua`

### Volume Up
Increases the volume of selected tracks by 0.5dB. Perfect for fine-tuning track volumes.
Script name: `VolumeUp.lua`

### Volume Down
Decreases the volume of selected tracks by 0.5dB. Perfect for fine-tuning track volumes.
Script name: `VolumeDown.lua`

### MIDI Trigger
Sends MIDI notes to the selected track. Perfect for creating custom drum pads with Stream Deck and OSC.
Script name: `MIDI_Trigger.lua`

### Formula Synthesizer
A JSFX synthesizer that generates sound based on mathematical formulas. Supports custom formulas and MIDI input.
Effect name: `Formula_Synthesizer.jsfx`

## Links

- Repository: [https://github.com/OseMine/TaalTools](https://github.com/OseMine/TaalTools)
- ReaPack URL: `https://raw.githubusercontent.com/OseMine/TaalTools/main/index.xml`

## License

MIT License

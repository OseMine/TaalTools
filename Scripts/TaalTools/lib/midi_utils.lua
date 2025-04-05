local midi_utils = {}

function midi_utils.sleep(duration)
  local start = os.time()
  while os.time() - start < duration/1000 do end
end

return midi_utils

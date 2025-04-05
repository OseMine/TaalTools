local utils = {}

function utils.msg(m)
  reaper.ShowConsoleMsg(tostring(m) .. "\n")
end

return utils

local function generateModeTag(fileLoc)
  -- get current neovim mode
  local mode = vim.api.nvim_get_mode().mode
  local file = io.open(fileLoc, "w")
  if file == nil then
    return
  end
  file:write("tag(): user.nvim-mode-" .. mode .. "\n")
  file:close()
end

local function clearModeTag(fileLoc)
  local file = io.open(fileLoc, "w")
  if file == nil then
    return
  end
  file:write("")
  file:close()
end

return {
  generate = generateModeTag,
  clear = clearModeTag,
}

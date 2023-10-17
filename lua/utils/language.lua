function setLanguage(fileLoc)
  local language = vim.api.nvim_buf_get_option(0, "filetype")
  -- local file = io.open(fileLoc, "w")
  -- need to figure out how one can have arbitrary language types while retaining
  -- talon explicit tag structure
  -- maybe programmatically writing python? idk that seems dangerous
end

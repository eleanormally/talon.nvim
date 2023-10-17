local identifiers = require("utils.identifiers")
local tagMode = require("utils.tagMode")

local M = {}

local talonAG = vim.api.nvim_create_augroup("talon.nvim", { clear = true })

-- opts:
--  - talonDirectory: string // the path


M.setup = function(opts)
  local dir = opts.talonDirectory
  if dir == nil then
    print("talonDirectory is required")
    return
  end

  vim.api.nvim_create_autocmd('InsertEnter', {
    pattern = "*",
    callback = function()
      identifiers.generate(dir .. "/treesitter_identifiers.talon")
    end,
    group = talonAG

  })

  vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = "*",
    callback = function()
      tagMode.generate(dir .. "/treesitter_tag_mode.talon")
    end,
    group = talonAG
  })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = "*",
    callback = function()
      tagMode.generate(dir .. "/treesitter_tag_mode.talon")
    end,
    group = talonAG
  })

  vim.api.nvim_create_autocmd('ExitPre', {
    pattern = "*",
    callback = function()
      tagMode.clear(dir .. "/treesitter_tag_mode.talon")
    end,
    group = talonAG
  })
end

return M

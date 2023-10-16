local tsutils = require('nvim-treesitter.ts_utils')
local function filterduplicates(list)
  local dupes = {}
  local result = {}
  for i = 1, #list do
    local item = list[i]
    if not dupes[item] then
      dupes[item] = true
      result[#result + 1] = item
    end
  end
  return result
end

local function TreesitterNames()
  local ts = vim.treesitter
  local parser = ts.get_parser()
  local bufnr = vim.api.nvim_get_current_buf()

  local root = parser:parse()[1]:root()
  local nodes = tsutils.get_named_children(root)
  local children = {}
  local named = {}
  while #nodes ~= 0 do
    children = {}
    for _, node in ipairs(nodes) do
      if node:type() == 'identifier' then
        table.insert(named, node)
      end
      local child_nodes = tsutils.get_named_children(node)
      if #child_nodes > 0 then
        table.insert(children, child_nodes)
      end
    end
    nodes = vim.tbl_flatten(children)
  end
  local names = filterduplicates(vim.tbl_map(function(node)
    return vim.treesitter.get_node_text(node, bufnr)
  end, named))

  local fileLoc = "/user/ellie/.talon/user/treesitter_names.talon"
  local file = io.open(fileLoc, "w")
  if file == nil then
    print("issue")
    return
  end
  for _, name in ipairs(names) do
    file:write(name .. '\n\t"' .. name .. '"\n')
  end
end

vim.keymap.set('n', '<leader>lD', TreesitterNames, {})

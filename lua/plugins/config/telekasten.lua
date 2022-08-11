-- local mod_name = "telekasten"
--
-- local status_ok, telekasten = pcall(require, mod_name)
-- if not status_ok then 
--   mod_name = "Telekasten"
--   status_ok, telekasten = pcall(require, mod_name)
--   if not status_ok then
--     print("here?" .. mod_name)
--     return
--   end
-- end

local mod_name = "telekasten"

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

local home = vim.fn.expand("~/zk")
require("telekasten").setup({
  home              = home,
  dailies           = home .. '/' .. 'daily',
  weeklies          = home .. '/' .. 'weekly',
  templates         = home .. '/' .. 'templates',
  image_subdir      = "img",
  extension         = ".norg",
  new_note_filename = "uuid-title",
  auto_set_filetype = false,
})

wk.register({
  ["<leader>Z"] = {
    name = "+Telekasten",
    f = { "<cmd>lua require('" .. mod_name .. "').find_notes()<cr>", "Find Notes" },
    g = { "<cmd>lua require('" .. mod_name .. "').search_notes()<cr>", "Search Notes" },
    T = { "<cmd>lua require('" .. mod_name .. "').goto_today()<cr>", "Goto Today" },
    W = { "<cmd>lua require('" .. mod_name .. "').goto_thisweek()<cr>", "Goto This Week" },
    n = { "<cmd>lua require('" .. mod_name .. "').new_note()<cr>", "New Note" },
    m = { "<cmd>lua require('" .. mod_name .. "').panel()<cr>", "Menu" },
  },
})

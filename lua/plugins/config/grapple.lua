local status_ok, grapple = pcall(require, "grapple")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

grapple.setup({
})

wk.register({
  ["<leader>bm"] = { "<cmd>lua require('grapple').popup_tags()<cr>", "Switch Grapple Marks" },
  ["<leader>bM"] = { "<cmd>lua require('grapple').toggle()<cr>", "Toggle Grapple Mark" },
})

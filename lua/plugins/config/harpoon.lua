local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then return end

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

harpoon.setup({})

telescope.load_extension("harpoon")

wk.register({
  ["<leader>bm"] = { "<cmd>Telescope harpoon marks<cr>", "Switch Harpoon Marks" },
  ["<leader>bM"] = { "<cmd>lua require('harpoon').add_file()<cr>", "Add Harpoon Mark" },
})

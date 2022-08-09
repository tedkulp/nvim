local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  view = {
    width = 30,
    side = "left",
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
})

wk.register({ ["<leader>e"] = { ":NvimTreeToggle<cr>", "Toggle Explorer" }})

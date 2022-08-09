local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

neotree.setup({
  close_if_last_window = true,
  window = {
    width = 30,
  },
})

vim.cmd("highlight NeoTreeTitleBar guifg=#333333")

wk.register({ ["<leader>e"] = { ":Neotree toggle<cr>", "Toggle Explorer" }})

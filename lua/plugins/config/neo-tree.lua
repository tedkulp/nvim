local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

neotree.setup({
  close_if_last_window = true,

  window = {
    width = 30,
  },
  buffers = {
    follow_current_file = true,
    window = {
      position = "float",
    },
  },
  git_status = {
    window = {
      position = "float",
    },
  },
})

vim.cmd("highlight NeoTreeTitleBar guifg=#333333")

wk.register({ ["<leader>e"] = { ":Neotree toggle reveal<cr>", "Toggle Explorer" } })
wk.register({
  ["<leader>g"] = {
    name = "+Git",
    s = { ":Neotree toggle git_status<cr>", "Toggle Git Status" },
  }
})

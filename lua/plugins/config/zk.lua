local zk_status_ok, zk = pcall(require, "zk")
if not zk_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

zk.setup({
  picker = "telescope",
})

wk.register({
  ["<leader>Z"] = {
    name = "+Zettelkasten",
    n = { "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", "New Note", noremap = true, silent = true },
    o = { "<cmd>ZkNotes { sort = { 'modified' } }<cr>", "Open Notes", noremap = true, silent = true },
    t = { "<cmd>ZkTags<cr>", "Open by Tag", noremap = true, silent = true },
    f = { "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<cr>", "Find Notes", noremap = true,
      silent = true },
    d = {
      name = "Daily Notes",
      t = { "<cmd>ZkNew { dir = 'daily', date = 'today' }<cr>", "Today", noremap = true, silent = true },
      y = { "<cmd>ZkNew { dir = 'daily', date = 'yesterday' }<cr>", "Yesterday", noremap = true, silent = true },
    },
  }
}, { mode = "n" })

wk.register({
  ["<leader>Z"] = {
    f = { ":'<,'>ZkMatch<cr>", "Find Note w/ Selection", noremap = true, silent = true },
  }
}, { mode = "v" })

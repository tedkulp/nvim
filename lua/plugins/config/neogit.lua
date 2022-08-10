local status_ok, neogit = pcall(require, "neogit")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

neogit.setup({
  integrations = {
    diffview = true,
  },
})

wk.register({
  ["<leader>g"] = {
    n = { "<cmd>lua require('neogit').open({ kind='split' })<cr>", "Neogit Status" },
  },
})

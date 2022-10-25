local dash_status_ok, dash = pcall(require, "dash")
if not dash_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

wk.register({
  ["gl"] = {
    "<cmd>DashWord<cr>",
    "Search current word in Dash",
  },
  ['gL'] = {
    "<cmd>DashWord!<cr>",
    "Search current word in Dash (no filter)",
  },
  ['<leader>sd'] = {
    "<cmd>Dash!<cr>",
    "Search in Dash",
  },
}, {
  mode = "n",
  noremap = true,
  silent = true,
})

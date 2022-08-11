local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

toggleterm.setup()

-- Non-leader shortcut (blasphemy, I know!)
vim.keymap.set("n", "<A-q>", "<cmd>ToggleTerm<cr>")

-- Shortcut to toggle terminal without having to nav out
vim.keymap.set("t", "<A-q>", "<C-\\><C-N><cmd>ToggleTerm<cr>")

wk.register({
  ["<leader>t"] = {
    name = "+Terminal",
    h = { "<cmd>ToggleTerm direction=horizontal size=15<cr>", "Horizontal Terminal" },
    t = { "<cmd>ToggleTerm direction=horizontal size=15<cr>", "Horizontal Terminal" },
    v = { "<cmd>ToggleTerm direction=vertical size=60<cr>", "Vertical Terminal" },
  }
})

local ic_status_ok, ic = pcall(require, "icon-picker")
if not ic_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

ic.setup({
  disable_legacy_commands = true,
})

vim.keymap.set("i", "<A-i>", "<cmd>IconPickerInsert<cr>", { noremap = true, silent = true }) -- opt-i on Mac

wk.register({
  ["<leader>b"] = {
    ["i"] = { "<cmd>IconPickerNormal<cr>", "Icon Picker" },
    ["y"] = { "<cmd>IconPickerYank<cr>", "Icon Picker (Yank)" },
  },
})

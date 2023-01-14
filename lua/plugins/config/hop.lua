local hop_status_ok, hop = pcall(require, "hop")
if not hop_status_ok then return end

local easy_action_status_ok, easy_action = pcall(require, "easy-action")
if not easy_action_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

hop.setup({
  keys = 'asdfjkl;qweruiop',
})

vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , { silent = true })
vim.api.nvim_set_keymap("n", "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , { silent = true })
vim.api.nvim_set_keymap("n", "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  , { silent = true })
vim.api.nvim_set_keymap("n", "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  , { silent = true })

easy_action.setup()

wk.register({
  ["<leader>."] = {
    "<cmd>BasicEasyAction<cr>", "Easy Action",
  }
})

wk.register({
  ["m"] = {
    { ":<C-U>lua require('tsht').nodes()<cr>", "Treesitter Scope", mode = "o", },
    { ":<C-U>lua require('tsht').nodes()<cr>", "Treesitter Scope", mode = "x", noremap = true },
  },
}, { silent = true })

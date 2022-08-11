local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

gitsigns.setup()

wk.register({
  ["<leader>g"] = {
    j = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
  }
})

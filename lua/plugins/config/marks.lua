local status_ok, marks = pcall(require, "marks")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

marks.setup({
  default_mappings = true,
  mappings = {
    set = false,
    set_next = false,
    toggle = false,
    next = false,
    prev = false,
    delete_line = false,
    delete_buffer = false,
  }
})

wk.register({
  ["`"] = { "<cmd>Telescope marks<cr>", "Open Marks" },
  ["m"] = {
    name = 'Marks',
    [','] = { ":lua require('marks').set_next()<cr>", "Set Next Mark" },
    [';'] = { ":lua require('marks').toggle()<cr>", "Toogle Mark" },
    [']'] = { ":lua require('marks').next()<cr>", "Goto Next Mark" },
    ['['] = { ":lua require('marks').prev()<cr>", "Goto Previous Mark" },
  },
  ["d"] = {
    m = {
      ['-'] = { ":lua require('marks').delete_line()<cr>", "Delete Marks on Line" },
      [' '] = { ":lua require('marks').delete_buf()<cr>", "Delete Marks in Buffer" },
    }
  },
})

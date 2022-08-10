local status_ok, goto_preview = pcall(require, "goto-preview")
if not status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

goto_preview.setup({
  default_mappings = true,
})

wk.register({
  g = {
    p = {
      name = "+Preview",
      d = { "Definition" },
      t = { "Type Definition" },
      i = { "Implementation" },
      r = { "References" },
    },
    P = { "Close Preview Windows" },
  },
})

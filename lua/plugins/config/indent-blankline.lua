local ib_status_ok, ib = pcall(require, "indent_blankline")
if not ib_status_ok then return end

ib.setup({
  filetype_exclude = { "help", "terminal", "dashboard", "lspinfo" },
  buftype_exclude = { "terminal", "dashboard", "nofile", "quickfix" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
})

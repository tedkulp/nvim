local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then return end

bufferline.setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icons = false,
    numbers = "none",
    separator_style = "slant",
    diagnostics = "nvim_lsp",
  },
})

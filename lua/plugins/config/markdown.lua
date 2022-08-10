local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

vim.fn["mkdp#util#install"]()

-- Only show markdown related menu items on a markdown buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    wk.register({
      ["<leader>b"] = {
        m = {
          "<cmd>MarkdownPreviewToggle<cr>",
          "Markdown Preview",
        },
      },
    }, { mode = "n", buffer = 0 })
  end,
})

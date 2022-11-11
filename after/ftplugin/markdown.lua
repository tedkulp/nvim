vim.opt.conceallevel = 1

Zk_status_ok, Zk_util = pcall(require, "zk.util")
if not Zk_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if Zk_status_ok and wk_status_ok then
  wk.register({
    ["<leader>b"] = {
      m = {
        "<cmd>MarkdownPreviewToggle<cr>",
        "Markdown Preview",
      },
    },
  }, { mode = "n", buffer = 0 })

  -- Add the key mappings only for Markdown files in a zk notebook.
  if Zk_util.notebook_root(vim.fn.expand('%:p')) ~= nil then
    wk.register({
      ["Z"] = {
        ["n"] = { "<cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", "New Note",
          mode = "n" },
        ["nt"] = { ":'<,'>ZkNewFromTitleSelection { dir = Zk_util.notebook_root(vim.fn.expand('%:p:h')) }<CR>",
          "New Note w/ Title Selection",
          mode = "v" },
        ["nc"] = { ":'<,'>ZkNewFromContentSelection { dir = Zk_util.notebook_root(vim.fn.expand('%:p:h')), title = vim.fn.input('Title: ') }<CR>",
          "New Note w/ Content Selection", mode = "v" },
        ["b"] = { "<cmd>ZkBacklinks<CR>", "Open backlinked notes", mode = "n" },
        ["l"] = { "<cmd>ZkLinks<CR>", "Open linked notes", mode = "n" },
        ["a"] = { ":'<,'>lua vim.lsp.buf.code_action()<CR>", "Code Actions", mode = "v" },
      },
    }, {
      prefix = "<leader>",
      buffer = 0,
      noremap = true,
      silent = true,
    })
  end
end

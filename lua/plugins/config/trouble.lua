local trouble_status_ok, trouble = pcall(require, "trouble")
if not trouble_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

trouble.setup({
})

wk.register({
  ["<leader>l"] = {
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
    l = { "<cmd>Trouble loclist<cr>", "Location List" },
    q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  },
  g = {
    R = { "<cmd>Trouble lsp_references<cr>", "LSP References" },
  },
})

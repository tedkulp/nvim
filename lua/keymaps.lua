local keymap = vim.keymap.set
local opts = { silent = true }

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

-- All hail <space>, the one true leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL

-- I hit f1 way too much - just use :h
keymap("n", "<f1>", "<nop>")

-- I've never created a macro in my life -- I'd like to move this to another key
keymap("n", "q", "<nop>")

-- Better window navigation
keymap("n", "<C-h>", "<cmd>wincmd h<cr>", opts)
keymap("n", "<C-j>", "<cmd>wincmd j<cr>", opts)
keymap("n", "<C-k>", "<cmd>wincmd k<cr>", opts)
keymap("n", "<C-l>", "<cmd>wincmd l<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprev<cr>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m +1<CR>==", opts)
keymap("n", "<A-k>", ":m -2<CR>==", opts)

-- Blatently stolen from emacs
keymap("n", "<A-x>", "<cmd>Telescope commands<cr>", opts)

-- These is in autocommands.lua
-- Toggle the quickfix window
keymap("n", "<c-q>", ":call QuickFixToggle()<cr>", opts)

-- Non plugin which-key mappings (Telescope and Packer don't count)
if wk_status_ok then
  wk.register({
    ["<leader>h"] = { "<cmd>nohlsearch<cr>", "Clear Search" },
    ["<leader><leader>"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
    ["<leader>,"] = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
    ["<leader>/"] = { "<cmd>Telescope live_grep_args<CR>", "File Search" },
    ["<leader>."] = { "<cmd>Telescope find_files<CR>", "Find Files" },
    ["<leader>`"] = { ":edit #<CR>", "Last Buffer" },
    ["<leader>l"] = {
      name = "+LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      j = { vim.diagnostic.goto_next, "Next Diagnostic", },
      k = { vim.diagnostic.goto_prev, "Prev Diagnostic", },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      w = { "<cmd>Telescope diagnostics theme=get_ivy<cr>", "Workspace Diagnostics" },
    },
    ["<leader>p"] = {
      name = "+Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    ["<leader>b"] = {
      name = "+Buffer",
      c = { "<cmd>close<cr>", "Close split" },
      f = { "<cmd>Telescope buffers<cr>", "Find" },
      s = { "<cmd>split<cr>", "Split Horizontal" },
      v = { "<cmd>vsplit<cr>", "Split Vertical" },
    },
    ["<leader>c"] = { "<cmd>bd<CR>", "Close Buffer" },
    ["<leader>g"] = {
      name = "+Git",
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    },
    ["<leader>s"] = {
      name = "+Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
    },
    ["gr"] = { "Replace without yank" },

    -- LSP Keymaps -- removing conflicts - adding readable descriptions
    ["K"] = { vim.lsp.buf.hover, "Show hover" },
    ["gd"] = { vim.lsp.buf.definition, "Definition" },
    ["gD"] = { vim.lsp.buf.declaration, "Declaration" },
    ["go"] = { vim.lsp.buf.type_definition, "Type Definition" },
    ["<F2>"] = { vim.lsp.buf.rename, "Rename" },
    ["<F4>"] = { vim.lsp.buf.code_action, "Code Action" },
  })
end

-- VISUAL

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

if wk_status_ok then
  wk.register({
    ["gr"] = { "Replace without yank" },
  }, { mode = "v" })
end


----------------------------
-- TERMINAL
----------------------------

-- Better window navigation
vim.api.nvim_create_augroup("_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = "_terminal",
  pattern = "term://*",
  callback = function()
    local _opts = { noremap = true, silent = true }
    keymap("t", "<C-n>", "<c-\\><c-n>", _opts)
    keymap("t", "<C-h>", "<cmd>wincmd h<cr>", _opts)
    keymap("t", "<C-j>", "<cmd>wincmd j<cr>", _opts)
    keymap("t", "<C-k>", "<cmd>wincmd k<cr>", _opts)
    keymap("t", "<C-l>", "<cmd>wincmd l<cr>", _opts)
  end,
})

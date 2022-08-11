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
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

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
    ["<leader>/"] = { "<cmd>Telescope live_grep<CR>", "File Search" },
    ["<leader>."] = { "<cmd>Telescope find_files<CR>", "Find Files" },
    ["<leader>`"] = { ":edit #<CR>", "Last Buffer" },
    ["<leader>l"] = {
      name = "+LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
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
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

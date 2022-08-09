local keymap = vim.keymap.set
local opts = { silent = true }

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

-- All hail <space>, the one true leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("", "<Space>", "<Nop>", opts)

-- NORMAL

-- I hit f1 way too much - just use :h
vim.keymap.set("n", "<f1>", "<nop>")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprev<cr>", opts)

-- Blatently stolen from emacs
keymap("n", "<A-x>", "<cmd>Telescope commands<cr>", opts)

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

keymap("n", "<c-q>", "<cmd>:call QuickFixToggle()<cr>", opts)

if wk_status_ok then
  -- Clear highlights
  wk.register({ ["<leader>h"] = { "<cmd>nohlsearch<cr>", "Clear Search" } })

  wk.register({
    ["<leader><leader>"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
    ["<leader>,"] = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
    ["<leader>."] = { "<cmd>Telescope live_grep<CR>", "File Search" },
    ["<leader>l"] = {
      name = "+LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    },
    ["<leader>p"] = {
      name = "+Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      s = { "<cmd>PackerSync<cr>", "Sync Plugins" },
    },
    ["<leader>b"] = {
      name = "+Buffer",
      c = { "<cmd>close<cr>", "Close split" },
      f = { "<cmd>Telescope buffers<cr>", "Find" },
      s = { "<cmd>split<cr>", "Split Horizontal" },
      v = { "<cmd>vsplit<cr>", "Split Vertical" },
    },
    ["<leader>c"] = { "<cmd>bd<CR>", "Close Buffer" },
    ["K"] = { vim.lsp.buf.hover, "Show hover" },
  })
end

-- VISUAL

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

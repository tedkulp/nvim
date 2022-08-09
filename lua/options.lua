local options = {
  background = "dark",
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  conceallevel = 0,
  cursorline = true,
  expandtab = true,
  laststatus = 3,
  lbr = true,
  mouse = "niv",
  number = true,
  numberwidth = 4,
  shiftwidth = 2,
  showtabline = 2,
  signcolumn = "yes",
  smartcase = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  relativenumber = true,
  termguicolors = true,
  timeoutlen = 300,
  undofile = true,
  updatetime = 100,
  writebackup = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "acsI"   -- disable nvim intro
vim.opt.whichwrap:append "<>[]hl" -- go to previous/next line with h,l


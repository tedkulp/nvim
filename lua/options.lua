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
  scrolloff = 5,
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

vim.opt.shortmess:append "acsI" -- disable nvim intro
vim.opt.whichwrap:append "<>[]hl" -- go to previous/next line with h,l

local _g = vim.g
if _g['neovide'] then
  _g['neovide_input_macos_alt_is_meta'] = true
  _g['neovide_input_use_logo'] = true
  _g['neovide_cursor_vfx_mode'] = "pixiedust"
end

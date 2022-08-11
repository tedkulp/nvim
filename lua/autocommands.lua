-- Command to toggle on/off the quickfix window
vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

-- Highlight text that was yanked
vim.cmd [[
  au TextYankPost * silent! lua vim.highlight.on_yank()
]]

vim.api.nvim_create_augroup("_general", { clear = true })

-- Close different buffers with `q`
vim.api.nvim_create_autocmd("FileType", {
  group = "_general",
  pattern = "qf,help,man,lspinfo,startuptime,neotest-summary,Telescope*",
  callback = function(--[[ args ]])
    -- print(vim.inspect(args.match))
    vim.cmd("nnoremap <silent><buffer> q :close!<cr>")
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = "_general",
--   pattern = "*",
--   callback = function(args)
--     print(vim.inspect(args.match))
--   end,
-- })

local hls_status_ok, hls = pcall(require, "hlslens")
if not hls_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

hls.setup()

wk.register({
  ['n'] = {
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    "Next Search Result",
  },
  ['N'] = {
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    "Previous Search Result",
  },
  ['*'] = {
    "*<Cmd>lua require('hlslens').start()<CR>",
    "Search Highlighted Word (Forward)",
  },
  ['#'] = {
    "#<Cmd>lua require('hlslens').start()<CR>",
    "Search Highlighted Word (Back)",
  },
  ['g*'] = {
    "g*<Cmd>lua require('hlslens').start()<CR>",
    "Search Highlighted Word (Forward)",
  },
  ['g#'] = {
    "g#<Cmd>lua require('hlslens').start()<CR>",
    "Search Highlighted Word (Back)",
  },
}, {
  mode = "n",
  noremap = true,
  silent = true,
})

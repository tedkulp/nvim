local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then return end

neoclip.setup({
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-o>',
        replay = '<c-q>', -- replay a macro
        delete = '<c-d>', -- delete an entry
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        custom = {},
      },
    },
  },
})

vim.keymap.set("i", "<c-y>", "<cmd>lua require('telescope').extensions.neoclip.default()<cr>",
  { noremap = true, silent = true })

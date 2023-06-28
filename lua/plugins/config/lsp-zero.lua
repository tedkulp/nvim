local lsp = require('lsp-zero').preset({})
local luasnip = require('luasnip')
local lsp_format = require('lsp-format')
local mason_null_ls = require('mason-null-ls')
local null_ls = require('null-ls')


-----------------------------
-- Format on save
-----------------------------

lsp_format.setup({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp_format.on_attach(client)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.configure("ltex", {
  on_attach = function(_, _)
    require("ltex_extra").setup {
      load_langs = { "en-US", "es-GB" },
      init_check = true,
      path = vim.fn.stdpath("config") .. "/spell/",
      log_level = "none",
    }
  end,
  settings = {
    ltex = {
    },
  },
})

lsp.configure("yamlls", {
  settings = {
    yaml = {
      schemas = {
        kubernetes = "/kubernetes/**/*{.yaml,.yml}",
      },
    },
  },
})


-----------------------------
-- Start it up
-----------------------------

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'spell',   keyword_length = 3 },
    { name = 'emoji' },
  },
  mapping = {
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i' }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp.mapping(cmp.mapping(cmp.mapping.complete({}), { "i", "c" })),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  },
})

mason_null_ls.setup({
  automatic_setup = true,
})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
  },
})

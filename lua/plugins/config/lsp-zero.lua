local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then return end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

local lsp_format_status_ok, lsp_format = pcall(require, "lsp-format")
if not lsp_format_status_ok then return end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then return end

local lines_status_ok, lines = pcall(require, "lsp_lines")

local kind_icon = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

lsp.preset("recommended")

lsp.set_preferences({
  set_lsp_keymaps = false,
  sign_icons = {
    error = "",
    warn = "",
    hint = "",
    info = ""
  }
})

lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true),
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_mappings = lsp.defaults.cmp_mappings()

cmp_mappings["<C-k>"] = cmp.mapping.select_prev_item()
cmp_mappings["<C-j>"] = cmp.mapping.select_next_item()
cmp_mappings["<C-Space>"] = cmp.mapping(cmp.mapping(cmp.mapping.complete({}), { "i", "c" }))
cmp_mappings["<Tab>"] = cmp.mapping(function(fallback)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end, { "i", "s" })
cmp_mappings["<S-Tab>"] = cmp.mapping(function(fallback)
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { "i", "s" })

local cmp_sources = lsp.defaults.cmp_sources()

table.insert(cmp_sources, 1, { name = 'emoji' })
table.insert(cmp_sources, 1, { name = 'orgmode' })

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = cmp_sources,
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },

    format = function(entry, item)
      -- item.kind = kind_icon[item.kind]
      item.kind = string.format("%s %s", kind_icon[item.kind], item.kind)
      item.menu = ({
        buffer = "[Buffer]",
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        emoji = "[Emoji]",
      })[entry.source.name]

      return item
    end
  },
})

-- https://github.com/lukas-reineke/lsp-format.nvim/blob/master/doc/format.txt#L45
lsp_format.setup({})

lsp.on_attach(function(client, _)
  lsp_format.on_attach(client)
end)

lsp.setup()

if lines_status_ok then
  lines.setup()

  -- Default to messages at the end of lines
  vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
  })

  vim.api.nvim_create_user_command('ToggleLspLines', function()
    local flag = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config { virtual_lines = flag, virtual_text = not flag }
    vim.notify.notify("LSP lines has been " .. (flag and "enabled" or "disabled"), "info", {})
  end, {
    desc = "Switch between diagnostic messages at end of line or directly below code",
  })

  wk.register({ ["<leader>lt"] = { "<cmd>ToggleLspLines<cr>", "Toggle LSP Lines" } })
end

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.diagnostics.jsonlint,
    -- null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.markdownlint,
    -- null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rustfmt,
  },
})

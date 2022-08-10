local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then return end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then return end

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

local cmp_mappings = lsp.defaults.cmp_mappings()

cmp_mappings["<C-k>"] = cmp.mapping.select_prev_item()
cmp_mappings["<C-j>"] = cmp.mapping.select_next_item()
cmp_mappings["<C-Space>"] = cmp.mapping(cmp.mapping(cmp.mapping.complete({}), { "i", "c" }))

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
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
      })[entry.source.name]

      return item
    end
  },
})

lsp_format.setup({})

lsp.on_attach(function(client, _)
  -- TODO: Should we be filtering this to certain file types?
  -- lsp_format.on_attach(client)
end)

lsp.setup()

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

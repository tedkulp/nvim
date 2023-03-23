local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then return end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local copilot_status_ok, copilot = pcall(require, "copilot_cmp")
if not copilot_status_ok then return end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then return end

local lsp_format_status_ok, lsp_format = pcall(require, "lsp-format")
if not lsp_format_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
local lines_status_ok, lines = pcall(require, "lsp_lines")

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then return end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then return end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

local mason_nvim_dap_status_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status_ok then return end

-----------------------------
-- Initialization
-----------------------------

lsp.preset("recommended")

lsp.set_preferences({
  set_lsp_keymaps = { omit = { 'gr', 'gi' } }
})

-----------------------------
-- Completion setup
-----------------------------

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
  TypeParameter = "",
  Copilot = "",
}

-- Setup the ctrl-j/k mappings for the dropdown and
-- make Luasnip a little more intelligent w/ tab
local cmp_mappings = lsp.defaults.cmp_mappings()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

-- Add in our custom completion sources
local cmp_sources = lsp.defaults.cmp_sources()

table.insert(cmp_sources, 1, { name = 'copilot' })
table.insert(cmp_sources, { name = 'spell' })
table.insert(cmp_sources, { name = 'emoji' })

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
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        buffer = "[Buffer]",
        emoji = "[Emoji]",
        spell = "[Spell]",
        codium = "[Codium]",
        copilot = "[Copilot]",
      })[entry.source.name]

      return item
    end
  },
})

-----------------------------
-- Fixes for spelling in plain text
-----------------------------

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

-----------------------------
-- LSP Lines
-----------------------------

lsp.configure("yamlls", {
  settings = {
    yaml = {
      schemas = {
        kubernetes = "/kubernetes/**/*{.yaml,.yml}",
      },
    },
  },
})

if lines_status_ok and wk_status_ok then
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

-----------------------------
-- Format on save
-----------------------------

-- https://github.com/lukas-reineke/lsp-format.nvim/blob/master/doc/format.txt#L45
lsp_format.setup({})

lsp.on_attach(function(client, _)
  lsp_format.on_attach(client)
end)

-----------------------------
-- Startup everything except null-ls
-----------------------------

lsp.setup()

-----------------------------
-- mason, null-ls and DAP setup
-----------------------------

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
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

mason_nvim_dap.setup({
  automatic_setup = true,
})

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then return end

require("luasnip.loaders.from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
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

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-space>"] = cmp.mapping(cmp.mapping(cmp.mapping.complete(), { "i", "c" })),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      vim_item.menu = ({
        buffer = "[Buffer]",
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        -- nvim_lua = "[Lua]",
      })[entry.source.name]

      return vim_item
    end
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

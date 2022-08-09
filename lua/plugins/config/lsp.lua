local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then return end

local servers = mason_lspconfig.get_installed_servers()
for _, server in pairs(servers) do
  -- Move me to another file
  if server == "sumneko_lua" then
    lspconfig[server].setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Make sure vim is a recognized global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
          },
        },
      },
    })
  else
    lspconfig[server].setup({})
  end
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- null_ls.builtins.code_actions.gitsigns,
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.mix,
    -- formatting.shellcheck,
    diagnostics.flake8,
  },
})

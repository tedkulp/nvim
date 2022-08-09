local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

local context_ok, context = pcall(require, "treesitter-context")
if context_ok then
  context.setup()
end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

local languages = {
  "bash",
  "comment",
  "dockerfile",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

configs.setup({
  context_commentstring = {
    enable = true,
    enable_autocmd = true,
  },
  ensure_installed = languages,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = false,
  },
  sync_install = true,
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["ga"] = "@parameter.inner",
      },
      swap_previous = {
        ["gA"] = "@parameter.inner",
      },
    },
  },
})

wk.register({
  ["g"] = {
    a = "Swap Arg Right",
    A = "Swap Arg Left",
  },
})

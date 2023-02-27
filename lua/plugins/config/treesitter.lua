local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

local context_ok, context = pcall(require, "treesitter-context")
if context_ok then
  context.setup()
end

local various_ok, various = pcall(require, "various-textobjs")
if various_ok then
  various.setup({
    useDefaultKeymaps = true
  })
end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

local languages = {
  "bash",
  "comment",
  "dockerfile",
  "eex",
  "elixir",
  "erlang",
  "heex",
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
  "surface",
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
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  sync_install = true,
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select function outer" },
        ["if"] = { query = "@function.inner", desc = "Select function inner" },
        ["aC"] = { query = "@class.outer", desc = "Select class outer" },
        ["iC"] = { query = "@class.inner", desc = "Select class inner" },
        ["aq"] = { query = "@block.outer", desc = "Select block outer (to)" },
        ["iq"] = { query = "@block.inner", desc = "Select block inner (to)" },
        ["ac"] = { query = "@call.outer", desc = "Select call outer (to)" },
        ["ic"] = { query = "@call.inner", desc = "Select call inner (to)" },
      },
    },
    swap = {
      enable = true,
    },
  },
})

wk.register({
  ["g"] = {
    a = { "<cmd>TSTextobjectSwapNext @parameter.inner<cr>", "Swap Arg Right" },
    A = { "<cmd>TSTextobjectSwapPrevious @parameter.inner<cr>", "Swap Arg Left" },
  },
  ["["] = {
    f = { "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", "Previous Function Start" },
    c = { "<cmd>TSTextobjectGotoPreviousStart @class.outer<cr>", "Previous Class Start" },
    b = { "<cmd>TSTextobjectGotoPreviousStart @block.inner<cr>", "Previous Block Start" },
    F = { "<cmd>TSTextobjectGotoPreviousEnd @function.outer<cr>", "Previous Function End" },
    C = { "<cmd>TSTextobjectGotoPreviousEnd @class.outer<cr>", "Previous Class End" },
    B = { "<cmd>TSTextobjectGotoPreviousEnd @block.inner<cr>", "Previous Block End" },
  },
  ["]"] = {
    f = { "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", "Next Function Start" },
    c = { "<cmd>TSTextobjectGotoNextStart @class.outer<cr>", "Next Class Start" },
    b = { "<cmd>TSTextobjectGotoNextStart @block.inner<cr>", "Next Block Start" },
    F = { "<cmd>TSTextobjectGotoNextEnd @function.outer<cr>", "Next Function End" },
    C = { "<cmd>TSTextobjectGotoNextEnd @class.outer<cr>", "Next Class End" },
    B = { "<cmd>TSTextobjectGotoNextEnd @block.inner<cr>", "Next Block End" },
  },
})

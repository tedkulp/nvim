local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end

local wp_status_ok, wp = pcall(require, "window-picker")
if not wp_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

wp.setup({
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    bo = {
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'quickfix' },
      buftype = { 'terminal' },
    },
  },
  fg_color = '#000',
})

neotree.setup({
  close_if_last_window = true,
  window = {
    width = 30,
    mappings = {
      ["<cr>"] = "open_with_window_picker",
      ["S"] = "split_with_window_picker",
      ["s"] = "vsplit_with_window_picker",
    },
  },
  buffers = {
    follow_current_file = true,
    window = {
      position = "float",
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_by_name = {
        ".git",
        "node_modules",
        ".vscode",
      },
      hide_by_pattern = {
        "*build*",
        "*dist*",
      },
    },
    follow_current_file = true,
  },
  git_status = {
    window = {
      position = "float",
    },
  },
})

vim.cmd("highlight NeoTreeTitleBar guifg=#333333")

wk.register({ ["<leader>e"] = { ":Neotree toggle reveal<cr>", "Toggle Explorer" } })
wk.register({ ["<leader>be"] = { ":Neotree toggle buffers<cr>", "Buffer Explorer" } })
wk.register({
  ["<leader>g"] = {
    S = { ":Neotree toggle git_status<cr>", "Toggle Git Status" },
  }
})

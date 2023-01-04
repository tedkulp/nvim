local utils = require("utils")

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then return end

local actions = require("telescope.actions")

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

-- Pull these into a separte config file
local dirs_to_include = { "~/src", "~/src/tmp", "~/src/omuras/code", "~/org" }
local base_dirs = {}

-- Add our config location to the project list
if vim.env.MYVIMRC then
  table.insert(dirs_to_include, 1, utils.get_path(utils.get_path(vim.env.MYVIMRC)))
end

for _, the_dir in ipairs(dirs_to_include) do
  the_dir = string.gsub(the_dir, "~", os.getenv("HOME") or '')
  if utils.is_directory(the_dir) then
    table.insert(base_dirs, { path = the_dir })
  end
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["d"] = "delete_buffer",
        },
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      files = true,
      grouped = true,
    },
    live_grep_args = {
      auto_quoting = true,
      default_mappings = {},
    },
    project = {
      base_dirs = base_dirs,
      hidden_files = false,
    },
    tele_tabby = {
      use_highlighter = true,
    },
    ["telescope-tabs"] = {
      show_preview = false,
      entry_formatter = function(tab_id, buffer_ids, _, _)
        local cwd = vim.fn.getcwd(-1, tab_id)
        local cwdDirName = cwd:match("%w+$")
        return string.format('%d: %s - %s window(s)', tab_id, cwdDirName, #buffer_ids)
      end,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        codeactions = false,
      })
    },
    zoxide = {
      config = {
        mappings = {
          ["<C-t>"] = {
            action = function()
              vim.cmd("tabnew")
            end,
            after_action = function(selection)
              vim.cmd("tcd " .. selection.path)
            end,
          },
        },
      },
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")
-- telescope.load_extension("tele_tabby")
telescope.load_extension("telescope-tabs")
telescope.load_extension("live_grep_args")
-- telescope.load_extension("dap")

wk.register({
  ["<leader>P"] = {
    function()
      if not packer_plugins["telescope-project.nvim"].loaded then
        require("packer").loader("telescope-project.nvim")
        telescope.load_extension("project")
      end
      vim.cmd("Telescope project display_type=full")
    end,
    "Project List",
  },
  ["<leader>T"] = {
    function()
      require('telescope').extensions['telescope-tabs'].list_tabs()
    end,
    "Tab List",
  },
  ["<leader>z"] = {
    function()
      if not packer_plugins["telescope-zoxide"].loaded then
        require("packer").loader("telescope-zoxide")
        telescope.load_extension("zoxide")
      end
      require('telescope').extensions.zoxide.list()
    end,
    "Find Directory w/ 'z'",
  },
})

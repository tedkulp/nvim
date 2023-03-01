local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then return end

local actions = require("telescope.actions")

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

telescope.setup({
  defaults = {
    theme = "ivy",
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
    ["telescope-tabs"] = {
      show_preview = false,
      entry_formatter = function(tab_id, buffer_ids, _, _)
        local cwd = vim.fn.getcwd( -1, tab_id)
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
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")
telescope.load_extension("telescope-tabs")
telescope.load_extension("live_grep_args")
-- telescope.load_extension("dap")
telescope.load_extension("zoxide")

wk.register({
  ["<leader>r"] = {
    require('telescope.builtin').resume,
    "Resume Telescope",
  },
  ["<leader>T"] = {
    function()
      require('telescope').extensions['telescope-tabs'].list_tabs()
    end,
    "Tab List",
  },
  ["<leader>z"] = {
    "<cmd>Telescope zoxide list<cr>",
    "Find Directory w/ 'z'",
  },
})

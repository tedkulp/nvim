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
table.insert(dirs_to_include, 1, utils.get_path(utils.get_path(vim.env.MYVIMRC)))

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
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        codeactions = false,
      })
    },
    project = {
      base_dirs = base_dirs,
      hidden_files = false,
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")
telescope.load_extension("project")

wk.register({
  ["<leader>P"] = {
    "<cmd>Telescope project display_type=full<cr>",
    "Project List",
  },
})

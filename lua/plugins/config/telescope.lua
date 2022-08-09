local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then return end

local actions = require("telescope.actions")
-- local previewers = require("telescope.previewers")
-- local trouble = require("trouble.providers.telescope")
-- local sorters = require("telescope.sorters")

telescope.load_extension("file_browser", { grouped = true })
telescope.load_extension("fzf")
-- telescope.load_extension("ui-select")

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
    extensions = {
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      file_browser = {
        files = false,
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          codeactions = false,
        })
      },
    },
  },
})

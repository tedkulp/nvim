local status_ok, neorg = pcall(require, "neorg")
if not status_ok then return end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {
      config = {
        dim_code_blocks = {
          enabled = true,
          content_only = true,
          adaptive = true,
        },
        icon_preset = "varied",
        markup_preset = "dimmed",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.export"] = {},
    ["core.export.markdown"] = {},
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    wk.register({
      ["gt"] = {
        u = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_undone()<cr>",
          "Mark Task Undone",
        },
        p = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_pending()<cr>",
          "Mark Task Pending",
        },
        d = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_done()<cr>",
          "Mark Task Done",
        },
        h = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_on_hold()<cr>",
          "Mark Task On Hold",
        },
        c = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_cancelled()<cr>",
          "Mark Task Cancelled",
        },
        r = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_recurring()<cr>",
          "Mark Task as Recurring",
        },
        i = {
          "<cmd>lua core.norg.qol.todo_items.todo.task_important()<cr>",
          "Mark Task Important",
        },
      },
    }, { mode = "n", buffer = 0 })
  end,
})

local config = cmp.get_config()
table.insert(config.sources, {
  name = "neorg",
})
cmp.setup(config)

local leap_status_ok, leap = pcall(require, "leap")
if not leap_status_ok then return end

local easy_action_status_ok, easy_action = pcall(require, "easy-action")
if not easy_action_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

--[[ leap.add_default_mappings() ]]

-- Same as the version in the leap plugin, but removes the X/x in Visual mode
local function add_default_mappings(force_3f)
  for _, _1_ in ipairs({
    { { "n", "x", "o" }, "s", "<Plug>(leap-forward-to)" },
    { { "n", "x", "o" }, "S", "<Plug>(leap-backward-to)" },
    { { "o" }, "x", "<Plug>(leap-forward-till)" }, -- removed 'x' mode
    { { "o" }, "X", "<Plug>(leap-backward-till)" }, -- removed 'x' mode
    { { "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)" }
  }) do
    local _each_2_ = _1_
    local modes = _each_2_[1]
    local lhs = _each_2_[2]
    local rhs = _each_2_[3]
    for _0, mode in ipairs(modes) do
      if (force_3f or ((vim.fn.mapcheck(lhs, mode) == "") and (vim.fn.hasmapto(rhs, mode) == 0))) then
        vim.keymap.set(mode, lhs, rhs, { silent = true })
      else
      end
    end
  end
  return nil
end

add_default_mappings()

easy_action.setup({
  jump_provider = "leap",
  jump_provider_config = {
    leap = {
      action_select = {
        default = function()
          require('leap').leap { target_windows = vim.tbl_filter(
            function(win) return vim.api.nvim_win_get_config(win).focusable end,
            vim.api.nvim_tabpage_list_wins(0)
          ) }
        end,
      },
    },
  }
})

wk.register({
  ["<leader>."] = {
    "<cmd>BasicEasyAction<cr>", "Easy Action",
  }
})

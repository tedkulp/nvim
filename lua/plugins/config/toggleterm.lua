local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

local HORIZ_SIZE = 20
local VERT_SIZE = 80

toggleterm.setup({
  size = function(term)
    if (term.direction == "horizontal") then
      return HORIZ_SIZE
    elseif (term.direction == "vertical") then
      return VERT_SIZE
    end
  end,
  open_mapping = [[<A-q>]],
  persist_mode = true,
})

wk.register({
  ["<leader>t"] = {
    name = "+Terminal",
    h = { "<cmd>1ToggleTerm direction=horizontal size=" .. HORIZ_SIZE .. "<cr>", "Horizontal Terminal" },
    t = { "<cmd>1ToggleTerm direction=horizontal size=" .. HORIZ_SIZE .. "<cr>", "Horizontal Terminal" },
    v = { "<cmd>1ToggleTerm direction=vertical size=" .. VERT_SIZE .. "<cr>", "Vertical Terminal" },
  }
})

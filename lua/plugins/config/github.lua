local octo_status_ok, octo = pcall(require, "octo")
if not octo_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

octo.setup()

wk.register({
  ["<leader>g"] = {
    h = { "<cmd>OpenInGHRepo<cr>", "Open Repo in Github" },
    H = { "<cmd>OpenInGHFile<cr>", "Open File in Github" },
  },
})

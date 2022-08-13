local iswap_status_ok, iswap = pcall(require, "iswap")
if not iswap_status_ok then return end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

iswap.setup({
  keys = 'asdfjkl;qweruiop',
})

wk.register({
  ["<leader>l"] = {
    s = { "<cmd>ISwap<cr>", "Swap" },
    S = { "<cmd>ISwapWith<cr>", "Swap With" },
    z = { "<cmd>ISwapNode<cr>", "Node Swap" },
    Z = { "<cmd>ISwapNodeWith<cr>", "Node Swap With" },
  }
})

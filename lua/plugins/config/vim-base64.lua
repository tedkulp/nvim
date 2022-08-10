local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

vim.cmd("let g:vim_base64_disable_default_key_mappings = 1")

wk.register({
  ["<leader>u"] = {
    name = "+Text Utils",
    b = {
      name = "+Base 64",
      e = { ":<c-u>call base64#v_btoa()<cr>", "Base64 Encode", noremap = true, silent = true },
      d = { ":<c-u>call base64#v_atob()<cr>", "Base64 Decode", noremap = true, silent = true },
    }
  }
}, { mode = "v" })

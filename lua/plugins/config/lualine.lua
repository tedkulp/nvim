local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then return end

local status_status_ok, status = pcall(require, "lsp-status")
if not status_status_ok then return end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local function list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local function lsp(msg)
  msg = msg or "LS Inactive"

  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return "LS Inactive"
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local providers = list_registered_providers_names(buf_ft)
  vim.list_extend(buf_client_names, providers['formatter'] or {})
  vim.list_extend(buf_client_names, providers['linter'] or {})

  local unique_client_names = vim.fn.uniq(buf_client_names)
  return "LSP: " .. table.concat(unique_client_names, ", ")
end

lualine.setup({
  options = {
    theme = "catppuccin",
  },
  sections = {
    lualine_y = { 'nvim_lsp', 'encoding', 'fileformat', 'filetype' },
    lualine_x = { { function() return status.status() end, fmt = trunc(120, 60, 60, false) },
      { function() return lsp() end } },
  },
})

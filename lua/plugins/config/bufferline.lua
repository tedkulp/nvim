local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then return end

local filtered_types = { "qf" }

local function in_table(tbl, item)
  for key, value in pairs(tbl) do
    if value == item then return key end
  end
  return false
end

local function get_tab_filetype(buf_num)
  return vim.bo[buf_num].filetype
end

local function diagnostics_indicator(_, _, diagnostics, _)
  local result = {}
  local symbols = { error = "", warning = "", info = "" }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  local str_result = table.concat(result, " ")
  return #str_result > 0 and str_result or ""
end

bufferline.setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icons = false,
    show_tab_indicators = true,
    numbers = "ordinal",
    separator_style = "slant",
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    custom_filter = function(buf_num, _)
      -- print(vim.inspect(buf_numb), vim.bo[buf_num].filetype)
      if in_table(filtered_types, get_tab_filetype(buf_num)) then
        return false
      end
      return true
    end,
  },
})

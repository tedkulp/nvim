local M = {}

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

--- Gets the path that the given file lives in
--@param filename (string) filename to parse
--@returns (string)
function M.get_path(str)
  return str:match("(.*)[/\\]")
end

return M

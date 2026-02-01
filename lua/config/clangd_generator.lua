local M = {}

-- Detect C++ standard from CMakeLists.txt
function M.detect_cpp_standard()
  local cmake_file = vim.fn.getcwd() .. "/CMakeLists.txt"
  
  if vim.fn.filereadable(cmake_file) == 0 then
    return "20" -- Default to C++20
  end
  
  local file = io.open(cmake_file, "r")
  if not file then
    return "20"
  end
  
  local content = file:read("*all")
  file:close()
  
  -- Try to find CMAKE_CXX_STANDARD
  local std = content:match("CMAKE_CXX_STANDARD%s+(%d+)")
  if std then
    return std
  end
  
  -- Try to find -std=c++XX in compile options
  std = content:match("%-std=c%+%+(%d+)")
  if std then
    return std
  end
  
  return "20" -- Default to C++20
end

-- Generate .clangd configuration file
function M.generate_clangd()
  local root = vim.fn.getcwd()
  local clangd_path = root .. "/.clangd"
  local cpp_std = M.detect_cpp_standard()
  
  local config = string.format([[CompileFlags:
  Add:
    - -std=c++%s
    - -Wall
    - -Wextra
    - -Wpedantic
    - -xc++  # Treat all .h files as C++ headers
  CompilationDatabase: build/

Diagnostics:
  UnusedIncludes: Strict
  MissingIncludes: Strict
  
Index:
  Background: Build
]], cpp_std)
  
  local file = io.open(clangd_path, "w")
  if file then
    file:write(config)
    file:close()
    vim.notify(
      string.format("✓ Generated .clangd with C++%s standard", cpp_std),
      vim.log.levels.INFO
    )
    
    -- Restart LSP to pick up new config
    vim.defer_fn(function()
      vim.cmd("LspRestart clangd")
      vim.notify("↻ Restarted clangd to apply configuration", vim.log.levels.INFO)
    end, 500)
  else
    vim.notify("✗ Failed to create .clangd file", vim.log.levels.ERROR)
  end
end

return M

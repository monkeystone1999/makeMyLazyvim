-- Auto-generate .clangd configuration for C++ projects
-- This is loaded directly from init.lua, not as a lazy.nvim plugin

-- Helper function to find project root
local function find_root()
  local markers = { ".git", "CMakeLists.txt", "Makefile", "compile_commands.json" }
  local current = vim.fn.expand("%:p:h")
  
  -- Search up the directory tree
  while current ~= "/" do
    for _, marker in ipairs(markers) do
      if vim.fn.isdirectory(current .. "/" .. marker) == 1 or 
         vim.fn.filereadable(current .. "/" .. marker) == 1 then
        return current
      end
    end
    current = vim.fn.fnamemodify(current, ":h")
  end
  
  -- No marker found, use current file's directory
  return vim.fn.expand("%:p:h")
end

-- Check if .clangd needs update (old or invalid format)
local function needs_update(clangd_file)
  if vim.fn.filereadable(clangd_file) == 0 then
    return true  -- File doesn't exist
  end
  
  -- Read file and check if it has -xc++ flag (new format)
  local file = io.open(clangd_file, "r")
  if not file then
    return true
  end
  
  local content = file:read("*all")
  file:close()
  
  -- If file doesn't contain -xc++ flag, it's old and needs update
  if not content:match("-xc++") then
    return true
  end
  
  return false  -- File is up to date
end

-- Auto-generate .clangd when opening C++ files
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = {"*.cpp", "*.hpp", "*.cc", "*.h", "*.cxx", "*.hxx"},
  callback = function()
    -- Wait a bit for file to be fully loaded
    vim.defer_fn(function()
      local root = find_root()
      local clangd_file = root .. "/.clangd"
      
      -- Generate if file doesn't exist or needs update
      if needs_update(clangd_file) then
        -- Change to root directory temporarily
        local original_cwd = vim.fn.getcwd()
        vim.cmd("cd " .. root)
        
        -- Generate .clangd
        local ok, err = pcall(function()
          require("config.clangd_generator").generate_clangd()
        end)
        
        if not ok then
          vim.notify("Failed to generate .clangd: " .. tostring(err), vim.log.levels.WARN)
        end
        
        -- Restore original directory
        vim.cmd("cd " .. original_cwd)
      end
    end, 100)  -- 100ms delay
  end,
})

-- Manual keybinding is still registered in clangd-gen.lua plugin

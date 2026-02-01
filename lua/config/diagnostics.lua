-- Enhanced diagnostics and error logging configuration
local M = {}

-- Show all LSP and formatter errors
function M.show_logs()
  -- Open LSP log
  vim.cmd("edit " .. vim.lsp.get_log_path())
end

-- Show conform (formatter) errors
function M.show_conform_errors()
  local conform = require("conform")
  local formatters = conform.list_formatters()
  
  print("=== Conform Formatter Status ===")
  for _, formatter in ipairs(formatters) do
    print(string.format("- %s: %s", formatter.name, formatter.available and "✓ Available" or "✗ Not available"))
  end
  
  -- Check for current buffer filetype
  local ft = vim.bo.filetype
  local ft_formatters = conform.list_formatters_for_buffer()
  print(string.format("\n=== Formatters for filetype '%s' ===", ft))
  for _, name in ipairs(ft_formatters) do
    print(string.format("- %s", name))
  end
end

-- Enhanced diagnostic display settings
function M.setup()
  -- Configure diagnostic display
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●',
      source = "if_many",  -- Show source if multiple sources
    },
    float = {
      source = "always",  -- Always show source in floating window
      border = "rounded",
      header = "",
      prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
  
  -- Define diagnostic signs
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
  }
  
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- Keybindings for diagnostics
function M.setup_keymaps()
  vim.keymap.set('n', '<leader>xd', vim.diagnostic.open_float, { desc = "Show diagnostic details" })
  vim.keymap.set('n', '<leader>xl', M.show_logs, { desc = "Show LSP logs" })
  vim.keymap.set('n', '<leader>xf', M.show_conform_errors, { desc = "Show formatter status" })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
end

return M

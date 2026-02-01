return {
  "neovim/nvim-lspconfig",
  keys = {
    { "<leader>cc", function()
      require("config.clangd_generator").generate_clangd()
    end, desc = "Generate .clangd config" },
  },
  -- NOTE: autocmd logic moved to lua/config/auto_clangd.lua
  -- This is loaded directly from init.lua to avoid plugin conflicts
}

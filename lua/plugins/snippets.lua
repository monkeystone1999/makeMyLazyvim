return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      
      -- 기본 스니펫 로드 (friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- 커스텀 Lua 스니펫 로드
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/snippets"
      })
      
      -- 스니펫 설정
      luasnip.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    end,
    keys = {
      { "<leader>ss", "<cmd>lua require('luasnip.loaders').edit_snippet_files()<cr>", desc = "스니펫 편집" },
    },
  },
  
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}

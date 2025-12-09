return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("mason").setup()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup({
  -- [수정] 여기서 "neocmakelsp"를 지워주세요! 에러의 원인입니다.
  ensure_installed = { "clangd", "bashls" }, 
  
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,

    ["clangd"] = function()
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      })
    end,

    -- [유지] 이 설정은 지우지 마세요! 우리가 수동으로 설치하면 이 설정이 적용됩니다.
    ["neocmakelsp"] = function()
      require("lspconfig").neocmakelsp.setup({
        capabilities = capabilities,
      })
    end,
  },
})
      -- CMP(자동완성) 설정은 그대로 유지
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

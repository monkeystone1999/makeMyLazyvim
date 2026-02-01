return {
  {
    "neovim/nvim-lspconfig",
    -- Load LSP plugin when opening C/C++ files
    event = {"BufReadPre *.cpp", "BufReadPre *.hpp", "BufReadPre *.c", "BufReadPre *.h", "BufReadPre *.cc", "BufReadPre *.cxx"},
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("mason").setup()
      
      -- Ensure clangd starts automatically for C/C++ files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"c", "cpp"},
        callback = function()
          -- Check if LSP is already attached
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          local has_clangd = false
          for _, client in pairs(clients) do
            if client.name == "clangd" then
              has_clangd = true
              break
            end
          end
          
          -- Start clangd if not already running
          if not has_clangd then
            vim.cmd("LspStart clangd")
          end
        end,
      })
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
          "--header-insertion-decorators=0",  -- Treat .h as C++ headers
          "--completion-style=detailed",
          "--enable-config",           -- Use .clangd config files
          "--fallback-style=llvm",
          "--query-driver=**",
          -- Removed --function-arg-placeholders to fix parameter completion
          -- C++ standard will auto-detect from compile_commands.json or CMakeLists.txt
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
      -- CMP(자동완성) 설정 + 스니펫 지원
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = nil,
          
          -- Tab: 완성 확정 또는 다음 파라미터로 이동
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump() -- 스니펫 확장 또는 다음 파라미터로 점프
            else
              fallback()
            end
          end, { "i", "s" }),
          
          -- Shift-Tab: 이전 파라미터로 이동
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1) -- 이전 파라미터로 점프
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      })
    end,
  },
}

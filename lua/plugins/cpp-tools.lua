-- lua/plugins/cpp-tools.lua
return {
  -- 1. Clangd 확장 도구 (C/C++ 개발 필수품)
  -- 기능: 헤더<->소스 전환, AST 시각화, 메모리 사용량 확인 등
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          -- 힌트 스타일 설정
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
        },
      })
    end,
    keys = {
      { "<leader>gh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "헤더/소스 파일 전환" },
      { "<leader>at", "<cmd>ClangdAST<cr>", desc = "코드 구조(AST) 보기" },
    },
  },

  -- 2. Trouble (에러 목록 보기)
  -- 기능: 프로젝트 전체의 에러와 경고를 깔끔한 리스트로 보여줍니다.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "에러 목록(Diagnostics) 토글" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "현재 파일 에러만 보기" },
    },
  },

  -- 3. Neogen (주석 자동 생성기)
  -- 기능: 함수 위에서 명령어를 치면 Doxygen 스타일 주석 템플릿을 만들어줍니다.
  {
    "danymat/neogen",
    config = true,
    -- C/C++ 용 Doxygen 스타일 설정
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      { "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc = "함수/클래스 주석 생성 (Doxygen)" },
    },
  },
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- 파일을 열 때 로딩
  opts = {
    -- 1. 언어별로 사용할 포매터 지정
    formatters_by_ft = {
      lua = { "stylua" }, -- Lua 파일은 stylua 사용
      c = { "clang-format" }, -- C 파일
      cpp = { "clang-format" }, -- C++ 파일
      -- "clang-format"이 없으면 자동으로 LSP(clangd)에게 정렬을 요청합니다.
    },

    -- 2. 저장 시 자동 정렬 설정 (원치 않으시면 이 부분을 지우세요)
    format_on_save = {
      lsp_fallback = true, -- 포매터가 없으면 LSP(clangd)를 사용
      async = false,
      timeout_ms = 500,
    },
  },

  -- 3. 단축키 설정
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      mode = "",
      desc = "코드 정렬 (Format)",
    },
  },
}

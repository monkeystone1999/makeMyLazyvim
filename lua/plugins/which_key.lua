return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- 0.3초 기다리면 메뉴가 뜸
  end,
  opts = {
    -- 여기에 그룹 이름을 정해줄 수 있습니다.
    spec = {
      { "<leader>c", group = "Code/CMake (코드/빌드)" },
      { "<leader>d", group = "Debug (디버깅)" },
      { "<leader>f", group = "File (파일/검색)" },
      { "<leader>g", group = "Git (버전관리)" },
      { "<leader>t", group = "Terminal (터미널)" },
      { "<leader>x", group = "Diagnostics (에러)" },
    },
  },
}

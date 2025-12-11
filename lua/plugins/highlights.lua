return {
  -- 1. 괄호 무지개색 하이라이팅 (C++의 복잡한 괄호 지옥 탈출)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      -- 특별한 설정 없이 설치만 해도 작동합니다.
    end,
  },

  -- 2. 특수 주석 하이라이팅 (TODO, FIXME, BUG, HACK 등)
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {
      -- 아이콘과 색상을 설정합니다. (기본값이 아주 훌륭합니다)
      signs = true, 
    },
    keys = {
      -- <leader>ft (Find Todo)를 누르면 프로젝트 내 모든 TODO를 검색합니다.
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO 주석 검색" },
    },
  },
}

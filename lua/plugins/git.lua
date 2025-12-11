return {
  -- 1. Gitsigns: 코드 옆에 변경 사항 표시 (가장 기본적이고 필수)
  -- 기능: 추가된 줄(초록), 삭제된 줄(빨강), 수정된 줄(파랑)을 라인 넘버 옆에 표시해줍니다.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      -- 현재 줄을 누가 언제 고쳤는지 흐릿하게 보여줌 (Blame)
      current_line_blame = true, 
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol", -- 문장 끝에 표시
      },
    },
    keys = {
      -- 변경된 덩어리(Hunk) 단위로 이동
      { "]c", "<cmd>Gitsigns next_hunk<cr>", desc = "다음 변경 사항으로 이동" },
      { "[c", "<cmd>Gitsigns prev_hunk<cr>", desc = "이전 변경 사항으로 이동" },
      -- 덩어리 미리보기 (수정 전 코드 보기)
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "변경 사항 미리보기" },
      -- 덩어리 되돌리기
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "이 부분 되돌리기 (Reset)" },
    },
  },

  -- 2. Lazygit: 터미널 기반 Git GUI의 끝판왕
  -- 주의: 컴퓨터에 'lazygit' 프로그램이 설치되어 있어야 합니다.
  -- (MacOS: brew install lazygit / Ubuntu: go install ... 등)
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- 팝업 창을 띄우기 위해 toggleterm 의존성 필요 (없어도 되지만 있으면 더 좋음)
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit 열기 (Git GUI)" },
    },
  },

  -- 3. Diffview: 파일 비교 및 충돌 해결 전문 도구
  -- VS Code의 'Changes' 탭보다 훨씬 강력한 비교 화면을 제공합니다.
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff 열기 (비교 모드)" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Git Diff 닫기" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "현재 파일 변경 이력 보기" },
    },
  },
}

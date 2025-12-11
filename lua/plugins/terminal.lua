return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true, -- 기본 설정 활성화
  opts = {
    -- 1. 터미널을 껐다 켰다 할 단축키 (Ctrl + \)
    open_mapping = [[<c-\>]],

    -- 2. 터미널이 열리는 방향 (horizontal, vertical, float, tab)
    direction = "float", 

    -- 3. 플로팅 창 설정 (예쁘게)
    float_opts = {
      border = "curved", -- 둥근 테두리
      winblend = 0,      -- 투명도 (0~100)
    },
    
    -- 4. 터미널 열렸을 때 크기
    size = 20,
  },
  
  -- 터미널 모드에서 쉽게 빠져나오기 위한 키 매핑
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "플로팅 터미널 토글" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "하단 터미널 토글" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<cr>", desc = "수직 터미널 토글" },
  },
}

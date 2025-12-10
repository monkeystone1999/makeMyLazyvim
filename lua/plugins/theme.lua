return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- 테마는 시작하자마자 로딩되어야 함
    priority = 1000, -- 다른 플러그인보다 우선순위 높게 로딩
    opts = {
      -- ★ 핵심 1: 배경 투명화 (사용자 요구사항)
      -- 이 옵션이 true면 터미널의 배경색(이미지)이 그대로 비쳐 보입니다.
      transparent = true,

      -- 스타일 선택 (storm, moon, night, day)
      -- 'moon': 약간 차분한 톤 / 'storm': 대비가 좀 더 높은 톤
      style = "moon", 

      -- ★ 핵심 2: 시맨틱 하이라이팅 및 스타일 세부 설정
      styles = {
        -- 주석을 이탤릭체로 할지 여부
        comments = { italic = true },
        keywords = { italic = true },
        
        -- 배경 설정
        sidebars = "transparent", -- Neo-tree 배경도 투명하게
        floats = "transparent",   -- 둥둥 떠있는 창(LSP 도움말 등)도 투명하게
      },
      
      -- C++ 개발 시 LSP 하이라이팅 기능을 켜는 옵션 (기본값 true)
      -- clangd가 주는 정보를 받아서 변수/함수/멤버변수 색을 다르게 칠해줍니다.
      lualine_bold = true,
    },
    config = function(_, opts)
      local tokyonight = require("tokyonight")
      tokyonight.setup(opts)
      
      -- 테마 적용 명령어
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

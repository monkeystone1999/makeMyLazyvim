return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- 입력 모드에 들어갈 때 로딩
  config = true,         -- 기본 설정 사용
  opts = {
    check_ts = true,     -- Treesitter를 사용해서 문법을 더 똑똑하게 파악
    ts_config = {
      lua = { "string" },-- lua 문자열 내부에서는 짝 안 맞춤
      -- 필요한 언어 추가 가능
    },
    
    -- ★ 질문하신 기능을 위한 핵심 설정
    map_cr = true,       -- 엔터키(CR) 매핑 사용
    fast_wrap = {
      map = "<M-e>",     -- (선택) Alt+e로 빠른 감싸기 기능 사용
    },
  },
}

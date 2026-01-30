return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy", -- 코드를 짤 때 필요하므로 천천히 로딩해도 됨
  opts = {
    bind = true, -- LSP가 연결되면 자동으로 활성화
    handler_opts = {
      border = "rounded", -- 팝업 창 테두리를 둥글게
    },
    
    -- 팝업이 뜨는 위치와 스타일 설정
    floating_window = true, -- 플로팅 창 켜기
    hint_enable = true, -- (선택) 커서가 있는 줄 끝에 힌트(전구 모양 등) 표시
    hint_prefix = "🐼 ",  -- 힌트 아이콘 (원하는 걸로 변경 가능)
    
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}

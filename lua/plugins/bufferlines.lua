return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons", -- 파일 아이콘
    lazy = false,
  
  -- LazyVim처럼 Shift+H, Shift+L 로 버퍼 이동하는 키 설정
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "이전 버퍼로 이동" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "다음 버퍼로 이동" },
    -- 기존 bd(buffer delete) 대신 X(Close/X버튼) 사용
    { "<leader>X", "<cmd>bdelete<cr>", desc = "현재 버퍼 닫기 (Close)" },
     -- 현재 보고 있는 탭을 왼쪽이나 오른쪽으로 한 칸 이동시킵니다.
    { "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "버퍼를 왼쪽으로 옮기기" },
    { "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "버퍼를 오른쪽으로 옮기기" },
    { "<S-p>", "<cmd>BufferLinePick<cr>", desc = "버퍼 선택하여 이동" },
  },

  opts = {
    options = {
      -- 1. 모드 설정 (tabs 대신 buffers 추천)
      mode = "buffers",
      
      always_show_bufferline = true,
      -- 2. 버퍼 사이에 구분선 스타일 (slant, slope, thick, thin 등)
      separator_style = "slant",

      -- 3. LSP 에러가 있으면 버퍼 이름 옆에 표시
      diagnostics = "nvim_lsp",

      -- 4. 마우스 클릭 사용 가능
      clickable = true,

      -- 5. [중요] Neo-tree가 열려있으면 왼쪽 공간 비워두기
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer", -- 탐색기 위에 뜰 글자
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}

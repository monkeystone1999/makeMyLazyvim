return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", enabled = true },
    
    -- 1. FZF Native (검색 속도 향상 엔진)
    { 
      "nvim-telescope/telescope-fzf-native.nvim", 
      build = "make" -- 설치 시 컴파일 필요 (C++ 개발자시니 make는 있으시겠죠!)
    },
    
    -- 2. UI Select (선택창 디자인 통일)
    "nvim-telescope/telescope-ui-select.nvim",
  },
  
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " }, -- 파일 경로가 너무 길면 줄임
        mappings = {
          i = {
            -- 검색 창에서 Ctrl+k(위), Ctrl+j(아래)로 이동 (화살표 대신 사용)
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            
            -- 검색 결과를 Quickfix 리스트로 보내기 (나중에 한꺼번에 작업할 때 유용)
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        -- 투명 배경을 원하셨으므로, 투명도 관련 설정
        winblend = 0, 
      },
      
      -- 확장 플러그인 설정
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- 드롭다운 스타일로 깔끔하게 보여줌
          }),
        },
        fzf = {
          fuzzy = true,                   -- 오타가 나도 비슷하면 찾아줌
          override_generic_sorter = true, -- 기본 정렬 알고리즘 덮어쓰기
          override_file_sorter = true,    -- 파일 정렬 알고리즘 덮어쓰기
          case_mode = "smart_case",       -- 대소문자 스마트하게 구분
        },
      },
    })

    -- 확장 기능 로드
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,

  -- 단축키 설정
  keys = {
    -- 파일 찾기 (파일명으로 검색)
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "파일 찾기 (Find Files)" },
    
    -- 글자 찾기 (프로젝트 전체에서 특정 단어 검색 - grep)
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "단어 찾기 (Live Grep)" },
    
    -- 최근 열었던 파일 찾기
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "최근 파일 (Recent)" },
    
    -- 열려있는 버퍼 중에서 찾기
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "버퍼 찾기 (Buffers)" },
    
    -- 도움말 찾기
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "도움말 검색 (Help)" },
    
    -- ★ C/C++ 개발 꿀팁: 현재 파일의 함수/변수 목록 보기
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "함수/변수 목록 (Symbols)" },
    
    -- ★ 투두 리스트 검색 (아까 설치한 플러그인 연동)
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO 목록 검색" },
  },
}

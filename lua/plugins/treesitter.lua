return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- 설치 후 자동으로 업데이트 명령어 실행
  config = function() 
    -- 여기가 설정의 핵심입니다.
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      -- 1. 사용할 언어 목록 (C, C++, Lua, Vim 등)
      ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
      
      -- 2. 동기 설치 (에러 확인을 위해 잠시 true로 둡니다)
      sync_install = false,

      -- 3. 문법 강조(하이라이팅) 켜기
      highlight = { enable = true },

      -- 4. 들여쓰기 켜기
      indent = { enable = true },  
    })
  end
}

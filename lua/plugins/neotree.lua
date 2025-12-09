return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- 파일 아이콘
    "MunifTanjim/nui.nvim",
  },
  -- 설정 (옵션)
  opts = {
    window = {
      width = 23, -- 아까 원하셨던 너비 설정!
    },
    filesystem = {
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = true, -- 숨김 파일(.env 등) 보기
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
  -- 단축키 설정
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}

return {
  "Civitasv/cmake-tools.nvim",
  keys = {
    { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake 생성 (Generate)" },
    { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "프로젝트 빌드 (Build)" },
    { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "실행 (Run)" },
    { "<leader>cq", "<cmd>CMakeClose<cr>", desc = "CMake 터미널 닫기" },
  },
  opts = {
    cmake_command = "cmake",
    cmake_build_directory = "build", -- 빌드 폴더
    
    -- ★ 핵심: Qt/OpenSSL 인식을 위해 컴파일 정보를 반드시 생성해야 함
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, 
    
    cmake_soft_link_compile_commands = true, -- 생성된 파일을 루트로 심볼릭 링크
    cmake_runner = {
      type = "toggleterm", -- 또는 "terminal"
      opts = {
        direction = "horizontal", -- 아래쪽에 가로로 열림
        size = 10,
      }
    },
    -- 하단 상태바에 빌드 상태 표시 설정
    cmake_statusline = {
      statusbar = {
        enabled = true,
      },
    },
  },
  config = function(_, opts)
    require("cmake-tools").setup(opts)
  end,
}

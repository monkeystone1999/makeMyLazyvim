return {
  "Civitasv/cmake-tools.nvim",
  keys = {
    { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake 생성 (Generate)" },
    { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "프로젝트 빌드 (Build)" },
    { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "실행 (Run)" },
    { "<leader>cq", "<cmd>CMakeClose<cr>", desc = "CMake 터미널 닫기" },
    { "<leader>ct", function()
      require("cmake-tools").generate_cmake_template()
    end, desc = "CMakeLists.txt 템플릿 생성" },
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
    -- CMake 재생성 후 LSP 새로고침
    cmake_regenerate_on_save = false,
  },
  config = function(_, opts)
    local cmake_tools = require("cmake-tools")
    cmake_tools.setup(opts)
    
    -- CMakeLists.txt 템플릿 생성 함수
    cmake_tools.generate_cmake_template = function()
      local lines = {
        "cmake_minimum_required(VERSION 3.20)",
        "project(MyProject VERSION 1.0.0 LANGUAGES CXX)",
        "",
        "set(CMAKE_CXX_STANDARD 20)",
        "set(CMAKE_CXX_STANDARD_REQUIRED ON)",
        "set(CMAKE_CXX_EXTENSIONS OFF)",
        "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)",
        "",
        "add_executable(app src/main.cpp)",
        "target_include_directories(app PRIVATE ${CMAKE_SOURCE_DIR}/include)",
        "",
        "# Optional: Add compiler warnings",
        "target_compile_options(app PRIVATE",
        "  $<$<CXX_COMPILER_ID:GNU,Clang>:-Wall -Wextra -Wpedantic>",
        "  $<$<CXX_COMPILER_ID:MSVC>:/W4>",
        ")",
      }
      
      local file = io.open("CMakeLists.txt", "w")
      if file then
        for _, line in ipairs(lines) do
          file:write(line .. "\n")
        end
        file:close()
        vim.notify("CMakeLists.txt 템플릿이 생성되었습니다!", vim.log.levels.INFO)
        vim.cmd("edit CMakeLists.txt")
      else
        vim.notify("CMakeLists.txt 생성 실패!", vim.log.levels.ERROR)
      end
    end
  end,
}

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- 디버깅 UI (변수, 스택 등을 보여줌)
    "nvim-neotest/nvim-nio", -- 비동기 IO 라이브러리 (UI 필수)
    "jay-babu/mason-nvim-dap.nvim", -- 디버거 자동 설치 도구
  },
  config = function()
    -- 1. Mason을 통해 C++ 디버거(codelldb) 자동 설치
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
      automatic_installation = true,
      handlers = {}, 
    })

    -- 2. 디버깅 UI 설정 (시작하면 자동으로 열리고, 끝나면 닫힘)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- 3. C++ 디버깅 설정 (LLDB 연결)
    -- 만약 CMake Tools를 쓴다면 자동으로 설정되지만, 수동 설정을 위해 남겨둡니다.
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb", -- mason이 경로를 잡아줍니다.
        args = { "--port", "${port}" },
      },
    }
    
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp
  end,
}

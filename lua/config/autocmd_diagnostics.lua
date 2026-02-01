-- Diagnostic tool to check if autocmd is registered
local M = {}

function M.check_autocmds()
  print("=== Autocmd 진단 ===\n")
  
  -- Check if our autocmd is registered
  local autocmds = vim.api.nvim_get_autocmds({
    pattern = "*.cpp",
  })
  
  print("등록된 autocmd 수:", #autocmds)
  
  local found_clangd_gen = false
  for _, autocmd in ipairs(autocmds) do
    if autocmd.event == "BufReadPost" or autocmd.event == "BufNewFile" then
      print(string.format("- Event: %s, Pattern: %s", autocmd.event, vim.inspect(autocmd.pattern or "N/A")))
      
      -- Check if it's our clangd generator
      if autocmd.command and autocmd.command:match("clangd") then
        found_clangd_gen = true
        print("  ✓ clangd 자동생성 autocmd 발견!")
      end
    end
  end
  
  if not found_clangd_gen then
    print("\n❌ clangd 자동생성 autocmd가 등록되지 않음!")
    print("원인:")
    print("1. Neovim 재시작이 필요할 수 있음")
    print("2. clangd-gen.lua 플러그인이 로드되지 않음")
    print("3. 설정 파일에 문법 오류가 있을 수 있음")
  end
  
  return found_clangd_gen
end

function M.check_plugin_loaded()
  print("\n=== 플러그인 로딩 상태 ===\n")
  
  -- Check if lazy.nvim loaded our plugin
  local lazy_ok, lazy = pcall(require, "lazy")
  if not lazy_ok then
    print("❌ lazy.nvim을 로드할 수 없음")
    return
  end
  
  local plugins = lazy.plugins()
  local found_lspconfig = false
  
  for _, plugin in ipairs(plugins) do
    if plugin.name == "nvim-lspconfig" then
      found_lspconfig = true
      print("✓ nvim-lspconfig 플러그인 로드됨")
      print("  - loaded:", plugin._.loaded ~= nil)
      break
    end
  end
  
  if not found_lspconfig then
    print("❌ nvim-lspconfig 플러그인을 찾을 수 없음")
  end
end

function M.test_generator()
  print("\n=== clangd_generator 테스트 ===\n")
  
  local ok, generator = pcall(require, "config.clangd_generator")
  if not ok then
    print("❌ clangd_generator 모듈을 로드할 수 없음:", generator)
    return
  end
  
  print("✓ clangd_generator 모듈 로드 성공")
  
  -- Test if generate function exists
  if type(generator.generate_clangd) == "function" then
    print("✓ generate_clangd 함수 존재")
  else
    print("❌ generate_clangd 함수가 없음")
  end
end

function M.check_logs()
  print("\n=== LSP 로그 경로 ===\n")
  print("LSP 로그:", vim.lsp.get_log_path())
  print("\n로그 확인 명령어:")
  print("  :lua vim.cmd('edit ' .. vim.lsp.get_log_path())")
  print("  또는 tail -f " .. vim.lsp.get_log_path())
end

function M.diagnose_all()
  M.check_plugin_loaded()
  M.check_autocmds()
  M.test_generator()
  M.check_logs()
  
  print("\n\n=== 종합 진단 완료 ===")
  print("문제가 발견되면 위 메시지를 확인하세요.")
end

return M

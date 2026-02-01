-- LSP 상태 확인 도구
local M = {}

-- 현재 버퍼에 LSP가 attach되어 있는지 확인
function M.check_lsp_status()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  
  print("=== LSP 상태 확인 ===")
  print("현재 파일:", vim.api.nvim_buf_get_name(buf))
  print("파일 타입:", vim.bo.filetype)
  print("현재 디렉토리:", vim.fn.getcwd())
  
  if #clients == 0 then
    print("\n❌ LSP가 attach되지 않음!")
    print("\n해결 방법:")
    print("1. :LspInfo 명령어로 상세 정보 확인")
    print("2. :LspStart clangd 로 수동 시작")
    print("3. CMakeLists.txt가 있는 프로젝트 루트에서 작업하는지 확인")
    return false
  end
  
  print("\n✓ LSP Clients (" .. #clients .. "개):")
  for _, client in pairs(clients) do
    print("  - " .. client.name .. " (ID: " .. client.id .. ")")
  end
  
  return true
end

-- clangd 특화 진단
function M.check_clangd()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  
  print("\n=== clangd 상세 진단 ===")
  
  local has_clangd = false
  for _, client in pairs(clients) do
    if client.name == "clangd" then
      has_clangd = true
      print("✓ clangd가 실행 중입니다")
      
      -- 서버 정보
      if client.server_capabilities then
        print("\n서버 기능:")
        print("  - 자동완성:", client.server_capabilities.completionProvider and "✓" or "✗")
        print("  - 정의 이동:", client.server_capabilities.definitionProvider and "✓" or "✗")
        print("  - 호버 정보:", client.server_capabilities.hoverProvider and "✓" or "✗")
      end
    end
  end
  
  if not has_clangd then
    print("❌ clangd가 실행되지 않음!")
    print("\n가능한 원인:")
    print("1. clangd가 설치되지 않음")
    print("2. C/C++ 파일 타입이 올바르게 인식되지 않음")
    print("3. Mason에서 clangd 설치 필요")
  end
  
  -- 프로젝트 설정 확인
  print("\n=== 프로젝트 설정 ===")
  local root = vim.fn.getcwd()
  local has_cmake = vim.fn.filereadable(root .. "/CMakeLists.txt") == 1
  local has_clangd_config = vim.fn.filereadable(root .. "/.clangd") == 1
  local has_compile_db = vim.fn.filereadable(root .. "/build/compile_commands.json") == 1
  
  print("CMakeLists.txt:", has_cmake and "✓" or "✗")
  print(".clangd 설정:", has_clangd_config and "✓" or "✗")
  print("compile_commands.json:", has_compile_db and "✓" or "✗")
  
  if not has_cmake and not has_clangd_config then
    print("\n⚠️  경고: 프로젝트 설정이 없습니다!")
    print("해결 방법:")
    print("1. CMake 프로젝트: <leader>ct 로 CMakeLists.txt 생성")
    print("2. 단일 파일: <leader>cc 로 .clangd 생성")
    print("3. 또는 아래 최소 .clangd 설정 생성")
  end
end

-- 빠른 수정 제안
function M.quick_fix()
  print("\n=== 빠른 수정 ===")
  print("다음 명령어를 순서대로 시도하세요:")
  print("\n1. LSP 정보 확인:")
  print("   :LspInfo")
  print("\n2. LSP 재시작:")
  print("   :LspRestart")
  print("\n3. clangd 수동 시작:")
  print("   :LspStart clangd")
  print("\n4. .clangd 설정 생성:")
  print("   <leader>cc")
  print("\n5. 파일 타입 확인:")
  print("   :set filetype?")
  print("\n6. Neovim 재시작")
end

-- 모든 진단 실행
function M.diagnose_all()
  M.check_lsp_status()
  M.check_clangd()
  M.quick_fix()
end

-- 키바인딩 설정
function M.setup_keymaps()
  vim.keymap.set('n', '<leader>xi', M.diagnose_all, { desc = "LSP 전체 진단" })
  vim.keymap.set('n', '<leader>xc', M.check_clangd, { desc = "clangd 상태 확인" })
  vim.keymap.set('n', '<leader>xa', function()
    require("config.autocmd_diagnostics").diagnose_all()
  end, { desc = "Autocmd 진단" })
end

return M

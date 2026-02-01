-- Quick diagnostic for document symbol issues
local M = {}

function M.diagnose_symbols()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  local filetype = vim.bo.filetype
  local clients = vim.lsp.get_clients({ bufnr = buf })
  
  print("=== Document Symbol 진단 ===\n")
  print("파일:", filepath)
  print("파일 타입:", filetype)
  print("버퍼 번호:", buf)
  
  -- Check LSP clients
  if #clients == 0 then
    print("\n❌ LSP 클라이언트가 연결되지 않음!")
    print("해결: <leader>cc 후 :LspRestart")
    return
  end
  
  print("\n✓ LSP 클라이언트 (" .. #clients .. "개):")
  for _, client in pairs(clients) do
    print("  - " .. client.name)
    
    -- Check document symbol support
    if client.server_capabilities.documentSymbolProvider then
      print("    ✓ documentSymbol 지원")
    else
      print("    ✗ documentSymbol 미지원")
    end
  end
  
  -- Check file size
  local lines = vim.api.nvim_buf_line_count(buf)
  print("\n파일 정보:")
  print("  - 줄 수:", lines)
  
  -- Check if file has content
  local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local has_symbols = false
  for _, line in ipairs(content) do
    if line:match("^%s*class%s") or 
       line:match("^%s*struct%s") or
       line:match("^%s*void%s") or
       line:match("^%s*int%s") or
       line:match("^%s*template") then
      has_symbols = true
      break
    end
  end
  
  if not has_symbols then
    print("  ⚠️  클래스/함수 선언을 찾을 수 없음")
    print("  → 빈 헤더 파일이면 정상입니다")
  else
    print("  ✓ 심볼 선언 발견")
  end
  
  print("\n=== 해결 방법 ===")
  print("1. 10초 기다린 후 재시도 (인덱싱 중)")
  print("2. :LspRestart")
  print("3. <leader>cc (.clangd 재생성)")
  print("4. :Telescope treesitter (대체 방법)")
end

vim.keymap.set('n', '<leader>xs', M.diagnose_symbols, { desc = "심볼 검색 진단" })

return M

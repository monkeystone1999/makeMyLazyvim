local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. 기본 편집 편의성
map("i", "jj", "<ESC>", opts) -- 입력 모드에서 jj 누르면 ESC (국룰)
map("n", "<leader>w", ":w<CR>", opts) -- 저장 (<Space> + w)
map("n", "<leader>q", ":q<CR>", opts) -- 종료 (<Space> + q)

-- 2. 창 이동 (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- 3. LSP (코드 분석) 관련
-- gd: 정의로 이동, K: 설명 보기(Hover)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", { desc = "새 탭에서 정의 보기" })
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts) -- 변수 이름 변경
map("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- 빠른 수정 제안

-- 4. 디버깅 (DAP) 관련
local dap = require("dap")
map("n", "<F5>", dap.continue, opts) -- 디버깅 시작 / 계속
map("n", "<F10>", dap.step_over, opts) -- 한 줄 실행
map("n", "<F11>", dap.step_into, opts) -- 함수 안으로 진입
map("n", "<F12>", dap.step_out, opts) -- 함수 밖으로 나오기
map("n", "<leader>b", dap.toggle_breakpoint, opts) -- 브레이크포인트 설정/해제
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "왼쪽 창으로 이동" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "아래 창으로 이동" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "위 창으로 이동" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "오른쪽 창으로 이동" })

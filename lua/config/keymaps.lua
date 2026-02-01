local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. 기본 편집 편의성
map("i", "jj", "<ESC>", opts) -- 입력 모드에서 jj 누르면 ESC
map("n", "<leader>ww", ":w<CR>", { desc = "💾 파일 저장" })  -- ww로 변경
map("n", "<leader>q", ":q<CR>", { desc = "🚪 종료" })

-- 2. 창 이동 (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- 3. LSP (코드 분석) 관련
map("n", "gd", vim.lsp.buf.definition, { desc = "정의로 이동" })
map("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", { desc = "새 탭에서 정의" })
map("n", "K", vim.lsp.buf.hover, { desc = "문서 보기" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "이름 바꾸기" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "코드 액션" })

-- 4. 디버깅 (DAP) 관련
local dap = require("dap")
map("n", "<F5>", dap.continue, { desc = "디버깅 시작/계속" })
map("n", "<F10>", dap.step_over, { desc = "한 줄 실행" })
map("n", "<F11>", dap.step_into, { desc = "함수 안으로" })
map("n", "<F12>", dap.step_out, { desc = "함수 밖으로" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "중단점 토글" })

-- 5. 터미널 모드 창 이동
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "왼쪽 창으로" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "아래 창으로" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "위 창으로" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "오른쪽 창으로" })

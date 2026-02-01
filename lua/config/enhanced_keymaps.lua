-- Enhanced keymaps for n, r, s, w groups
local map = vim.keymap.set

-- New/Notes 그룹 (n)
map("n", "<leader>nn", ":enew<CR>", { desc = "새 파일 (New)" })
map("n", "<leader>nt", ":tabnew<CR>", { desc = "새 탭 (Tab)" })
map("n", "<leader>ns", ":split<CR>", { desc = "가로 분할 (Split)" })
map("n", "<leader>nv", ":vsplit<CR>", { desc = "세로 분할 (Vertical)" })

-- Refactor 그룹 (r) - 기본 버전 (플러그인 없이)
map("n", "<leader>ra", "<cmd>Telescope lsp_references<cr>", { desc = "모든 참조 찾기" })

-- Search/Session 그룹 (s)
map("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "명령어 이력" })
map("n", "<leader>sr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
map("n", "<leader>sh", "<cmd>Telescope search_history<cr>", { desc = "검색 이력" })

-- Workspace 그룹 (w)
map("n", "<leader>wd", ":cd %:p:h<CR>:pwd<CR>", { desc = "현재 파일 디렉토리로" })
map("n", "<leader>wl", "<cmd>Telescope workspaces<cr>", { desc = "워크스페이스 목록" })

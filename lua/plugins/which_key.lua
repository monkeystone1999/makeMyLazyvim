return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      -- 메인 그룹
      { "<leader>c", group = "💻 코드/CMake" },
      { "<leader>d", group = "🐛 디버깅" },
      { "<leader>f", group = "🔍 찾기/검색" },
      { "<leader>g", group = "🌿 Git" },
      { "<leader>h", group = "🔄 Git Hunk" },
      { "<leader>n", group = "📝 새로만들기/노트" },
      { "<leader>r", group = "♻️  리팩토링" },
      { "<leader>s", group = "🔎 검색/세션" },
      { "<leader>t", group = "📟 터미널/테스트" },
      { "<leader>w", group = "🗂️  작업공간" },
      { "<leader>x", group = "🔧 진단/오류" },
      
      -- 코드/CMake 그룹 (c)
      { "<leader>cc", desc = ".clangd 설정 생성" },
      { "<leader>cg", desc = "CMake 생성하기" },
      { "<leader>cb", desc = "CMake 빌드하기" },
      { "<leader>cr", desc = "CMake 실행하기" },
      { "<leader>cq", desc = "CMake 터미널 닫기" },
      { "<leader>ct", desc = "CMakeLists.txt 템플릿 생성" },
      { "<leader>ca", desc = "코드 액션 (빠른 수정)" },
      { "<leader>ci", desc = "나를 호출하는 함수" },
      { "<leader>co", desc = "내가 호출하는 함수" },
      
      -- 디버깅 그룹 (d)
      { "<leader>db", desc = "중단점 토글" },
      { "<leader>dc", desc = "조건부 중단점" },
      { "<leader>dt", desc = "디버그 터미널" },
      { "<leader>du", desc = "디버그 UI 토글" },
      { "<F5>", desc = "⏯️  디버깅 시작/계속" },
      { "<F10>", desc = "⏭️  한 줄 실행" },
      { "<F11>", desc = "⏬ 함수 안으로" },
      { "<leader>12>", desc = "⏫ 함수 밖으로" },
      
      -- 찾기/검색 그룹 (f)
      { "<leader>ff", desc = "파일 찾기" },
      { "<leader>fw", desc = "단어 찾기" },
      { "<leader>fr", desc = "최근 파일" },
      { "<leader>fb", desc = "버퍼 찾기" },
      { "<leader>fh", desc = "도움말 검색" },
      { "<leader>fs", desc = "현재 문서 심볼" },
      { "<leader>ft", desc = "TODO 주석 찾기" },
      { "<leader>fm", desc = "코드 정렬 (포맷팅)" },
      
      -- Git 그룹 (g)
      { "<leader>gg", desc = "LazyGit 열기" },
      { "<leader>gd", desc = "Git Diff 열기" },
      { "<leader>gD", desc = "Git Diff 닫기" },
      { "<leader>gl", desc = "파일 변경 이력" },
      { "<leader>gb", desc = "브랜치 목록" },
      { "<leader>gs", desc = "Git 상태 보기" },
      { "<leader>gh", desc = "헤더/소스 파일 전환" },
      
      -- Git Hunk 그룹 (h)
      { "<leader>hp", desc = "변경사항 미리보기" },
      { "<leader>hr", desc = "변경사항 되돌리기" },
      { "<leader>hs", desc = "변경사항 스테이징" },
      { "<leader>hu", desc = "스테이징 취소" },
      { "[c", desc = "이전 변경사항" },
      { "]c", desc = "다음 변경사항" },
      
      -- 새로만들기/노트 그룹 (n)
      { "<leader>nf", desc = "함수 주석 생성" },
      { "<leader>nn", desc = "새 파일" },
      { "<leader>nt", desc = "새 탭" },
      { "<leader>ns", desc = "가로 분할" },
      { "<leader>nv", desc = "세로 분할" },
      
      -- 리팩토링 그룹 (r)
      { "<leader>rn", desc = "이름 바꾸기" },
      { "<leader>rf", desc = "함수 추출하기" },
      { "<leader>rv", desc = "변수 추출하기" },
      { "<leader>ri", desc = "Import 정리하기" },
      { "<leader>ra", desc = "모든 참조 찾기" },
      
      -- 검색/세션 그룹 (s)
      { "<leader>sk", desc = "키맵 검색" },
      { "<leader>ss", desc = "스니펫 편집" },
      { "<leader>sc", desc = "명령어 이력" },
      { "<leader>sr", desc = "레지스터 보기" },
      { "<leader>sm", desc = "마크 보기" },
      { "<leader>sh", desc = "검색 이력" },
      { "<leader>sl", desc = "세션 불러오기" },
      { "<leader>sS", desc = "세션 저장하기" },
      
      -- 터미널/테스트 그룹 (t)
      { "<leader>tt", desc = "플로팅 터미널" },
      { "<leader>th", desc = "하단 터미널" },
      { "<leader>tv", desc = "수직 터미널" },
      { "<leader>tg", desc = "LazyGit 터미널" },
      { "<leader>tn", desc = "새 터미널" },
      
      -- 작업공간 그룹 (w)
      { "<leader>ws", desc = "프로젝트 전체 심볼 찾기" },
      { "<leader>wd", desc = "작업 디렉토리 변경" },
      { "<leader>wl", desc = "작업공간 목록" },
      { "<leader>wa", desc = "작업공간 추가" },
      { "<leader>wr", desc = "작업공간 제거" },
      { "<leader>ww", desc = "💾 파일 저장" },
      
      -- 진단/오류 그룹 (x)
      { "<leader>xx", desc = "오류 목록 전체" },
      { "<leader>xX", desc = "현재 파일 오류만" },
      { "<leader>xi", desc = "LSP 전체 진단" },
      { "<leader>xc", desc = "clangd 상태 확인" },
      { "<leader>xa", desc = "자동명령 진단" },
      { "<leader>xf", desc = "포맷터 상태 확인" },
      { "<leader>xl", desc = "LSP 로그 보기" },
      { "<leader>xd", desc = "진단 세부정보" },
      { "<leader>xs", desc = "심볼 검색 진단" },
      
      -- 기본 동작
      { "<leader>e", desc = "파일 탐색기" },
      { "<leader>w", desc = "💾 파일 저장" },
      { "<leader>q", desc = "🚪 종료" },
      { "<leader>X", desc = "버퍼 닫기" },
      
      -- LSP 네비게이션
      { "gd", desc = "정의로 이동" },
      { "gD", desc = "새 탭에서 정의 열기" },
      { "gr", desc = "참조 찾기" },
      { "gi", desc = "구현부 찾기" },
      { "K", desc = "문서 보기 (호버)" },
      { "[d", desc = "⬆️  이전 오류" },
      { "]d", desc = "⬇️  다음 오류" },
      
      -- C++ 도구
      { "<leader>at", desc = "코드 구조 보기 (AST)" },
      
      -- 버퍼 네비게이션
      { "<S-h>", desc = "⬅️  이전 버퍼" },
      { "<S-l>", desc = "➡️  다음 버퍼" },
      { "<S-p>", desc = "🎯 버퍼 선택" },
      { "<A-h>", desc = "⬅️  버퍼를 왼쪽으로" },
      { "<A-l>", desc = "➡️  버퍼를 오른쪽으로" },
    },
  },
}

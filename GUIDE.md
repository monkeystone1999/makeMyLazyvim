# Neovim C++ 개발 환경 완벽 가이드

## 📚 목차
1. [주요 기능](#주요-기능)
2. [키바인딩](#키바인딩)
3. [문제 해결](#문제-해결)

---

## 🎯 주요 기능

### C++ Intellisense
- ✅ `.h` / `.hpp` 파일 모두 C++ 헤더로 인식
- ✅ `std::` 자동완성 즉시 작동
- ✅ clangd 자동 시작
- ✅ `.clangd` 자동 생성

### 프로젝트 심볼 검색
```vim
<leader>fs  " 현재 파일 심볼
<leader>ws  " 프로젝트 전체 심볼 ⭐
<leader>fw  " 단어 검색
```

---

## ⌨️ 키바인딩

### 📂 워크스페이스 (w)
| 키 | 기능 |
|----|------|
| `<leader>w` | 💾 파일 저장 |
| `<leader>ws` | 프로젝트 전체 심볼 |
| `<leader>wd` | 현재 디렉토리로 변경 |

### 🔍 검색 (f)
| 키 | 기능 |
|----|------|
| `<leader>ff` | 파일 찾기 |
| `<leader>fw` | 단어 검색 |
| `<leader>fs` | 문서 심볼 |
| `<leader>fb` | 버퍼 찾기 |

### 💻 코드 (c)
| 키 | 기능 |
|----|------|
| `<leader>cc` | .clangd 생성 |
| `<leader>cb` | CMake 빌드 |
| `<leader>cr` | 실행 |

### 🌿 Git (g)
| 키 | 기능 |
|----|------|
| `<leader>gg` | LazyGit |
| `<leader>gd` | Diff |
| `<leader>gl` | 파일 이력 |

### 🔧 진단 (x)
| 키 | 기능 |
|----|------|
| `<leader>xi` | LSP 진단 |
| `<leader>xc` | clangd 상태 |
| `<leader>xx` | 에러 목록 |

[전체 키바인딩: `<leader>` 눌러서 확인]

---

## 🔧 문제 해결

### 자동완성 안 됨
```vim
1. <leader>cc     " .clangd 생성
2. :LspRestart    " LSP 재시작
3. 10초 대기
4. std:: 입력해서 테스트
```

### 심볼 검색 안 됨
```vim
<leader>xs        " 진단 실행
:Telescope treesitter  " 대체 방법
```

### :LspInfo 없음
**원인**: Neovim 재시작 필요
**해결**: 모든 nvim 종료 후 재시작

### Deprecated 경고
`init.lua`에 이미 추가됨:
```lua
vim.deprecate = function() end
```

---

## 🚀 LazyGit 설치

```bash
# Ubuntu
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update && sudo apt install lazygit

# 또는 바이너리
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz && sudo install lazygit /usr/local/bin
```

---

## 📝 추가 플러그인 (선택)

### Session Manager
`lua/plugins/session.lua`:
```lua
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    { "<leader>sl", function() require("persistence").load() end, desc = "세션 로드" },
  },
}
```

### Refactoring
`lua/plugins/refactoring.lua`:
```lua
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
  keys = {
    { "<leader>rf", mode = "v", desc = "함수 추출" },
  },
}
```

---

## 💡 빠른 진단

### LSP 문제
```vim
:LspInfo          " 상태 확인
<leader>xi        " 전체 진단
<leader>xl        " 로그 보기
```

### 로그 확인
```vim
:lua vim.cmd('edit ' .. vim.lsp.get_log_path())
```

---

**모든 기능이 자동으로 작동합니다!** 🎉

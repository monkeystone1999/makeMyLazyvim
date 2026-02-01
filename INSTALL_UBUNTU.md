# Ubuntu 의존성 설치 가이드

Neovim C++ 개발 환경을 위한 완전한 설치 가이드입니다.

---

## 📋 목차
1. [시스템 요구사항](#시스템-요구사항)
2. [필수 의존성](#필수-의존성)
3. [선택 의존성](#선택-의존성)
4. [설치 확인](#설치-확인)
5. [문제 해결](#문제-해결)

---

## 💻 시스템 요구사항

- **OS**: Ubuntu 20.04 이상 (22.04/24.04 권장)
- **디스크**: 최소 2GB 여유 공간
- **메모리**: 최소 4GB RAM

---

## 🔧 필수 의존성

### 1. 시스템 업데이트

```bash
sudo apt update
sudo apt upgrade -y
```

### 2. 기본 빌드 도구

```bash
sudo apt install -y \
  build-essential \
  cmake \
  git \
  curl \
  wget \
  unzip
```

**포함 내용**:
- `gcc`, `g++`: C/C++ 컴파일러
- `cmake`: 빌드 시스템
- `git`: 버전 관리
- `curl`, `wget`: 파일 다운로드

---

### 3. Neovim (최신 버전)

#### 방법 1: PPA 사용 (권장)
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
```

#### 방법 2: AppImage (최신 버전 보장)
```bash
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# 확인
nvim --version
```

**필요 버전**: v0.9.0 이상 (v0.10+ 권장)

---

### 4. Node.js (LSP 서버용)

```bash
# NodeSource 저장소 추가
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Node.js 설치
sudo apt install -y nodejs

# 확인
node --version  # v20.x 이상
npm --version
```

---

### 5. Python (일부 플러그인용)

```bash
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv

# neovim 파이썬 지원
python3 -m pip install --user pynvim
```

---

### 6. C++ LSP 서버 (clangd)

```bash
# clangd 설치
sudo apt install -y clangd

# 또는 최신 버전 (권장)
sudo apt install -y clangd-18

# clangd를 기본으로 설정
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-18 100

# 확인
clangd --version
```

---

### 7. 코드 포맷터

```bash
# clang-format (C++ 포맷터)
sudo apt install -y clang-format

# 확인
clang-format --version
```

---

### 8. 검색 도구 (Telescope용)

```bash
# ripgrep (빠른 검색)
sudo apt install -y ripgrep

# fd (파일 찾기)
sudo apt install -y fd-find

# fd 심볼릭 링크 생성
sudo ln -s $(which fdfind) /usr/local/bin/fd

# 확인
rg --version
fd --version
```

---

### 9. Git 도구

```bash
# Git (보통 이미 설치됨)
sudo apt install -y git

# LazyGit (Git GUI)
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install -y lazygit

# 확인
git --version
lazygit --version
```

---

## 🎨 선택 의존성

### 1. 추가 LSP 서버 (필요시)

```bash
# Bash LSP
npm install -g bash-language-server

# Lua LSP (Neovim 설정 편집용)
# Mason에서 자동 설치됨
```

### 2. 디버거

```bash
# GDB (C++ 디버거)
sudo apt install -y gdb

# 확인
gdb --version
```

### 3. 폰트 (선택사항)

```bash
# Nerd Fonts (아이콘 표시용)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# JetBrainsMono Nerd Font 다운로드
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip

# 폰트 캐시 갱신
fc-cache -fv
```

**터미널 설정**: 터미널 폰트를 "JetBrainsMono Nerd Font"로 변경

---

## 📦 Neovim 플러그인 의존성

Neovim을 처음 실행하면 자동으로 설치됩니다:

```bash
# Neovim 실행
nvim

# lazy.nvim이 자동으로 플러그인 설치
# Mason이 LSP 서버 자동 설치
# 모두 완료될 때까지 대기 (1-2분)
```

**설치되는 것들**:
- lazy.nvim (플러그인 관리자)
- Mason (LSP/도구 관리자)
- Treesitter (구문 강조)
- Telescope (검색)
- 기타 플러그인들

---

## ✅ 설치 확인

모든 의존성이 설치되었는지 확인:

```bash
# 버전 확인 스크립트
cat << 'EOF' > /tmp/check_deps.sh
#!/bin/bash
echo "=== 의존성 확인 ==="
echo ""

check_cmd() {
    if command -v $1 &> /dev/null; then
        echo "✓ $1: $(command -v $1)"
        $2 2>&1 | head -1
    else
        echo "✗ $1: 설치 안 됨"
    fi
    echo ""
}

check_cmd nvim "nvim --version"
check_cmd node "node --version"
check_cmd npm "npm --version"
check_cmd python3 "python3 --version"
check_cmd clangd "clangd --version"
check_cmd clang-format "clang-format --version"
check_cmd rg "rg --version"
check_cmd fd "fd --version"
check_cmd git "git --version"
check_cmd lazygit "lazygit --version"
check_cmd cmake "cmake --version"
check_cmd gdb "gdb --version"

echo "=== 완료 ==="
EOF

chmod +x /tmp/check_deps.sh
/tmp/check_deps.sh
```

**예상 출력**:
```
✓ nvim: /usr/bin/nvim
NVIM v0.10.0

✓ node: /usr/bin/node
v20.x.x

✓ clangd: /usr/bin/clangd
clangd version 18.x.x
...
```

---

## 🚀 빠른 설치 스크립트

모든 것을 한 번에 설치:

```bash
#!/bin/bash
# 한 번에 모두 설치

set -e

echo "📦 시스템 업데이트..."
sudo apt update && sudo apt upgrade -y

echo "🔧 기본 도구 설치..."
sudo apt install -y build-essential cmake git curl wget unzip

echo "📝 Neovim 설치..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

echo "🟢 Node.js 설치..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "🐍 Python 설치..."
sudo apt install -y python3 python3-pip python3-venv
python3 -m pip install --user pynvim

echo "💻 C++ 도구 설치..."
sudo apt install -y clangd-18 clang-format
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-18 100

echo "🔍 검색 도구 설치..."
sudo apt install -y ripgrep fd-find
sudo ln -sf $(which fdfind) /usr/local/bin/fd

echo "🌿 Git 도구 설치..."
sudo add-apt-repository -y ppa:lazygit-team/release
sudo apt update
sudo apt install -y lazygit

echo "🐛 디버거 설치..."
sudo apt install -y gdb

echo "✅ 모든 설치 완료!"
echo ""
echo "다음 단계:"
echo "1. 터미널을 닫고 다시 열기"
echo "2. nvim을 실행하여 플러그인 자동 설치"
echo "3. <leader>를 눌러 키바인딩 확인"
```

**사용법**:
```bash
# 스크립트 저장
curl -LO https://raw.githubusercontent.com/YOUR_REPO/install.sh

# 실행 권한 부여
chmod +x install.sh

# 실행
./install.sh
```

---

## 🔧 문제 해결

### Neovim 버전이 너무 낮음
```bash
# PPA로 재설치
sudo apt remove neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

### clangd를 찾을 수 없음
```bash
# 직접 경로 확인
which clangd

# PPA에서 재설치
sudo apt install clangd-18
sudo update-alternatives --config clangd
```

### lazy.nvim 플러그인 설치 실패
```bash
# Neovim에서
:Lazy sync
:Lazy clean
:Lazy restore
```

### Mason LSP 설치 실패
```bash
:Mason
# UI에서 i 눌러 수동 설치
# 또는
:MasonInstall clangd bash-language-server
```

### Python 지원 안 됨
```bash
# pynvim 재설치
python3 -m pip install --upgrade pynvim

# Neovim에서 확인
:checkhealth provider
```

---

## 📊 최소 vs 권장 설치

### 최소 설치 (C++ 개발만)
```bash
sudo apt install -y \
  neovim \
  clangd \
  clang-format \
  ripgrep \
  fd-find \
  git
```

### 권장 설치 (모든 기능)
위의 "빠른 설치 스크립트" 사용

---

## 🎯 설치 후 첫 실행

```bash
# 1. Neovim 실행
nvim

# 2. 플러그인 자동 설치 대기 (1-2분)

# 3. 확인
:checkhealth

# 4. 테스트 파일 열기
nvim test.cpp

# 5. 키바인딩 확인
<leader>
```

---

**모든 의존성 설치 완료!** 🎉

문제가 있으면 `:checkhealth` 실행

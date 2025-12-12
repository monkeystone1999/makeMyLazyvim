-- 1. 리더 키 설정 (스페이스바)
-- 플러그인 로드 전에 설정해야 합니다.
vim.g.mapleader = " "
vim.g.maplocalleader = " "
  
-- 배경 투명화 강제 적용 (치트키)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- 2. Lazy.nvim (플러그인 매니저) 자동 설치 코드
-- 내 컴퓨터에 lazy.nvim이 없으면 깃허브에서 받아옵니다.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

pcall(require, "config.keymaps")
-- 3. 플러그인 로드 및 설정 시작
require("lazy").setup({
  -- "lua/plugins" 폴더 안에 있는 모든 lua 파일을 플러그인으로 인식해라!
  spec = {
    { import = "plugins" },
  },
  -- (선택) 설치 화면 디자인 설정
  ui = { border = "rounded" },
})

-- 4. 기본 옵션 (줄 번호 등) - 나중에 따로 파일로 뺄 수 있지만 일단 여기에 둡니다.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true    -- 윗줄의 들여쓰기를 그대로 따라감
vim.opt.smartindent = true   -- C언어 스타일의 문법을 인식해서 들여쓰기 (중괄호 다음 등)
vim.opt.breakindent = true   -- 줄바꿈 시 들여쓰기 유지

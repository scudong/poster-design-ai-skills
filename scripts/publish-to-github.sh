#!/bin/bash

# 海报设计 AI 技能工具包 - GitHub 发布脚本
# 
# 功能：
# 1. 检查 Git 状态
# 2. 创建发布分支
# 3. 添加所有文件
# 4. 创建版本标签
# 5. 推送到 GitHub

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log() {
  echo -e "${CYAN}$1${NC}"
}

success() {
  echo -e "${GREEN}✅ $1${NC}"
}

warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
  echo -e "${RED}❌ $1${NC}"
}

# 检查 Git 是否安装
if ! command -v git &> /dev/null; then
  error "Git 未安装，请先安装 Git"
  exit 1
fi

# 检查是否在 Git 仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  error "当前目录不是 Git 仓库"
  exit 1
fi

log "\n============================================================"
log "🚀 海报设计 AI 技能工具包 - GitHub 发布"
log "============================================================\n"

# 获取版本号
VERSION=$(node -p "require('./package.json').version")
log "📦 当前版本：v$VERSION"

# 检查 Git 状态
log "\n📋 检查 Git 状态..."
git status

# 检查是否有未提交的更改
if ! git diff-index --quiet HEAD --; then
  warning "检测到未提交的更改"
  read -p "是否继续？(y/n): " confirm
  
  if [ "$confirm" != "y" ]; then
    log "发布已取消"
    exit 0
  fi
  
  # 添加并提交所有更改
  log "\n📝 添加并提交所有更改..."
  git add .
  git commit -m "chore: 更新技能工具包 v$VERSION"
fi

# 创建发布标签
TAG_NAME="v$VERSION"

log "\n🏷️  创建发布标签：$TAG_NAME"

# 检查标签是否已存在
if git rev-parse "$TAG_NAME" >/dev/null 2>&1; then
  warning "标签 $TAG_NAME 已存在"
  read -p "是否删除并重新创建？(y/n): " confirm
  
  if [ "$confirm" = "y" ]; then
    git tag -d "$TAG_NAME"
    git push origin :refs/tags/"$TAG_NAME" 2>/dev/null || true
  else
    log "发布已取消"
    exit 0
  fi
fi

# 创建新标签
git tag -a "$TAG_NAME" -m "Release v$VERSION - 海报设计 AI 技能工具包"

success "标签 $TAG_NAME 创建成功"

# 显示发布信息
log "\n📋 发布信息:"
log "  版本：v$VERSION"
log "  标签：$TAG_NAME"
log "  日期：$(date '+%Y-%m-%d %H:%M:%S')"

# 推送到 GitHub
log "\n📤 推送到 GitHub..."

# 检查远程仓库
REMOTE=$(git remote get-url origin 2>/dev/null || echo "")

if [ -z "$REMOTE" ]; then
  error "未配置远程仓库"
  log "请使用以下命令添加远程仓库:"
  log "  git remote add origin https://github.com/your-username/poster-design-ai-skills.git"
  exit 1
fi

log "远程仓库：$REMOTE"

read -p "是否推送到 GitHub？(y/n): " confirm

if [ "$confirm" = "y" ]; then
  # 推送分支
  git push origin main
  
  # 推送标签
  git push origin "$TAG_NAME"
  
  success "推送成功！"
  
  # 显示 GitHub Release 链接
  REPO_URL=$(echo "$REMOTE" | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')
  
  log "\n============================================================"
  success "发布完成！"
  log "============================================================"
  log "\n📢 下一步操作:"
  log "1. 访问 GitHub 创建 Release:"
  log "   $REPO_URL/releases/new?tag=$TAG_NAME"
  log ""
  log "2. 填写 Release 说明（可参考 RELEASE_NOTES.md）"
  log ""
  log "3. 添加附件（可选）"
  log ""
  log "4. 点击 'Publish release'"
  log "============================================================\n"
  
else
  warning "推送已取消"
  log "\n标签已在本地创建，但未推送到远程仓库"
  log "使用以下命令手动推送:"
  log "  git push origin main"
  log "  git push origin $TAG_NAME"
fi

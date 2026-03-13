#!/bin/bash

# 海报设计 AI 技能工具包 - macOS 一键安装脚本
# 使用方法：bash install-macos.sh

set -e

echo "🎨 海报设计 AI 技能工具包 - macOS 一键安装"
echo "==========================================="
echo ""

# 步骤 1：克隆仓库
echo "📦 步骤 1/4：克隆仓库..."
if [ -d ~/poster-skills ]; then
    echo "⚠️  目录 ~/poster-skills 已存在，跳过克隆"
else
    git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
    echo "✅ 克隆完成"
fi
echo ""

# 步骤 2：进入目录
echo "📂 步骤 2/4：进入项目目录..."
cd ~/poster-skills
echo "✅ 当前目录：$(pwd)"
echo ""

# 步骤 3：检查依赖（可选）
echo "📋 步骤 3/4：检查 Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js 已安装：$NODE_VERSION"
else
    echo "⚠️  Node.js 未安装，请前往 https://nodejs.org/ 下载安装"
    echo "   或者使用 Homebrew 安装：brew install node"
fi
echo ""

# 步骤 4：配置 Claude Desktop
echo "⚙️  步骤 4/4：配置 Claude Desktop..."
echo ""

# 找到 Claude Desktop 配置目录
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

# 创建配置目录（如果不存在）
mkdir -p "$CONFIG_DIR"

# 获取当前用户名
USERNAME=$(whoami)
SKILLS_PATH="/Users/$USERNAME/poster-skills/skills/index.js"

echo "📝 配置文件路径：$CONFIG_FILE"
echo "📍 技能路径：$SKILLS_PATH"
echo ""

# 备份现有配置
if [ -f "$CONFIG_FILE" ]; then
    echo "⚠️  发现现有配置文件，创建备份..."
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
    echo "✅ 备份完成：$CONFIG_FILE.backup.*"
    echo ""
fi

# 创建新配置
echo "🔧 创建 MCP 配置..."
cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "poster-skills": {
      "command": "node",
      "args": ["$SKILLS_PATH"],
      "cwd": "/Users/$USERNAME/poster-skills",
      "env": {}
    }
  }
}
EOF

echo "✅ 配置完成"
echo ""

# 显示配置内容
echo "📋 配置内容："
echo "-------------"
cat "$CONFIG_FILE"
echo "-------------"
echo ""

# 完成
echo "🎉 安装完成！"
echo ""
echo "下一步操作："
echo "  1. 完全退出 Claude Desktop（菜单栏 → Quit）"
echo "  2. 重新打开 Claude Desktop"
echo "  3. 左下角出现 🔨 锤子图标 = 安装成功 ✅"
echo ""
echo "使用方法："
echo "  在 Claude Desktop 中输入："
echo "  - 使用 Midjourney 主海报生成技能，生成一个科技峰会海报"
echo "  - 使用 NanoBanana 系列海报批量，生成虚拟主播 IP 宣传系列"
echo ""
echo "📚 文档："
echo "  - 安装教程：~/poster-skills/INSTALL.md"
echo "  - 使用文档：~/poster-skills/USAGE.md"
echo "  - GitHub: https://github.com/scudong/poster-design-ai-skills"
echo ""

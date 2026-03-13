#!/bin/bash

# MCP 服务器连接问题 - 自动修复脚本

set -e

echo "🔧 MCP 服务器连接问题 - 自动修复"
echo "================================="
echo ""

# 获取当前用户名
USERNAME=$(whoami)
SKILLS_PATH="/Users/$USERNAME/poster-skills/skills/index.js"
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

# 步骤 1：检查项目是否存在
echo "📂 步骤 1/5：检查项目..."
if [ ! -d ~/poster-skills ]; then
    echo "❌ 项目不存在，正在克隆..."
    git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
    echo "✅ 克隆完成"
else
    echo "✅ 项目已存在"
fi
echo ""

# 步骤 2：检查技能文件
echo "📋 步骤 2/5：检查技能文件..."
SKILL_COUNT=$(ls ~/poster-skills/skills/*.json 2>/dev/null | wc -l)
if [ "$SKILL_COUNT" -eq 8 ]; then
    echo "✅ 找到 $SKILL_COUNT 个技能文件"
else
    echo "❌ 技能文件不完整（找到 $SKILL_COUNT 个，需要 8 个）"
    echo "正在重新克隆项目..."
    rm -rf ~/poster-skills
    git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
    echo "✅ 克隆完成"
fi
echo ""

# 步骤 3：检查 Node.js
echo "📦 步骤 3/5：检查 Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js 已安装：$NODE_VERSION"
else
    echo "❌ Node.js 未安装"
    echo ""
    echo "请安装 Node.js："
    echo "  1. 使用 Homebrew: brew install node"
    echo "  2. 或从官网下载：https://nodejs.org/"
    echo ""
    exit 1
fi
echo ""

# 步骤 4：检查 index.js
echo "📄 步骤 4/5：检查 index.js..."
if [ -f "$SKILLS_PATH" ]; then
    echo "✅ index.js 存在：$SKILLS_PATH"
else
    echo "❌ index.js 不存在"
    echo "正在重新克隆项目..."
    rm -rf ~/poster-skills
    git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
    echo "✅ 克隆完成"
fi
echo ""

# 步骤 5：更新 Claude Desktop 配置
echo "⚙️  步骤 5/5：更新配置..."

# 创建配置目录
mkdir -p "$CONFIG_DIR"

# 备份现有配置
if [ -f "$CONFIG_FILE" ]; then
    echo "📋 备份现有配置..."
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
    echo "✅ 备份完成：$CONFIG_FILE.backup.*"
    echo ""
fi

# 创建新配置
echo "🔧 创建新配置..."
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

# 显示配置
echo "📋 配置内容："
echo "-------------"
cat "$CONFIG_FILE"
echo "-------------"
echo ""

# 测试服务器
echo "🧪 测试服务器..."
if node "$SKILLS_PATH" 2>&1 | head -5 | grep -q "已加载 8 个技能"; then
    echo "✅ 服务器启动正常"
else
    echo "⚠️  服务器启动可能有问题，请检查日志"
fi
echo ""

# 完成
echo "✅ 修复完成！"
echo ""
echo "下一步操作："
echo "  1. 完全退出 Claude Desktop（菜单栏 → Quit）"
echo "  2. 重新打开 Claude Desktop"
echo "  3. 左下角出现 🔨 锤子图标 = 安装成功 ✅"
echo ""
echo "如仍有问题，请查看："
echo "  - 故障排查文档：~/poster-skills/TROUBLESHOOTING_MCP.md"
echo "  - GitHub Issues: https://github.com/scudong/poster-design-ai-skills/issues"
echo ""

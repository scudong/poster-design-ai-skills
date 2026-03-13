#!/bin/bash

# 海报设计 AI 技能工具包 - MCP 配置自动修复脚本
# 用途：自动修复 MCP Server 配置，确保所有 8 个技能都能正常加载

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔧 开始修复 MCP 配置..."
echo ""

# 检查项目路径
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_INDEX="$PROJECT_DIR/skills/index.js"

# 检查 index.js 是否存在
if [ ! -f "$SKILLS_INDEX" ]; then
    echo -e "${RED}❌ 错误：找不到 skills/index.js 文件${NC}"
    echo "当前目录：$PROJECT_DIR"
    exit 1
fi

echo -e "${GREEN}✅ 找到技能文件：$SKILLS_INDEX${NC}"

# 检查 JSON 文件数量
JSON_COUNT=$(ls "$PROJECT_DIR/skills/"*.json 2>/dev/null | wc -l)
echo "📊 检测到 $JSON_COUNT 个技能文件"

if [ "$JSON_COUNT" -lt 8 ]; then
    echo -e "${YELLOW}⚠️  警告：技能文件少于 8 个，可能不完整${NC}"
fi

# 获取 Claude Desktop 配置文件路径
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

# 创建配置目录（如果不存在）
mkdir -p "$CONFIG_DIR"

# 备份现有配置
if [ -f "$CONFIG_FILE" ]; then
    BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo -e "${GREEN}✅ 已备份现有配置：$BACKUP_FILE${NC}"
fi

# 写入新配置
cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "poster-skills": {
      "command": "node",
      "args": [
        "$SKILLS_INDEX"
      ],
      "cwd": "$PROJECT_DIR",
      "env": {}
    }
  },
  "preferences": {
    "coworkWebSearchEnabled": true,
    "coworkScheduledTasksEnabled": false,
    "ccdScheduledTasksEnabled": false,
    "sidebarMode": "chat"
  }
}
EOF

echo -e "${GREEN}✅ 配置已更新：$CONFIG_FILE${NC}"
echo ""

# 显示配置信息
echo "📋 配置详情："
echo "   工作目录：$PROJECT_DIR"
echo "   技能入口：$SKILLS_INDEX"
echo "   技能数量：$JSON_COUNT 个"
echo ""

# 验证配置
echo "🔍 验证配置..."
if command -v jq &> /dev/null; then
    if jq -e . "$CONFIG_FILE" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ 配置文件格式正确${NC}"
    else
        echo -e "${RED}❌ 配置文件格式错误${NC}"
        exit 1
    fi
else
    # 没有 jq，使用简单验证
    if grep -q '"mcpServers"' "$CONFIG_FILE"; then
        echo -e "${GREEN}✅ 配置文件基本正确${NC}"
    fi
fi

echo ""
echo "============================================"
echo -e "${GREEN}✅ MCP 配置修复完成！${NC}"
echo "============================================"
echo ""
echo "📌 下一步操作："
echo ""
echo "1️⃣  重启 Claude Desktop"
echo "   - 完全退出（菜单栏 → Quit）"
echo "   - 重新打开 Claude Desktop"
echo ""
echo "2️⃣  验证技能加载"
echo "   - 在 Claude Desktop 中查看技能列表"
echo "   - 应该显示 8 个技能（4 个 Midjourney + 4 个 NanoBanana）"
echo ""
echo "3️⃣  测试技能"
echo "   - 使用任意一个技能生成海报提示词"
echo "   - 检查输出是否包含英文 + 中文 + 解析"
echo ""
echo "🎨 技能列表："
echo "   Midjourney 系列（4 个）："
echo "   - midjourney-poster-generator"
echo "   - midjourney-style-matcher"
echo "   - midjourney-composition-optimizer"
echo "   - midjourney-series-generator"
echo ""
echo "   NanoBanana 系列（4 个）："
echo "   - nanobanana-poster-generator"
echo "   - nanobanana-style-matcher"
echo "   - nanobanana-composition-optimizer"
echo "   - nanobanana-series-generator"
echo ""
echo "============================================"
echo ""

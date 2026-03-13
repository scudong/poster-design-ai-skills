#!/bin/bash

# 海报设计 AI 技能 - MCP 完全重置脚本
# 用途：清除所有缓存，强制重新加载所有 8 个技能

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   MCP 完全重置工具 - 强制重新加载所有技能          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# 步骤 1: 检查 Claude Desktop 是否正在运行
echo -e "${YELLOW}步骤 1: 检查 Claude Desktop 状态...${NC}"
if pgrep -x "Claude" > /dev/null; then
    echo -e "${YELLOW}⚠️  Claude Desktop 正在运行，正在关闭...${NC}"
    killall "Claude" 2>/dev/null || true
    sleep 2
    echo -e "${GREEN}✅ Claude Desktop 已关闭${NC}"
else
    echo -e "${GREEN}✅ Claude Desktop 未运行${NC}"
fi
echo ""

# 步骤 2: 清除 MCP 缓存
echo -e "${YELLOW}步骤 2: 清除 MCP 缓存...${NC}"
CACHE_DIR="$HOME/Library/Application Support/Claude"

# 查找并清除所有可能的缓存
if [ -d "$CACHE_DIR" ]; then
    # 清除 MCP 相关缓存
    find "$CACHE_DIR" -name "*mcp*" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$CACHE_DIR" -name "*cache*" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$CACHE_DIR" -name "*.cache" -type f -delete 2>/dev/null || true
    
    echo -e "${GREEN}✅ MCP 缓存已清除${NC}"
else
    echo -e "${YELLOW}⚠️  缓存目录不存在${NC}"
fi
echo ""

# 步骤 3: 验证项目文件
echo -e "${YELLOW}步骤 3: 验证项目文件...${NC}"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_INDEX="$PROJECT_DIR/skills/index.js"

if [ ! -f "$SKILLS_INDEX" ]; then
    echo -e "${RED}❌ 错误：找不到 skills/index.js${NC}"
    exit 1
fi

# 统计 JSON 文件数量
JSON_COUNT=$(ls "$PROJECT_DIR/skills/"*.json 2>/dev/null | wc -l)
echo "📊 检测到 $JSON_COUNT 个技能文件"

if [ "$JSON_COUNT" -eq 8 ]; then
    echo -e "${GREEN}✅ 所有 8 个技能文件都存在${NC}"
else
    echo -e "${RED}❌ 警告：技能文件数量不正确（应该是 8 个）${NC}"
fi

# 验证每个 JSON 文件
echo ""
echo "验证 JSON 文件格式..."
ERROR_COUNT=0
for file in "$PROJECT_DIR/skills/"*.json; do
    if node -e "JSON.parse(require('fs').readFileSync('$file', 'utf-8'))" 2>/dev/null; then
        echo -e "  ✅ $(basename "$file")"
    else
        echo -e "  ${RED}❌ $(basename "$file") - JSON 格式错误${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
done

if [ $ERROR_COUNT -gt 0 ]; then
    echo -e "${RED}❌ 发现 $ERROR_COUNT 个文件格式错误${NC}"
    exit 1
fi
echo ""

# 步骤 4: 更新 MCP 配置
echo -e "${YELLOW}步骤 4: 更新 MCP 配置...${NC}"
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

# 创建配置目录
mkdir -p "$CONFIG_DIR"

# 备份现有配置
if [ -f "$CONFIG_FILE" ]; then
    BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo -e "${GREEN}✅ 已备份配置：$BACKUP_FILE${NC}"
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

# 步骤 5: 测试 MCP Server
echo -e "${YELLOW}步骤 5: 测试 MCP Server...${NC}"
echo "启动 MCP Server 进行自检..."

# 使用 timeout 运行，避免阻塞
timeout 2 node "$SKILLS_INDEX" > /tmp/mcp_test.log 2>&1 || true

if [ -f /tmp/mcp_test.log ]; then
    if grep -q "Poster Design AI Skills MCP Server" /tmp/mcp_test.log; then
        echo -e "${GREEN}✅ MCP Server 启动正常${NC}"
    else
        echo -e "${YELLOW}⚠️  MCP Server 输出日志：${NC}"
        cat /tmp/mcp_test.log
    fi
    rm -f /tmp/mcp_test.log
fi
echo ""

# 步骤 6: 显示配置信息
echo -e "${YELLOW}步骤 6: 配置信息${NC}"
echo "工作目录：$PROJECT_DIR"
echo "技能入口：$SKILLS_INDEX"
echo "配置文件：$CONFIG_FILE"
echo ""

# 显示技能列表
echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           即将加载的技能列表 (8 个)                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}Midjourney 系列（4 个）:${NC}"
echo "  1. midjourney-poster-generator"
echo "  2. midjourney-style-matcher"
echo "  3. midjourney-composition-optimizer"
echo "  4. midjourney-series-generator"
echo ""

echo -e "${BLUE}NanoBanana 系列（4 个）:${NC}"
echo "  5. nanobanana-poster-generator"
echo "  6. nanobanana-style-matcher"
echo "  7. nanobanana-composition-optimizer"
echo "  8. nanobanana-series-generator"
echo ""

# 完成
echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            ✅ MCP 重置完成！                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}📌 下一步操作：${NC}"
echo ""
echo "1️⃣  打开 Claude Desktop"
echo "   在应用程序文件夹中找到 Claude 并打开"
echo ""
echo "2️⃣  等待 MCP Server 加载"
echo "   启动时可能会看到 '正在加载技能...' 提示"
echo "   等待几秒钟，让所有技能加载完成"
echo ""
echo "3️⃣  验证技能加载"
echo "   在 Claude 中输入：'显示所有可用的技能'"
echo "   应该看到完整的 8 个技能列表"
echo ""
echo "4️⃣  测试技能"
echo "   尝试使用：'使用 Midjourney 主海报生成技能'"
echo "   检查输出是否包含英文 + 中文 + 解析"
echo ""

echo -e "${YELLOW}⚠️  如果仍然只显示 1 个技能：${NC}"
echo ""
echo "可能原因："
echo "  • Claude Desktop 使用了旧的缓存"
echo "  • MCP Server 进程未完全重启"
echo ""
echo "解决方案："
echo "  1. 完全关闭 Claude Desktop（菜单栏 → Quit）"
echo "  2. 打开活动监视器，确认没有 'Claude' 进程"
echo "  3. 重新打开 Claude Desktop"
echo "  4. 如果还不行，重启电脑"
echo ""

echo -e "${BLUE}============================================${NC}"
echo ""

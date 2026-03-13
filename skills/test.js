#!/bin/bash

# 测试 MCP 服务器是否正常工作

echo "🎨 海报设计 AI 技能工具包 - 测试"
echo "================================"
echo ""

# 检查技能文件
SKILLS_DIR="$(dirname "$0")"
echo "📂 技能目录：$SKILLS_DIR"
echo ""

# 统计技能数量
SKILL_COUNT=$(ls "$SKILLS_DIR"/*.json 2>/dev/null | wc -l)
echo "📊 找到 $SKILL_COUNT 个技能文件"
echo ""

# 列出所有技能
echo "📋 技能列表："
echo "------------"
for file in "$SKILLS_DIR"/*.json; do
    if [ -f "$file" ]; then
        name=$(basename "$file" .json)
        echo "  ✅ $name"
    fi
done
echo "------------"
echo ""

# 检查 index.js
if [ -f "$SKILLS_DIR/index.js" ]; then
    echo "✅ index.js 存在"
    echo ""
    echo "🔍 测试运行："
    node "$SKILLS_DIR/index.js"
else
    echo "⚠️  index.js 不存在"
fi

echo ""
echo "✅ 测试完成！"

#!/bin/bash

# 批量更新技能文件，添加中文文字要求

set -e

SKILLS_DIR="$(dirname "$0")/skills"

echo "🔧 开始更新技能文件..."
echo ""

# 更新每个技能文件
for file in "$SKILLS_DIR"/*.json; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "处理：$filename"
        
        # 使用 Node.js 安全地更新 JSON
        node -e "
const fs = require('fs');
const file = '$file';

try {
  const skill = JSON.parse(fs.readFileSync(file, 'utf-8'));
  
  // 更新 systemPrompt，添加中文文字要求
  if (skill.systemPrompt) {
    // 检查是否已经包含中文文字要求
    if (!skill.systemPrompt.includes('中文文字') && !skill.systemPrompt.includes('Chinese typography')) {
      // 在输出格式后添加中文文字要求
      const chineseTextInstruction = '\\n\\n重要：海报上的文字必须使用中文（汉字），包括标题、副标题、正文等所有文字元素。确保中文字体清晰可读，使用专业中文字体（如思源黑体、站酷高端黑、造字工房字体等）。';
      
      // 找到输出格式的位置，在其后添加
      if (skill.systemPrompt.includes('输出格式：')) {
        skill.systemPrompt = skill.systemPrompt.replace(
          '输出格式：',
          '重要要求：海报上的所有文字必须使用中文（汉字），包括标题、副标题、正文、装饰文字等。使用专业中文字体（如思源黑体、站酷高端黑、造字工房字体等），确保中文排版美观可读。\\n\\n输出格式：'
        );
      } else {
        skill.systemPrompt += chineseTextInstruction;
      }
    }
  }
  
  // 更新 description
  if (skill.description) {
    if (!skill.description.includes('中文文字')) {
      skill.description = skill.description.replace(
        /（英文/,
        '（中文文字 + 英文'
      );
      skill.description = skill.description.replace(
        /英文 \+ 中文/,
        '中文文字 + 英文 + 中文'
      );
    }
  }
  
  // 更新 examples 中的 output，添加中文文字说明
  if (skill.examples && skill.examples.length > 0) {
    skill.examples.forEach(example => {
      if (example.output && !example.output.includes('中文文字')) {
        // 在提示词解析前添加中文文字说明
        if (example.output.includes('【提示词解析】')) {
          const chineseTextNote = '【中文文字要求】海报上的所有文字使用中文（汉字），包括标题、副标题、正文等，使用专业中文字体\\n\\n';
          example.output = example.output.replace(
            '【提示词解析】',
            '【中文文字要求】海报上的所有文字使用中文（汉字），包括标题、副标题、正文等，使用专业中文字体（如思源黑体、站酷高端黑等）\\n\\n【提示词解析】'
          );
        }
      }
    });
  }
  
  // 写回文件
  fs.writeFileSync(file, JSON.stringify(skill, null, 2) + '\\n', 'utf-8');
  console.log('  ✅ 更新完成');
} catch (error) {
  console.error('  ❌ 错误:', error.message);
  process.exit(1);
}
"
    fi
done

echo ""
echo "✅ 所有技能文件更新完成！"
echo ""
echo "📝 更新内容："
echo "  • 添加中文文字要求到 systemPrompt"
echo "  • 更新 description 说明"
echo "  • 在 examples 中添加中文文字说明"
echo ""

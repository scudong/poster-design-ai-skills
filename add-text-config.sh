#!/bin/bash

# 批量更新技能文件，添加文字配置功能

set -e

SKILLS_DIR="$(dirname "$0")/skills"

echo "🔧 开始更新技能文件，添加文字配置功能..."
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
  
  // 1. 更新 systemPrompt，添加文字配置说明
  if (skill.systemPrompt) {
    const textConfigInstruction = \`
  
文字配置功能（可选）：
如果用户提供文字配置，请严格按照以下要求生成提示词：
- 文字内容：使用用户指定的确切文字
- 文字位置：按照用户要求布局（顶部居中、底部居右、左侧垂直等）
- 文字样式：使用指定的字体风格（粗体、细体、书法体等）
- 文字格式：控制字号大小、颜色、透明度、间距等
- 文字效果：添加阴影、描边、发光、渐变等特效

如果没有提供文字配置，则自动根据主题生成合适的中文文字。\`;

    if (!skill.systemPrompt.includes('文字配置功能')) {
      // 在输出格式后添加
      if (skill.systemPrompt.includes('输出格式：')) {
        skill.systemPrompt = skill.systemPrompt.replace(
          '输出格式：',
          textConfigInstruction + '\\n\\n输出格式：'
        );
      } else {
        skill.systemPrompt += textConfigInstruction;
      }
    }
  }
  
  // 2. 更新 inputSchema，添加文字配置字段
  if (skill.inputSchema && skill.inputSchema.properties) {
    const textConfig = {
      textConfig: {
        type: 'object',
        description: '文字配置（可选），用于精确控制海报上的文字内容、位置、样式和格式',
        properties: {
          title: {
            type: 'string',
            description: '主标题文字内容（如：\"2026 未来科技峰会\"）'
          },
          subtitle: {
            type: 'string',
            description: '副标题文字内容（如：\"探索·创新·突破\"）'
          },
          bodyText: {
            type: 'string',
            description: '正文文字内容（如：活动时间、地点、主办方等详细信息）'
          },
          position: {
            type: 'string',
            description: '文字整体布局位置',
            enum: [
              '顶部居中',
              '顶部居左',
              '顶部居右',
              '中部居中',
              '中部居左',
              '中部居右',
              '底部居中',
              '底部居左',
              '底部居右',
              '左侧垂直',
              '右侧垂直',
              '自定义位置'
            ]
          },
          titleStyle: {
            type: 'object',
            description: '主标题样式配置',
            properties: {
              fontFamily: {
                type: 'string',
                description: '字体名称（如：思源黑体 Bold、站酷高端黑、书法体等）',
                enum: [
                  '思源黑体 Bold',
                  '思源黑体 Regular',
                  '思源宋体 Bold',
                  '思源宋体 Regular',
                  '站酷高端黑',
                  '站酷黄油体',
                  '阿里巴巴普惠体 Bold',
                  '书法体',
                  '手写体',
                  '艺术字体'
                ]
              },
              fontSize: {
                type: 'string',
                description: '字号大小',
                enum: ['超大 (占画面 20-30%)', '大 (占画面 15-20%)', '中 (占画面 10-15%)', '小 (占画面 5-10%)']
              },
              fontWeight: {
                type: 'string',
                description: '字体粗细',
                enum: ['特粗', '粗体', '常规', '细体', '特细']
              },
              color: {
                type: 'string',
                description: '文字颜色（如：白色、金色渐变、霓虹蓝色等）'
              },
              spacing: {
                type: 'string',
                description: '字间距',
                enum: ['特宽', '宽', '正常', '窄', '特窄']
              }
            }
          },
          subtitleStyle: {
            type: 'object',
            description: '副标题样式配置',
            properties: {
              fontFamily: {
                type: 'string',
                description: '字体名称'
              },
              fontSize: {
                type: 'string',
                description: '字号大小',
                enum: ['大', '中', '小', '微小']
              },
              fontWeight: {
                type: 'string',
                description: '字体粗细',
                enum: ['粗体', '常规', '细体']
              },
              color: {
                type: 'string',
                description: '文字颜色'
              }
            }
          },
          effects: {
            type: 'object',
            description: '文字特效配置',
            properties: {
              shadow: {
                type: 'string',
                description: '阴影效果',
                enum: ['无', '轻微阴影', '明显阴影', '发光阴影']
              },
              stroke: {
                type: 'string',
                description: '描边效果',
                enum: ['无', '细描边', '中描边', '粗描边']
              },
              glow: {
                type: 'string',
                description: '发光效果',
                enum: ['无', '微弱发光', '明显发光', '强烈发光']
              },
              gradient: {
                type: 'string',
                description: '渐变效果',
                enum: ['无', '线性渐变', '径向渐变', '角度渐变']
              }
            }
          }
        }
      }
    };
    
    // 添加到 inputSchema
    if (!skill.inputSchema.properties.textConfig) {
      skill.inputSchema.properties.textConfig = textConfig.textConfig;
      
      // 更新 required 字段（如果存在）
      if (skill.inputSchema.required) {
        // textConfig 是可选的，不添加到 required
      }
    }
  }
  
  // 3. 更新 examples，添加文字配置示例
  if (skill.examples && skill.examples.length > 0) {
    skill.examples.forEach((example, index) => {
      // 只在第一个 example 中添加文字配置示例
      if (index === 0 && example.input && !example.input.textConfig) {
        example.input.textConfig = {
          title: '2026 未来科技峰会',
          subtitle: '探索·创新·突破',
          bodyText: '2026 年 3 月 15-17 日 | 北京·国家会议中心',
          position: '顶部居中',
          titleStyle: {
            fontFamily: '思源黑体 Bold',
            fontSize: '超大 (占画面 20-30%)',
            fontWeight: '粗体',
            color: '白色渐变到霓虹蓝',
            spacing: '宽'
          },
          subtitleStyle: {
            fontFamily: '思源黑体 Regular',
            fontSize: '中',
            fontWeight: '常规',
            color: '浅灰色'
          },
          effects: {
            shadow: '轻微阴影',
            stroke: '无',
            glow: '微弱发光',
            gradient: '线性渐变'
          }
        };
        
        // 更新 output，添加文字配置说明
        if (example.output && !example.output.includes('文字配置')) {
          const textConfigNote = \`【文字配置说明】
• 主标题：\"2026 未来科技峰会\" - 思源黑体 Bold，超大字号，顶部居中，白色渐变到霓虹蓝
• 副标题：\"探索·创新·突破\" - 思源黑体 Regular，中号字号，主标题下方，浅灰色
• 正文：\"2026 年 3 月 15-17 日 | 北京·国家会议中心\" - 底部居中，小号字号
• 文字效果：轻微阴影 + 微弱发光 + 线性渐变，增强科技感和可读性

\`;
          // 在中文文字要求后添加
          if (example.output.includes('【中文文字要求】')) {
            example.output = example.output.replace(
              '【中文文字要求】',
              textConfigNote + '【中文文字要求】'
            );
          }
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
echo "  • 添加文字配置功能说明到 systemPrompt"
echo "  • 在 inputSchema 中添加 textConfig 字段"
echo "  • 包含：title, subtitle, bodyText, position, titleStyle, subtitleStyle, effects"
echo "  • 在 examples 中添加文字配置示例"
echo ""

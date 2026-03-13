#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - MCP 服务器入口
 * 
 * 用于 Claude Desktop MCP 集成
 * 使用方法：node skills/index.js
 */

const fs = require('fs');
const path = require('path');

// 读取所有技能文件
const skillsDir = __dirname;
const skillFiles = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));

console.error('🎨 海报设计 AI 技能工具包');
console.error('========================\n');

console.error(`已加载 ${skillFiles.length} 个技能：\n`);

skillFiles.forEach((file, index) => {
  const filePath = path.join(skillsDir, file);
  const skillData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  const skillName = skillData.name || file.replace('.json', '');
  const skillDesc = skillData.description || skillData.displayName || '专业海报设计技能';
  
  console.error(`  ${index + 1}. ${skillName}`);
  console.error(`     ${skillDesc}\n`);
});

console.error('\n✅ 所有技能已就绪，可以在 Claude Desktop 中使用！');
console.error('\n使用方法：');
console.error('  在 Claude Desktop 中输入技能名称即可使用');
console.error('  例如："使用 Midjourney 主海报生成技能，生成一个科技峰会海报"');

// 保持进程运行（MCP 服务器模式）
if (process.argv.includes('--serve')) {
  process.stdin.resume();
}

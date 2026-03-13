#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - 技能测试脚本
 * 
 * 功能：测试每个技能的基本功能
 */

const fs = require('fs');
const path = require('path');

// 颜色输出
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m'
};

function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

// 测试技能配置
function testSkillConfig(skillData, fileName) {
  const tests = [];
  
  // 测试 1: 基本信息
  tests.push({
    name: '基本信息完整',
    pass: !!(skillData.name && skillData.description && skillData.version),
    message: skillData.name ? `技能名：${skillData.name}` : '缺少基本信息'
  });
  
  // 测试 2: 系统提示词
  tests.push({
    name: '系统提示词质量',
    pass: skillData.systemPrompt && skillData.systemPrompt.length > 100,
    message: skillData.systemPrompt 
      ? `提示词长度：${skillData.systemPrompt.length} 字符` 
      : '缺少系统提示词'
  });
  
  // 测试 3: 输入 schema
  tests.push({
    name: '输入 Schema 有效',
    pass: !!(skillData.inputSchema && skillData.inputSchema.properties),
    message: skillData.inputSchema 
      ? `参数数量：${Object.keys(skillData.inputSchema.properties).length}` 
      : '缺少输入 Schema'
  });
  
  // 测试 4: 示例
  tests.push({
    name: '包含示例',
    pass: Array.isArray(skillData.examples) && skillData.examples.length > 0,
    message: skillData.examples 
      ? `示例数量：${skillData.examples.length}` 
      : '缺少示例'
  });
  
  // 测试 5: 输出格式
  tests.push({
    name: '输出格式定义',
    pass: !!skillData.outputFormat,
    message: skillData.outputFormat || '未定义输出格式'
  });
  
  // 测试 6: 平台标识
  tests.push({
    name: '平台标识正确',
    pass: ['midjourney', 'nanobanana'].includes(skillData.platform),
    message: `平台：${skillData.platform || '未定义'}`
  });
  
  // 输出测试结果
  log(`\n  测试：${fileName}`, 'cyan');
  
  let allPass = true;
  tests.forEach(test => {
    if (test.pass) {
      log(`    ✅ ${test.name}: ${test.message}`, 'green');
    } else {
      log(`    ❌ ${test.name}: ${test.message}`, 'red');
      allPass = false;
    }
  });
  
  return allPass;
}

// 主测试函数
function test() {
  log('\n🧪 开始测试技能...\n', 'blue');
  
  const skillsDir = path.join(process.cwd(), 'skills');
  
  if (!fs.existsSync(skillsDir)) {
    log('❌ skills 目录不存在', 'red');
    return false;
  }
  
  const files = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));
  let allPass = true;
  
  files.forEach(file => {
    const filePath = path.join(skillsDir, file);
    
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      const skillData = JSON.parse(content);
      
      const pass = testSkillConfig(skillData, file);
      
      if (!pass) {
        allPass = false;
      }
    } catch (error) {
      log(`  ❌ ${file} 测试失败：${error.message}`, 'red');
      allPass = false;
    }
  });
  
  return allPass;
}

// 运行测试
function main() {
  const pass = test();
  
  log('\n' + '='.repeat(60), 'cyan');
  
  if (pass) {
    log('✅ 所有技能测试通过！✨', 'green');
    log('='.repeat(60) + '\n', 'cyan');
    process.exit(0);
  } else {
    log('❌ 部分技能测试未通过', 'red');
    log('='.repeat(60) + '\n', 'cyan');
    process.exit(1);
  }
}

main();

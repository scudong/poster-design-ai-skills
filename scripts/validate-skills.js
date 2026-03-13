#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - 技能验证脚本
 * 
 * 功能：验证所有技能文件的格式和内容是否符合 MCP 标准
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

// 验证 JSON 文件
function validateJSON(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    const data = JSON.parse(content);
    return { valid: true, data };
  } catch (error) {
    return { valid: false, error: error.message };
  }
}

// 验证技能文件结构
function validateSkill(skillData, fileName) {
  const required = ['name', 'description', 'systemPrompt', 'inputSchema'];
  const missing = required.filter(field => !skillData[field]);
  
  if (missing.length > 0) {
    return {
      valid: false,
      errors: [`缺少必需字段：${missing.join(', ')}`]
    };
  }
  
  // 验证 inputSchema
  if (skillData.inputSchema && skillData.inputSchema.type !== 'object') {
    return {
      valid: false,
      errors: ['inputSchema.type 必须是 "object"']
    };
  }
  
  // 验证 properties
  if (!skillData.inputSchema.properties) {
    return {
      valid: false,
      errors: ['缺少 inputSchema.properties']
    };
  }
  
  return { valid: true, errors: [] };
}

// 主验证函数
function validate() {
  log('\n🔍 开始验证技能文件...\n', 'blue');
  
  const skillsDir = path.join(process.cwd(), 'skills');
  const mcpConfigPath = path.join(process.cwd(), 'mcp.json');
  
  let allValid = true;
  
  // 验证 mcp.json
  log('验证 mcp.json...', 'cyan');
  const mcpResult = validateJSON(mcpConfigPath);
  
  if (mcpResult.valid) {
    log('  ✅ mcp.json 格式正确', 'green');
    
    // 验证技能列表
    if (mcpResult.data.skills && Array.isArray(mcpResult.data.skills)) {
      log(`  ✅ 包含 ${mcpResult.data.skills.length} 个技能配置`, 'green');
    } else {
      log('  ⚠️  mcp.json 中未找到 skills 数组', 'yellow');
    }
  } else {
    log(`  ❌ mcp.json 格式错误：${mcpResult.error}`, 'red');
    allValid = false;
  }
  
  // 验证所有技能文件
  log('\n验证技能文件...', 'cyan');
  
  if (!fs.existsSync(skillsDir)) {
    log('  ❌ skills 目录不存在', 'red');
    return false;
  }
  
  const files = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));
  
  if (files.length === 0) {
    log('  ❌ skills 目录中没有 JSON 文件', 'red');
    return false;
  }
  
  files.forEach(file => {
    const filePath = path.join(skillsDir, file);
    log(`\n  验证：${file}`, 'cyan');
    
    // 验证 JSON 格式
    const result = validateJSON(filePath);
    
    if (!result.valid) {
      log(`    ❌ JSON 格式错误：${result.error}`, 'red');
      allValid = false;
      return;
    }
    
    // 验证技能结构
    const skillValidation = validateSkill(result.data, file);
    
    if (!skillValidation.valid) {
      log(`    ❌ 技能结构错误：${skillValidation.errors.join(', ')}`, 'red');
      allValid = false;
      return;
    }
    
    // 验证平台类型
    const platform = result.data.platform || 'unknown';
    log(`    ✅ 平台：${platform}`, 'green');
    
    // 验证技能类型
    const type = result.data.type || 'unknown';
    log(`    ✅ 类型：${type}`, 'green');
    
    // 验证系统提示词
    if (result.data.systemPrompt && result.data.systemPrompt.length > 50) {
      log(`    ✅ 系统提示词长度：${result.data.systemPrompt.length} 字符`, 'green');
    } else {
      log(`    ⚠️  系统提示词过短`, 'yellow');
    }
    
    // 验证示例
    if (result.data.examples && result.data.examples.length > 0) {
      log(`    ✅ 包含 ${result.data.examples.length} 个示例`, 'green');
    } else {
      log(`    ⚠️  没有示例`, 'yellow');
    }
    
    log(`    ✅ ${file} 验证通过`, 'green');
  });
  
  return allValid;
}

// 运行验证
function main() {
  const isValid = validate();
  
  log('\n' + '='.repeat(60), 'cyan');
  
  if (isValid) {
    log('✅ 所有技能验证通过！✨', 'green');
    log('='.repeat(60) + '\n', 'cyan');
    process.exit(0);
  } else {
    log('❌ 部分技能验证失败，请检查上述错误', 'red');
    log('='.repeat(60) + '\n', 'cyan');
    process.exit(1);
  }
}

main();

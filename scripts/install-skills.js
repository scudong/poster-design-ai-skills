#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - 一键安装脚本
 * 
 * 功能：
 * 1. 验证 Node.js 环境
 * 2. 检查项目结构
 * 3. 复制技能文件到 Claude Desktop 目录
 * 4. 配置 MCP 设置
 * 5. 验证安装
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

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

// 检查 Node.js 版本
function checkNodeVersion() {
  log('\n📋 检查 Node.js 版本...', 'blue');
  const version = process.version;
  const major = parseInt(version.slice(1).split('.')[0]);
  
  if (major < 18) {
    log(`❌ Node.js 版本过低：${version}，需要 >= 18.0.0`, 'red');
    log('请前往 https://nodejs.org/ 下载安装最新版本', 'yellow');
    process.exit(1);
  }
  
  log(`✅ Node.js 版本：${version}`, 'green');
}

// 检查项目结构
function checkProjectStructure() {
  log('\n📋 检查项目结构...', 'blue');
  
  const requiredFiles = [
    'mcp.json',
    'package.json',
    'skills/midjourney-poster-generator.json',
    'skills/midjourney-style-matcher.json',
    'skills/midjourney-composition-optimizer.json',
    'skills/midjourney-series-generator.json',
    'skills/nanobanana-poster-generator.json',
    'skills/nanobanana-style-matcher.json',
    'skills/nanobanana-composition-optimizer.json',
    'skills/nanobanana-series-generator.json'
  ];
  
  let allExist = true;
  
  requiredFiles.forEach(file => {
    const filePath = path.join(process.cwd(), file);
    if (fs.existsSync(filePath)) {
      log(`  ✅ ${file}`, 'green');
    } else {
      log(`  ❌ ${file} 不存在`, 'red');
      allExist = false;
    }
  });
  
  if (!allExist) {
    log('\n❌ 项目结构不完整，请确保所有文件都存在', 'red');
    process.exit(1);
  }
  
  log('✅ 项目结构完整', 'green');
}

// 获取 Claude Desktop 配置目录
function getClaudeDesktopDir() {
  const platform = process.platform;
  
  if (platform === 'darwin') {
    // macOS
    return path.join(process.env.HOME, 'Library', 'Application Support', 'Claude');
  } else if (platform === 'win32') {
    // Windows
    return path.join(process.env.APPDATA, 'Claude');
  } else if (platform === 'linux') {
    // Linux
    return path.join(process.env.HOME, '.config', 'Claude');
  } else {
    return null;
  }
}

// 安装技能文件
function installSkills() {
  log('\n📦 安装技能文件...', 'blue');
  
  const claudeDir = getClaudeDesktopDir();
  
  if (!claudeDir) {
    log('⚠️  无法确定 Claude Desktop 目录，跳过技能安装', 'yellow');
    log('请手动复制 skills/ 目录下的文件到 Claude Desktop 技能目录', 'yellow');
    return false;
  }
  
  const skillsDir = path.join(claudeDir, 'skills');
  
  // 创建技能目录
  if (!fs.existsSync(skillsDir)) {
    try {
      fs.mkdirSync(skillsDir, { recursive: true });
      log(`  ✅ 创建技能目录：${skillsDir}`, 'green');
    } catch (error) {
      log(`  ❌ 创建目录失败：${error.message}`, 'red');
      log('  ⚠️  请手动复制技能文件', 'yellow');
      return false;
    }
  }
  
  // 复制技能文件
  const skillsDirSrc = path.join(process.cwd(), 'skills');
  const skillFiles = fs.readdirSync(skillsDirSrc);
  
  skillFiles.forEach(file => {
    if (file.endsWith('.json')) {
      const srcPath = path.join(skillsDirSrc, file);
      const destPath = path.join(skillsDir, file);
      
      try {
        fs.copyFileSync(srcPath, destPath);
        log(`  ✅ 复制：${file}`, 'green');
      } catch (error) {
        log(`  ❌ 复制 ${file} 失败：${error.message}`, 'red');
      }
    }
  });
  
  log(`\n✅ 技能文件已安装到：${skillsDir}`, 'green');
  return true;
}

// 配置 MCP
function configureMCP() {
  log('\n⚙️  配置 MCP...', 'blue');
  
  const claudeDir = getClaudeDesktopDir();
  
  if (!claudeDir) {
    log('⚠️  无法确定 Claude Desktop 目录，跳过 MCP 配置', 'yellow');
    return false;
  }
  
  const configPath = path.join(claudeDir, 'claude_desktop_config.json');
  const projectPath = process.cwd();
  
  // 读取或创建配置文件
  let config = {};
  
  if (fs.existsSync(configPath)) {
    try {
      const content = fs.readFileSync(configPath, 'utf8');
      config = JSON.parse(content);
      log('  ✅ 读取现有配置文件', 'green');
    } catch (error) {
      log(`  ⚠️  配置文件解析失败：${error.message}`, 'yellow');
      config = {};
    }
  } else {
    log('  📝 创建新配置文件', 'cyan');
  }
  
  // 添加 MCP 服务器配置
  if (!config.mcpServers) {
    config.mcpServers = {};
  }
  
  config.mcpServers['poster-design-skills'] = {
    command: 'node',
    args: [path.join(projectPath, 'skills', 'index.js')],
    cwd: projectPath,
    env: {}
  };
  
  // 写入配置文件
  try {
    fs.writeFileSync(configPath, JSON.stringify(config, null, 2), 'utf8');
    log(`  ✅ MCP 配置已写入：${configPath}`, 'green');
    log('\n⚠️  请重启 Claude Desktop 以加载新配置', 'yellow');
    return true;
  } catch (error) {
    log(`  ❌ 写入配置失败：${error.message}`, 'red');
    log('  ⚠️  请手动编辑 claude_desktop_config.json', 'yellow');
    return false;
  }
}

// 验证安装
function validateInstallation() {
  log('\n✅ 验证安装...', 'blue');
  
  const claudeDir = getClaudeDesktopDir();
  
  if (!claudeDir) {
    log('⚠️  无法验证安装，请手动检查', 'yellow');
    return;
  }
  
  const skillsDir = path.join(claudeDir, 'skills');
  const configPath = path.join(claudeDir, 'claude_desktop_config.json');
  
  // 检查技能文件
  if (fs.existsSync(skillsDir)) {
    const installedSkills = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));
    log(`  ✅ 已安装 ${installedSkills.length} 个技能文件`, 'green');
  } else {
    log('  ❌ 技能目录不存在', 'red');
  }
  
  // 检查配置文件
  if (fs.existsSync(configPath)) {
    try {
      const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
      if (config.mcpServers && config.mcpServers['poster-design-skills']) {
        log('  ✅ MCP 配置正确', 'green');
      } else {
        log('  ⚠️  MCP 配置中未找到 poster-design-skills', 'yellow');
      }
    } catch (error) {
      log('  ❌ 配置文件解析失败', 'red');
    }
  } else {
    log('  ❌ 配置文件不存在', 'red');
  }
}

// 显示使用说明
function showUsage() {
  log('\n' + '='.repeat(60), 'cyan');
  log('🎉 安装完成！', 'green');
  log('='.repeat(60), 'cyan');
  log('\n下一步操作:', 'blue');
  log('1. 重启 Claude Desktop', 'yellow');
  log('2. 在 Claude 中输入："列出可用的海报设计技能"', 'yellow');
  log('3. 开始使用技能生成海报提示词！', 'yellow');
  log('\n查看使用文档：USAGE.md', 'cyan');
  log('查看常见问题：INSTALL.md', 'cyan');
  log('='.repeat(60) + '\n', 'cyan');
}

// 主函数
function main() {
  log('\n' + '='.repeat(60), 'cyan');
  log('🚀 海报设计 AI 技能工具包 - 一键安装', 'cyan');
  log('='.repeat(60), 'cyan');
  
  try {
    checkNodeVersion();
    checkProjectStructure();
    
    const skillsInstalled = installSkills();
    const mcpConfigured = configureMCP();
    
    if (skillsInstalled && mcpConfigured) {
      validateInstallation();
    }
    
    showUsage();
    
  } catch (error) {
    log(`\n❌ 安装过程中出现错误：${error.message}`, 'red');
    log('请查看 INSTALL.md 获取手动安装说明', 'yellow');
    process.exit(1);
  }
}

// 运行安装
main();

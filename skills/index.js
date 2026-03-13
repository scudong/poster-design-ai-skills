#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - MCP 服务器（支持延迟加载）
 * 
 * 符合 Model Context Protocol 标准
 * 支持延迟加载技能（Lazy Loading）
 * 用于 Claude Desktop 集成
 */

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

// 技能缓存（延迟加载）
const skillsDir = __dirname;
const skillFiles = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));
const skillsCache = new Map();

// 获取技能元数据（不加载完整内容）
function getSkillMetadata(fileName) {
  const cached = skillsCache.get(fileName);
  if (cached) {
    return cached;
  }
  
  const filePath = path.join(skillsDir, fileName);
  const skillData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  
  const metadata = {
    name: skillData.name || fileName.replace('.json', ''),
    description: skillData.description || skillData.displayName || '专业海报设计技能',
    // 延迟加载这些字段
    _filePath: filePath,
    _loaded: false
  };
  
  skillsCache.set(fileName, metadata);
  return metadata;
}

// 完整加载技能（按需）
function loadSkill(fileName) {
  const cached = skillsCache.get(fileName);
  if (cached && cached._loaded) {
    return cached;
  }
  
  const filePath = path.join(skillsDir, fileName);
  const skillData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  
  const skill = {
    name: skillData.name || fileName.replace('.json', ''),
    description: skillData.description || skillData.displayName || '专业海报设计技能',
    systemPrompt: skillData.systemPrompt || '',
    examples: skillData.examples || [],
    inputSchema: skillData.inputSchema || {
      type: 'object',
      properties: {
        prompt: {
          type: 'string',
          description: '海报设计需求描述，包含主题、风格、氛围、色彩等'
        }
      },
      required: ['prompt']
    },
    _loaded: true
  };
  
  skillsCache.set(fileName, skill);
  return skill;
}

// 获取所有技能元数据（不加载完整内容）
function getAllSkillsMetadata() {
  return skillFiles.map(file => getSkillMetadata(file));
}

// 发送 JSON-RPC 响应
function sendResponse(response) {
  console.log(JSON.stringify(response));
}

// 发送错误响应
function sendError(id, code, message) {
  sendResponse({
    jsonrpc: '2.0',
    id: id,
    error: {
      code: code,
      message: message
    }
  });
}

// 发送成功响应
function sendResult(id, result) {
  sendResponse({
    jsonrpc: '2.0',
    id: id,
    result: result
  });
}

// 发送通知
function sendNotification(method, params) {
  sendResponse({
    jsonrpc: '2.0',
    method: method,
    params: params
  });
}

// 处理 initialize 请求
function handleInitialize(id, params) {
  sendResult(id, {
    protocolVersion: '2024-11-05',
    capabilities: {
      tools: {}
    },
    serverInfo: {
      name: 'poster-design-ai-skills',
      version: '1.0.0',
      description: '海报设计 AI 技能工具包 - 支持延迟加载'
    }
  });
  
  // 发送 initialized 通知
  sendNotification('notifications/initialized', {});
}

// 处理 tools/list 请求
function handleToolsList(id) {
  const tools = getAllSkillsMetadata().map(skill => ({
    name: skill.name,
    description: skill.description,
    inputSchema: {
      type: 'object',
      properties: {
        prompt: {
          type: 'string',
          description: '海报设计需求描述，包含主题、风格、氛围、色彩等'
        }
      },
      required: ['prompt']
    }
  }));
  
  sendResult(id, { tools: tools });
}

// 处理 tools/call 请求
function handleToolsCall(id, params) {
  const { name, arguments: args } = params;
  
  // 查找技能文件
  const skillFile = skillFiles.find(f => {
    const meta = getSkillMetadata(f);
    return meta.name === name;
  });
  
  if (!skillFile) {
    sendError(id, -32602, `Unknown skill: ${name}`);
    return;
  }
  
  // 延迟加载：只有在调用时才加载完整技能
  const skill = loadSkill(skillFile);
  
  // 返回技能信息
  const content = [
    {
      type: 'text',
      text: `✅ 技能已激活：${skill.name}\n\n` +
            `📝 描述：${skill.description}\n\n` +
            `🎯 系统提示：${skill.systemPrompt}\n\n` +
            `📚 示例：${skill.examples.length > 0 ? JSON.stringify(skill.examples[0], null, 2) : '无'}`
    }
  ];
  
  sendResult(id, { content: content });
}

// 处理 tools/search 请求（支持搜索技能）
function handleToolsSearch(id, params) {
  const { query } = params || {};
  
  let skills = getAllSkillsMetadata();
  
  // 如果有搜索关键词，过滤技能
  if (query && typeof query === 'string') {
    const searchQuery = query.toLowerCase();
    skills = skills.filter(skill => 
      skill.name.toLowerCase().includes(searchQuery) ||
      skill.description.toLowerCase().includes(searchQuery)
    );
  }
  
  sendResult(id, { 
    tools: skills.map(skill => ({
      name: skill.name,
      description: skill.description,
      inputSchema: {
        type: 'object',
        properties: {
          prompt: {
            type: 'string',
            description: '海报设计需求描述'
          }
        },
        required: ['prompt']
      }
    }))
  });
}

// 处理 JSON-RPC 请求
function handleRequest(request) {
  const { jsonrpc, id, method, params } = request;
  
  if (jsonrpc !== '2.0') {
    sendError(id || null, -32600, 'Invalid Request');
    return;
  }
  
  switch (method) {
    case 'initialize':
      handleInitialize(id, params);
      break;
      
    case 'tools/list':
      handleToolsList(id);
      break;
      
    case 'tools/call':
      handleToolsCall(id, params);
      break;
      
    case 'tools/search':
      handleToolsSearch(id, params);
      break;
      
    default:
      sendError(id, -32601, `Method not found: ${method}`);
  }
}

// 启动日志（延迟加载模式下，不显示技能详情）
console.error('🎨 海报设计 AI 技能工具包 MCP 服务器启动中...');
console.error('⚡ 延迟加载模式：技能将在首次调用时加载\n');
console.error(`已注册 ${skillFiles.length} 个技能（元数据）\n`);
console.error('等待 Claude Desktop 连接...\n');

// 处理输入
let buffer = '';

rl.on('line', (line) => {
  buffer += line + '\n';
  
  try {
    const request = JSON.parse(buffer.trim());
    buffer = '';
    handleRequest(request);
  } catch (e) {
    if (!line.trim()) {
      buffer = '';
    }
  }
});

// 处理错误
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  process.exit(1);
});

process.on('SIGINT', () => {
  console.error('\n服务器关闭');
  process.exit(0);
});

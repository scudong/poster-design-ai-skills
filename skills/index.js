#!/usr/bin/env node

/**
 * 海报设计 AI 技能工具包 - MCP 服务器
 * 
 * 符合 Model Context Protocol 标准
 * 用于 Claude Desktop 集成
 */

const fs = require('fs');
const path = require('path');

// MCP 协议通信
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

// 读取所有技能
const skillsDir = __dirname;
const skillFiles = fs.readdirSync(skillsDir).filter(f => f.endsWith('.json'));

const skills = skillFiles.map(file => {
  const filePath = path.join(skillsDir, file);
  const skillData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  return {
    name: skillData.name || file.replace('.json', ''),
    description: skillData.description || skillData.displayName || '专业海报设计技能',
    systemPrompt: skillData.systemPrompt || '',
    examples: skillData.examples || []
  };
});

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
      version: '1.0.0'
    }
  });
  
  // 发送 initialized 通知
  sendNotification('notifications/initialized', {});
}

// 处理 tools/list 请求
function handleToolsList(id) {
  const tools = skills.map(skill => ({
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
  
  const skill = skills.find(s => s.name === name);
  if (!skill) {
    sendError(id, -32602, `Unknown skill: ${name}`);
    return;
  }
  
  // 返回技能信息
  const content = [
    {
      type: 'text',
      text: `技能已加载：${skill.name}\n\n` +
            `描述：${skill.description}\n\n` +
            `系统提示：${skill.systemPrompt}\n\n` +
            `示例：${skill.examples.length > 0 ? JSON.stringify(skill.examples[0], null, 2) : '无'}`
    }
  ];
  
  sendResult(id, { content: content });
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
      
    default:
      sendError(id, -32601, `Method not found: ${method}`);
  }
}

// 启动日志
console.error('🎨 海报设计 AI 技能工具包 MCP 服务器启动中...');
console.error(`已加载 ${skills.length} 个技能:\n`);
skills.forEach((skill, i) => {
  console.error(`  ${i + 1}. ${skill.name}: ${skill.description}`);
});
console.error('\n等待 Claude Desktop 连接...\n');

// 处理输入
let buffer = '';

rl.on('line', (line) => {
  buffer += line + '\n';
  
  // 检查是否是完整的 JSON
  try {
    const request = JSON.parse(buffer.trim());
    buffer = '';
    handleRequest(request);
  } catch (e) {
    // 等待更多输入
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

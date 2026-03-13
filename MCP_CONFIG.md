# MCP 配置指南

## 支持 `claude mcp install` 方式

为了让 `claude mcp install https://github.com/scudong/poster-design-ai-skills` 命令生效，需要配置 MCP 服务器。

---

## 方法一：使用 GitHub MCP 服务器（推荐）

### 步骤 1：创建 MCP 服务器配置

在您的 GitHub 仓库根目录创建 `.mcp.json` 文件：

```json
{
  "name": "poster-design-ai-skills",
  "version": "1.0.0",
  "description": "海报设计 AI 技能工具包 - Midjourney + NanoBanana 双平台",
  "servers": {
    "poster-design": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-poster-design"],
      "env": {}
    }
  },
  "skills": [
    {
      "name": "midjourney-poster-generator",
      "file": "skills/midjourney-poster-generator.json"
    },
    {
      "name": "midjourney-style-matcher",
      "file": "skills/midjourney-style-matcher.json"
    },
    {
      "name": "midjourney-composition-optimizer",
      "file": "skills/midjourney-composition-optimizer.json"
    },
    {
      "name": "midjourney-series-generator",
      "file": "skills/midjourney-series-generator.json"
    },
    {
      "name": "nanobanana-poster-generator",
      "file": "skills/nanobanana-poster-generator.json"
    },
    {
      "name": "nanobanana-style-matcher",
      "file": "skills/nanobanana-style-matcher.json"
    },
    {
      "name": "nanobanana-composition-optimizer",
      "file": "skills/nanobanana-composition-optimizer.json"
    },
    {
      "name": "nanobanana-series-generator",
      "file": "skills/nanobanana-series-generator.json"
    }
  ]
}
```

### 步骤 2：发布到 npm（可选）

如要通过 `claude mcp install` 安装，需要发布到 npm：

```bash
npm publish --access public
```

### 步骤 3：用户安装

```bash
claude mcp install @modelcontextprotocol/server-poster-design
```

---

## 方法二：直接配置 Claude Desktop（当前可用）

### 步骤 1：找到 Claude Desktop 配置文件

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

### 步骤 2：添加配置

编辑配置文件，添加：

```json
{
  "mcpServers": {
    "poster-design-ai-skills": {
      "command": "node",
      "args": ["/Users/dongchangyang/Documents/trae_projects/poster-skills/dist/server.js"],
      "cwd": "/Users/dongchangyang/Documents/trae_projects/poster-skills",
      "env": {}
    }
  }
}
```

### 步骤 3：重启 Claude Desktop

完全退出并重新启动 Claude Desktop。

---

## 方法三：使用本地路径安装（最简单）

### 步骤 1：克隆项目

```bash
git clone https://github.com/scudong/poster-design-ai-skills.git
cd poster-design-ai-skills
```

### 步骤 2：配置 Claude Desktop

编辑 `claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "poster-design-ai-skills": {
      "command": "node",
      "args": ["./dist/server.js"],
      "cwd": "/path/to/poster-design-ai-skills",
      "env": {}
    }
  }
}
```

### 步骤 3：重启 Claude Desktop

---

## 当前推荐方式

由于 `claude mcp install URL` 功能还在开发中，目前推荐使用以下方式：

### 方式一：拖拽安装（最简单）✨

1. 打开 Claude Desktop
2. 将 `poster-skills-bundle.json` 拖拽到 Claude 窗口
3. 完成！

### 方式二：手动配置

按照上面的"方法二"配置 Claude Desktop。

### 方式三：使用脚本安装

```bash
git clone https://github.com/scudong/poster-design-ai-skills.git
cd poster-design-ai-skills
npm run install:skills
```

---

## 验证安装

在 Claude Desktop 中输入：

```
列出可用的海报设计技能
```

应该能看到 8 个技能。

---

## 故障排查

### 问题 1：找不到技能

**解决**: 重启 Claude Desktop

### 问题 2：配置不生效

**解决**: 检查 JSON 格式是否正确，路径是否正确

### 问题 3：技能无法使用

**解决**: 检查技能文件是否在正确位置

---

## 未来计划

我们将：
1. 发布到 npm，支持 `claude mcp install` 命令
2. 创建独立的 MCP 服务器包
3. 提供更简单的安装方式

---

<div align="center">

**Made with ❤️ - 让设计更简单**

</div>

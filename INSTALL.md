# 安装教程

本教程将指导您完成海报设计 AI 技能工具包的安装，支持多种安装方式。

---

## 📋 前置要求

### 系统要求

- **操作系统**: Windows 10/11, macOS 10.15+, Linux
- **Node.js**: >= 18.0.0
- **npm**: >= 9.0.0
- **Claude Desktop**: 最新版本 或 支持 MCP 的客户端

### 检查环境

```bash
# 检查 Node.js 版本
node -v
# 应输出：v18.x.x 或更高

# 检查 npm 版本
npm -v
# 应输出：9.x.x 或更高
```

如版本过低，请前往 [Node.js 官网](https://nodejs.org/) 下载安装。

---

## 🚀 安装方式一：通过 GitHub URL 安装（最简单）✨

这是**最简单**的安装方式，只需一条命令！

### 步骤 1：确保已安装 Claude Desktop

下载并安装最新版本的 Claude Desktop：
- macOS: https://claude.ai/download
- Windows: https://claude.ai/download

### 步骤 2：运行安装命令

```bash
claude mcp install https://github.com/scudong/poster-design-ai-skills
```

### 步骤 3：重启 Claude Desktop

完全退出 Claude Desktop 并重新启动。

### 步骤 4：验证安装

在 Claude Desktop 中输入：
```
列出可用的海报设计技能
```

如能看到 8 个技能，则安装成功。

**完成！** 🎉

---

## 🛠️ 安装方式二：克隆项目安装

### 步骤 1：找到 Claude Desktop 配置目录

**Windows:**
```
%APPDATA%\Claude\
```

**macOS:**
```
~/Library/Application Support/Claude/
```

**Linux:**
```
~/.config/Claude/
```

### 步骤 2：编辑 `claude_desktop_config.json`

在配置目录中找到或创建 `claude_desktop_config.json` 文件，添加以下内容：

```json
{
  "mcpServers": {
    "poster-design-skills": {
      "command": "node",
      "args": ["/absolute/path/to/poster-design-ai-skills/skills/index.js"],
      "cwd": "/absolute/path/to/poster-design-ai-skills",
      "env": {}
    }
  }
}
```

**重要**: 将 `/absolute/path/to/poster-design-ai-skills` 替换为实际的项目绝对路径。

### 步骤 3：复制技能文件

将 `skills/` 目录下的所有 `.json` 文件复制到 Claude Desktop 的技能目录：

**Windows:**
```
%APPDATA%\Claude\skills\
```

**macOS:**
```
~/Library/Application Support/Claude/skills/
```

**Linux:**
```
~/.config/Claude/skills/
```

### 步骤 4：重启 Claude Desktop

完全退出 Claude Desktop 并重新启动。

### 步骤 5：验证技能已加载

在 Claude Desktop 中输入：

```
列出可用的海报设计技能
```

如能看到 8 个技能，则安装成功。

---

## 🔧 安装方式三：使用 MCP CLI（开发者推荐）

### 步骤 1：安装 MCP CLI

```bash
npm install -g @anthropic/mcp-cli
```

### 步骤 2：全局安装技能

```bash
cd poster-design-ai-skills
mcp install ./mcp.json
```

### 步骤 3：验证安装

```bash
mcp list
```

应能看到 `poster-design-skills` 在列表中。

---

## 📦 安装方式四：Docker 容器化部署（企业级）

### 步骤 1：构建 Docker 镜像

```bash
docker build -t poster-skills:latest .
```

### 步骤 2：运行容器

```bash
docker run -d \
  -v $(pwd)/skills:/app/skills \
  -v $(pwd)/mcp.json:/app/mcp.json \
  --name poster-skills \
  poster-skills:latest
```

### 步骤 3：配置 Claude Desktop 连接到 Docker

在 `claude_desktop_config.json` 中添加：

```json
{
  "mcpServers": {
    "poster-design-skills": {
      "command": "docker",
      "args": ["exec", "poster-skills", "node", "/app/skills/index.js"],
      "cwd": "/app",
      "env": {}
    }
  }
}
```

---

## ✅ 验证安装

### 方法 1：使用验证脚本

```bash
npm run validate
```

输出示例：
```
✓ mcp.json 格式正确
✓ 所有技能文件存在
✓ 技能 1: midjourney-poster-generator - 验证通过
✓ 技能 2: midjourney-style-matcher - 验证通过
✓ 技能 3: midjourney-composition-optimizer - 验证通过
✓ 技能 4: midjourney-series-generator - 验证通过
✓ 技能 5: nanobanana-poster-generator - 验证通过
✓ 技能 6: nanobanana-style-matcher - 验证通过
✓ 技能 7: nanobanana-composition-optimizer - 验证通过
✓ 技能 8: nanobanana-series-generator - 验证通过

All skills validated successfully! ✨
```

### 方法 2：在 Claude Desktop 中测试

1. 打开 Claude Desktop
2. 输入测试命令：

```
使用 Midjourney 主海报生成技能，生成一个未来科技峰会海报提示词
```

3. 检查是否能正确调用技能并输出提示词

### 方法 3：运行测试套件

```bash
npm run test
```

---

## 🔍 故障排查

### 问题 1：找不到 Node.js

**错误信息**: `command not found: node`

**解决方案**:
```bash
# 安装 Node.js (macOS)
brew install node@18

# 安装 Node.js (Windows)
# 前往 https://nodejs.org/ 下载安装

# 安装 Node.js (Linux)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 问题 2：权限错误

**错误信息**: `EACCES: permission denied`

**解决方案**:
```bash
# macOS/Linux
sudo chown -R $(whoami) ~/.npm
sudo chown -R $(whoami) /path/to/poster-design-ai-skills

# 或使用 nvm 避免权限问题
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18
```

### 问题 3：Claude Desktop 不识别技能

**解决方案**:
1. 确认 `claude_desktop_config.json` 路径正确
2. 确认技能文件已复制到正确的目录
3. 完全退出 Claude Desktop（包括系统托盘）
4. 重新启动 Claude Desktop
5. 检查 Claude Desktop 是否为最新版本

### 问题 4：技能文件路径错误

**解决方案**:
```bash
# 使用绝对路径
cd /absolute/path/to/poster-design-ai-skills
pwd  # 复制输出的绝对路径

# 更新 claude_desktop_config.json 中的路径
```

### 问题 5：429 或 1113 错误

这是 API 限流或配置问题，请查看 [故障排查文档](docs/troubleshooting.md)

---

## 🔄 更新技能

### 从 GitHub 更新

```bash
cd poster-design-ai-skills
git pull origin main
npm run install:skills
npm run validate
```

### 手动更新

1. 下载最新版本的技能文件
2. 替换 `skills/` 目录下的对应文件
3. 重启 Claude Desktop

---

## 🗑️ 卸载技能

### 方法 1：使用卸载脚本

```bash
npm run uninstall:skills
```

### 方法 2：手动卸载

1. 编辑 `claude_desktop_config.json`
2. 删除 `poster-design-skills` 配置块
3. 删除技能目录中的技能文件
4. 重启 Claude Desktop

```bash
# macOS/Linux
rm -rf ~/Library/Application\ Support/Claude/skills/midjourney-*.json
rm -rf ~/Library/Application\ Support/Claude/skills/nanobanana-*.json

# Windows
del "%APPDATA%\Claude\skills\midjourney-*.json"
del "%APPDATA%\Claude\skills\nanobanana-*.json"
```

---

## 📞 获取帮助

如遇到其他问题，请：

1. 查看 [常见问题](README.md#故障排查)
2. 查阅 [故障排查文档](docs/troubleshooting.md)
3. 提交 [GitHub Issue](https://github.com/your-username/poster-design-ai-skills/issues)

---

<div align="center">

**安装完成后，请继续查看 [使用文档](USAGE.md) 了解如何使用技能**

</div>

# 安装与卸载教程

本教程将指导您完成海报设计 AI 技能工具包的安装和卸载。

---

## 📋 前置要求

### 系统要求

- **操作系统**: macOS 10.15+, Windows 10/11, Linux
- **Node.js**: >= 18.0.0
- **npm**: >= 9.0.0
- **Claude Desktop**: 最新版本

### 快速检查环境

```bash
# 检查 Node.js 版本
node -v
# 应输出：v18.x.x 或更高

# 检查 npm 版本
npm -v
# 应输出：9.x.x 或更高

# 检查 Claude Desktop 是否安装
ls -d /Applications/Claude.app 2>/dev/null || echo "未安装 Claude Desktop"
```

---

## 🆕 不满足前置条件？一键搞定！

### macOS 用户：完全自动安装（推荐）✨

如果你**没有安装 Node.js** 或 **没有安装 Claude Desktop**，使用这个超级安装脚本：

```bash
curl -fsSL https://raw.githubusercontent.com/scudong/poster-design-ai-skills/main/install-macos-complete.sh | bash
```

这个脚本会自动：
1. ✅ 检查并安装 Homebrew（如未安装）
2. ✅ 检查并安装 Node.js 18+（如未安装或版本过低）
3. ✅ 检查并安装 Claude Desktop（如未安装）
4. ✅ 克隆项目到 ~/poster-skills
5. ✅ 配置 MCP 服务器
6. ✅ 配置 Claude Desktop

**运行后等待 5-10 分钟，所有依赖自动安装完成！**

### 分步手动安装

#### 步骤 1：安装 Node.js

**方法 A：使用 Homebrew（推荐）**
```bash
# 安装 Homebrew（如未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 Node.js（包含 npm）
brew install node@18

# 验证安装
node -v
npm -v
```

**方法 B：从官网下载**
1. 访问 [Node.js 官网](https://nodejs.org/)
2. 下载 macOS 安装包（推荐 LTS 版本）
3. 双击安装
4. 验证：`node -v` 和 `npm -v`

#### 步骤 2：安装 Claude Desktop

**方法 A：使用 Homebrew（推荐）**
```bash
brew install --cask claude
```

**方法 B：官网下载**
1. 访问 [Claude 官网](https://claude.ai/download)
2. 下载 macOS 版本
3. 拖拽到 Applications 文件夹
4. 打开 Claude Desktop

#### 步骤 3：安装技能工具包

```bash
# 克隆项目
git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
cd ~/poster-skills

# 运行安装脚本
bash install-macos.sh
```

---

## 🚀 标准安装方式（已满足前置条件）

如果你已经安装了 Node.js 和 Claude Desktop，可以选择以下安装方式：

### 方式一：macOS 一键安装（最简单）✨

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/scudong/poster-design-ai-skills/main/install-macos.sh)"
```

安装脚本会自动：
1. ✅ 克隆项目到 ~/poster-skills
2. ✅ 检查 Node.js 环境
3. ✅ 配置 Claude Desktop
4. ✅ 创建 MCP 服务器配置

### 方式二：手动安装

```bash
# 1. 克隆项目
git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
cd ~/poster-skills

# 2. 运行安装脚本
bash install-macos.sh
```

### 方式三：手动配置 Claude Desktop

#### 步骤 1：找到配置目录

**macOS:**
```
~/Library/Application Support/Claude/
```

**Windows:**
```
%APPDATA%\Claude\
```

**Linux:**
```
~/.config/Claude/
```

#### 步骤 2：编辑配置文件

编辑 `claude_desktop_config.json`，添加：

```json
{
  "mcpServers": {
    "poster-design-skills": {
      "command": "node",
      "args": ["/Users/YOUR_USERNAME/poster-skills/skills/index.js"],
      "cwd": "/Users/YOUR_USERNAME/poster-skills"
    }
  }
}
```

**重要**: 替换 `YOUR_USERNAME` 为你的实际用户名。

#### 步骤 3：重启 Claude Desktop

完全退出并重新启动。

---

## ✅ 验证安装

### 方法 1：在 Claude Desktop 中测试

打开 Claude Desktop，输入：
```
列出可用的海报设计技能
```

如能看到 8 个技能，则安装成功。

### 方法 2：测试技能

```
使用 Midjourney 主海报生成技能，生成一个未来科技峰会海报提示词
```

---

## 🗑️ 卸载方式

### 方式一：运行卸载脚本（最简单）

创建 `uninstall.sh` 文件：

```bash
#!/bin/bash

echo "🗑️  开始卸载海报设计 AI 技能工具包..."
echo ""

# 1. 找到 Claude Desktop 配置目录
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

echo "📁 配置目录：$CONFIG_DIR"
echo ""

# 2. 备份配置
if [ -f "$CONFIG_FILE" ]; then
    echo "📋 备份配置文件..."
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
    echo "✅ 备份完成"
    echo ""
fi

# 3. 移除 MCP 配置
echo "🔧 移除 MCP 配置..."
if command -v jq &> /dev/null; then
    jq 'del(.mcpServers."poster-design-skills")' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && \
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "✅ 已移除 poster-design-skills 配置"
else
    cat "$CONFIG_FILE" | grep -v "poster-design-skills" > "$CONFIG_FILE.tmp"
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "⚠️  建议手动检查配置文件"
fi
echo ""

# 4. 删除项目文件
echo "🗑️  删除项目文件..."
if [ -d "$HOME/poster-skills" ]; then
    rm -rf "$HOME/poster-skills"
    echo "✅ 已删除 ~/poster-skills"
else
    echo "ℹ️  ~/poster-skills 不存在"
fi
echo ""

# 5. 清理缓存
echo "🧹 清理缓存..."
CACHE_DIR="$HOME/Library/Caches/Claude"
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"/*
    echo "✅ 已清理缓存"
fi
echo ""

# 6. 完成
echo "✅ 卸载完成！"
echo ""
echo "📝 请重启 Claude Desktop 以应用更改"
echo "📋 配置备份已保存：$CONFIG_FILE.backup.*"
```

保存后运行：
```bash
bash uninstall.sh
```

### 方式二：手动卸载

#### 步骤 1：移除 MCP 配置

1. 打开配置目录：
   ```bash
   open ~/Library/Application\ Support/Claude/
   ```

2. 编辑 `claude_desktop_config.json`

3. 删除 `poster-design-skills` 配置

4. 保存文件

#### 步骤 2：删除项目文件

```bash
rm -rf ~/poster-skills
```

#### 步骤 3：清理缓存（可选）

```bash
rm -rf ~/Library/Caches/Claude/*
```

#### 步骤 4：重启 Claude Desktop

完全退出并重新启动。

### 方式三：完全清理

```bash
#!/bin/bash

echo "🗑️  完全清理海报设计 AI 技能工具包..."
echo ""

# 1. 移除配置
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

if [ -f "$CONFIG_FILE" ]; then
    cat "$CONFIG_FILE" | grep -v "poster-design-skills" > "$CONFIG_FILE.tmp"
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "✅ 已清理配置"
fi

# 2. 删除项目
if [ -d "$HOME/poster-skills" ]; then
    rm -rf "$HOME/poster-skills"
    echo "✅ 已删除项目"
fi

# 3. 清理缓存
CACHE_DIR="$HOME/Library/Caches/Claude"
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"/*
    echo "✅ 已清理缓存"
fi

# 4. 删除日志
LOG_DIR="$HOME/Library/Logs/Claude"
if [ -d "$LOG_DIR" ]; then
    rm -rf "$LOG_DIR"/claude*.log
    echo "✅ 已清理日志"
fi

echo ""
echo "✅ 完全清理完成！"
echo "📝 请重启 Claude Desktop"
```

---

## 🔍 故障排查

### 问题 1：技能未加载

**症状**: Claude Desktop 中看不到技能

**解决方法**:
1. 检查配置文件路径是否正确
2. 确认 Node.js 已安装：`node -v`
3. 重启 Claude Desktop
4. 查看日志：`~/Library/Logs/Claude/`

### 问题 2：MCP 服务器无法启动

**症状**: 提示 "Could not attach to MCP server"

**解决方法**:
```bash
# 运行自动修复脚本
bash ~/poster-skills/fix-mcp-connection.sh
```

或手动检查：
1. 确认 `skills/index.js` 存在
2. 检查配置文件中的路径
3. 测试服务器：`node ~/poster-skills/skills/index.js`

### 问题 3：Node.js 版本过低

**症状**: `node -v` 显示版本低于 18.0.0

**解决方法**:
```bash
# 使用 Homebrew 升级
brew upgrade node@18

# 或从官网下载最新版本
# https://nodejs.org/
```

### 问题 4：Claude Desktop 未安装

**症状**: 找不到 Claude Desktop 应用

**解决方法**:
```bash
# 使用 Homebrew 安装
brew install --cask claude

# 或从官网下载
# https://claude.ai/download
```

### 问题 5：卸载后仍有残留

**解决方法**:
```bash
# 完全清理
rm -rf ~/poster-skills
rm -rf ~/Library/Caches/Claude/*
# 手动检查配置文件
open ~/Library/Application\ Support/Claude/
```

---

## 📞 获取帮助

如遇到问题，请查看：

- [故障排查指南](TROUBLESHOOTING_MCP.md)
- [使用文档](USAGE.md)
- [GitHub Issues](https://github.com/scudong/poster-design-ai-skills/issues)

---

<div align="center">

**安装简单，卸载更简单！** 🚀

</div>

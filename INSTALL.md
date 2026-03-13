# 安装与卸载教程

本教程将指导您完成海报设计 AI 技能工具包的安装和卸载。

---

## 📋 前置要求

### 系统要求

- **操作系统**: macOS 10.15+, Windows 10/11, Linux
- **Node.js**: >= 18.0.0
- **npm**: >= 9.0.0
- **Claude Desktop**: 最新版本

### 检查环境

```bash
# 检查 Node.js 版本
node -v
# 应输出：v18.x.x 或更高

# 检查 npm 版本
npm -v
# 应输出：9.x.x 或更高
```

---

## 🚀 安装方式

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

创建一个卸载脚本 `uninstall.sh`：

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
    # 使用 jq 处理 JSON
    jq 'del(.mcpServers."poster-design-skills")' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && \
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "✅ 已移除 poster-design-skills 配置"
else
    # 手动处理（简单情况）
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

1. 打开 Claude Desktop 配置目录：
   ```bash
   open ~/Library/Application\ Support/Claude/
   ```

2. 编辑 `claude_desktop_config.json`

3. 删除或注释掉 `poster-design-skills` 配置：
   ```json
   {
     "mcpServers": {
       // "poster-design-skills": {
       //   "command": "node",
       //   "args": ["/Users/YOUR_USERNAME/poster-skills/skills/index.js"],
       //   "cwd": "/Users/YOUR_USERNAME/poster-skills"
       // }
     }
   }
   ```

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

### 方式三：完全清理（删除所有痕迹）

```bash
#!/bin/bash

echo "🗑️  完全清理海报设计 AI 技能工具包..."
echo ""

# 1. 移除配置
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"

if [ -f "$CONFIG_FILE" ]; then
    # 创建不含 poster-design-skills 的新配置
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

### 问题 3：卸载后仍有残留

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

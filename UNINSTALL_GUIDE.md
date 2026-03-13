# 卸载指南

## ⚠️ 重要提示

**卸载脚本已更新为安全模式**，使用 Node.js 正确处理 JSON 配置，确保不会破坏 Claude Desktop 的配置文件。

---

## 🔧 卸载脚本功能

### ✅ 安全特性

1. **智能 JSON 处理**
   - 使用 Node.js 解析和修改 JSON 配置
   - 保持配置文件格式完整
   - 只移除 `poster-skills` 配置，不影响其他 MCP 工具

2. **自动备份**
   - 卸载前自动备份配置文件
   - 备份文件带时间戳
   - 可随时手动恢复

3. **多位置清理**
   - 删除 `~/poster-skills`
   - 删除 `~/Documents/trae_projects/poster-skills`
   - 清理相关缓存

---

## 📋 卸载步骤

### 方式一：运行卸载脚本（推荐）

```bash
cd ~/Documents/trae_projects/poster-skills
./uninstall-macos.sh
```

脚本会：
1. ✅ 提示确认
2. ✅ 备份配置文件
3. ✅ 安全移除 MCP 配置
4. ✅ 删除项目文件
5. ✅ 清理缓存
6. ✅ 提供恢复说明

### 方式二：手动卸载

#### 1. 删除项目文件

```bash
# 删除可能的项目位置
rm -rf ~/poster-skills
rm -rf ~/Documents/trae_projects/poster-skills
```

#### 2. 移除 MCP 配置

```bash
# 编辑配置文件
nano "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

移除 `poster-skills` 配置部分：

```json
{
  "mcpServers": {
    "poster-skills": {    // ← 删除整个部分
      "command": "node",
      "args": ["..."],
      "cwd": "...",
      "env": {}
    }
  }
}
```

#### 3. 清理缓存

```bash
# 清理 MCP 缓存
rm -rf "$HOME/Library/Caches/Claude/mcp"*
rm -rf "$HOME/Library/Caches/Claude/poster"*
```

#### 4. 重启 Claude Desktop

完全退出并重新打开 Claude Desktop。

---

## 🔄 如何恢复配置

如果卸载后 Claude Desktop 无法启动，可以从备份恢复配置。

### 找到备份文件

```bash
# 查找最近的备份
ls -lt "$HOME/Library/Application Support/Claude/"*.backup.* | head -5
```

输出示例：
```
claude_desktop_config.json.backup.20260313_200700
claude_desktop_config.json.backup.20260313_195530
```

### 恢复配置

```bash
# 复制备份文件到配置位置
cp "$HOME/Library/Application Support/Claude/claude_desktop_config.json.backup.20260313_200700" \
   "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

### 验证配置

```bash
# 检查配置文件格式
cat "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

应该看到有效的 JSON：

```json
{
  "mcpServers": {
    "other-tool": {
      "command": "python",
      "args": ["script.py"]
    }
  },
  "preferences": {
    "sidebarMode": "chat"
  }
}
```

---

## ❓ 常见问题

### Q1: 卸载后 Claude Desktop 无法启动？

**A**: 配置文件可能已损坏，请恢复备份：

```bash
# 1. 找到最近的备份
ls -lt "$HOME/Library/Application Support/Claude/"*.backup.* | head -1

# 2. 恢复配置
cp <备份文件路径> "$HOME/Library/Application Support/Claude/claude_desktop_config.json"

# 3. 重启 Claude Desktop
```

### Q2: 如何完全清除所有痕迹？

**A**: 运行卸载脚本并选择"完全清理"选项，或手动执行：

```bash
# 删除所有缓存和日志
rm -rf "$HOME/Library/Caches/Claude"/*
rm -rf "$HOME/Library/Logs/Claude"/*

# 删除配置（谨慎！）
rm -rf "$HOME/Library/Application Support/Claude"
```

### Q3: 只想暂时禁用技能，不是完全卸载？

**A**: 只需注释掉配置中的 `poster-skills` 部分：

```json
{
  "mcpServers": {
    // "poster-skills": {
    //   "command": "node",
    //   "args": ["..."]
    // }
  }
}
```

---

## 🛡️ 安全性说明

### 旧版本问题（已修复）

旧版本的卸载脚本使用 `grep` 简单删除行，可能会：
- ❌ 破坏 JSON 结构
- ❌ 删除其他工具的配置
- ❌ 导致 Claude 无法启动

### 新版本改进

✅ 使用 Node.js 处理 JSON
- 正确解析 JSON 结构
- 只删除 `poster-skills` 配置
- 保留其他 MCP 工具配置
- 自动格式化输出

✅ 自动备份
- 卸载前自动备份
- 备份文件带时间戳
- 提供恢复说明

✅ 错误处理
- 检测 JSON 解析错误
- 提供详细的错误信息
- 指导用户恢复配置

---

## 📊 卸载前后对比

### 卸载前配置示例

```json
{
  "mcpServers": {
    "poster-skills": {
      "command": "node",
      "args": ["/path/to/skills/index.js"],
      "cwd": "/path/to/project",
      "env": {}
    },
    "other-tool": {
      "command": "python",
      "args": ["script.py"]
    }
  },
  "preferences": {
    "sidebarMode": "chat"
  }
}
```

### 卸载后配置（正确）

```json
{
  "mcpServers": {
    "other-tool": {
      "command": "python",
      "args": ["script.py"]
    }
  },
  "preferences": {
    "sidebarMode": "chat"
  }
}
```

### 卸载后配置（如果只有 poster-skills）

```json
{
  "preferences": {
    "sidebarMode": "chat"
  }
}
```

---

## 🎯 最佳实践

### 1. 卸载前备份

即使脚本会自动备份，也建议手动备份：

```bash
cp "$HOME/Library/Application Support/Claude/claude_desktop_config.json" \
   ~/Desktop/claude_config_backup.json
```

### 2. 测试后再删除

卸载后先测试 Claude Desktop 能否正常启动，确认无误后再删除备份文件。

### 3. 保留备份文件

建议保留至少一个备份文件，以防万一：

```bash
# 移动备份到安全位置
mv "$HOME/Library/Application Support/Claude/claude_desktop_config.json.backup.*" \
   ~/Documents/
```

---

## 📞 需要帮助？

如果卸载过程中遇到任何问题：

1. **检查备份文件**
   ```bash
   ls -l "$HOME/Library/Application Support/Claude/"*.backup.*
   ```

2. **恢复配置**
   ```bash
   cp <备份文件> "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
   ```

3. **重启 Claude Desktop**

4. **提交 Issue**
   - 访问：https://github.com/scudong/poster-design-ai-skills/issues
   - 提供：错误信息、配置文件、备份文件信息

---

<div align="center">

**安全卸载，无后顾之忧！** 🛡️✨

</div>

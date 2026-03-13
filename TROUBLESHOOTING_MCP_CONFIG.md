# MCP 配置修复指南

## 📋 问题描述

如果你发现 Claude Desktop 中只加载了 **5 个技能**（1 个 Midjourney + 4 个 NanoBanana），而不是完整的 **8 个技能**，这是因为 MCP 配置文件中的路径不正确。

---

## 🔍 问题原因

MCP Server 配置文件中使用了错误的路径：

```json
{
  "mcpServers": {
    "poster-skills": {
      "command": "node",
      "args": ["/Users/dongchangyang/poster-skills/skills/index.js"]
      // ❌ 错误：路径不存在
    }
  }
}
```

正确路径应该是：
```
/Users/dongchangyang/Documents/trae_projects/poster-skills/skills/index.js
```

---

## ✅ 解决方案（2 种方式）

### 方式一：自动修复（推荐）

在项目根目录执行：

```bash
cd ~/Documents/trae_projects/poster-skills
./fix-mcp-config.sh
```

脚本会自动：
- ✅ 检测正确的路径
- ✅ 备份现有配置
- ✅ 更新配置文件
- ✅ 验证配置正确性

### 方式二：手动修复

1. **打开配置文件**
   ```bash
   # macOS
   open "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
   ```

2. **修改配置内容**
   ```json
   {
     "mcpServers": {
       "poster-skills": {
         "command": "node",
         "args": [
           "/Users/dongchangyang/Documents/trae_projects/poster-skills/skills/index.js"
         ],
         "cwd": "/Users/dongchangyang/Documents/trae_projects/poster-skills"
       }
     }
   }
   ```

3. **保存并重启 Claude Desktop**

---

## 📊 验证修复结果

### 1. 检查配置文件

```bash
cat "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

应该看到正确的路径指向 `Documents/trae_projects/poster-skills`

### 2. 重启 Claude Desktop

- 完全退出（菜单栏 → Quit）
- 重新打开 Claude Desktop

### 3. 查看技能列表

在 Claude Desktop 中应该看到完整的 **8 个技能**：

#### Midjourney 系列（4 个）
- ✅ `midjourney-poster-generator` - 主海报生成
- ✅ `midjourney-style-matcher` - 艺术风格匹配
- ✅ `midjourney-composition-optimizer` - 构图色彩优化
- ✅ `midjourney-series-generator` - 系列海报批量生成

#### NanoBanana 系列（4 个）
- ✅ `nanobanana-poster-generator` - 主海报生成（角色一致性）
- ✅ `nanobanana-style-matcher` - 艺术风格匹配
- ✅ `nanobanana-composition-optimizer` - 构图色彩优化
- ✅ `nanobanana-series-generator` - 系列海报批量生成

---

## 🎯 测试技能

### 测试 Midjourney 技能

```
使用 Midjourney 主海报生成技能
主题：未来科技峰会
风格：赛博朋克
色彩：霓虹蓝紫
```

**预期输出**：
```
【英文提示词】
Futuristic tech summit poster, cyberpunk style...

【中文翻译】
未来科技峰会海报，赛博朋克风格...

【提示词解析】
• Futuristic tech summit poster - 主体描述...
• cyberpunk style - 艺术风格...
```

### 测试 NanoBanana 技能

```
使用 NanoBanana 主海报生成技能
主题：魔法学院招生海报
角色：红发女法师
风格：奇幻插画
```

**预期输出**：
```
【英文提示词】
Fantasy magic academy poster, red-haired female mage...

【中文翻译】
奇幻魔法学院海报，红发女法师...

【提示词解析】
• red-haired female mage - 角色描述...
• Character consistency lock enabled - 角色锁定已启用...
```

---

## ❓ 常见问题

### Q1: 修复后仍然只显示 5 个技能？

**A**: 请尝试以下步骤：

1. **完全重启 Claude Desktop**
   ```bash
   # 强制退出
   killall "Claude"
   # 重新打开
   open /Applications/Claude.app
   ```

2. **清除缓存**
   ```bash
   rm -rf "$HOME/Library/Application Support/Claude/mcp-cache"
   ```

3. **验证 index.js 可执行**
   ```bash
   node /Users/dongchangyang/Documents/trae_projects/poster-skills/skills/index.js --help
   ```

### Q2: 提示 "Cannot find module" 错误？

**A**: 检查 Node.js 依赖是否安装：

```bash
cd ~/Documents/trae_projects/poster-skills
npm install
```

### Q3: 配置文件权限问题？

**A**: 修复配置文件权限：

```bash
chmod 644 "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
```

---

## 🔧 调试技巧

### 查看 MCP Server 日志

在终端运行 MCP Server：

```bash
cd ~/Documents/trae_projects/poster-skills
node skills/index.js
```

应该看到：
```
🎨 Poster Design AI Skills MCP Server
📊 已加载 8 个技能文件
✅ MCP Server 就绪
```

### 检查技能文件

```bash
cd ~/Documents/trae_projects/poster-skills/skills
ls -la *.json
```

应该显示 **8 个 JSON 文件**。

---

## 📞 需要帮助？

如果以上方法都无法解决问题：

1. **检查 GitHub Issues**
   - 访问：https://github.com/scudong/poster-design-ai-skills/issues

2. **提交问题报告**
   - 包含：错误信息、配置文件、技能列表截图

3. **运行诊断脚本**
   ```bash
   ./fix-mcp-config.sh
   ```

---

## 🎉 成功标志

修复成功后，你应该看到：

- ✅ Claude Desktop 左下角显示 🔨 锤子图标
- ✅ 技能列表显示 **8 个技能**（不是 5 个）
- ✅ 所有技能都能正常生成提示词
- ✅ 输出包含英文 + 中文 + 解析

---

<div align="center">

**祝使用愉快！** 🎨✨

</div>

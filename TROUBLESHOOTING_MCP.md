# 🔧 MCP 服务器故障排查指南

## 问题：Could not attach to MCP server poster-skills

当您在 Claude Desktop 中看到此错误时，请按以下步骤排查：

---

## 原因 1：配置文件路径错误

### 检查步骤

1. **打开配置文件**
   
   在 Claude Desktop 中点击：**Settings → Developer → Edit Config**

2. **检查配置内容**
   
   应该看到类似以下内容：
   
   ```json
   {
     "mcpServers": {
       "poster-skills": {
         "command": "node",
         "args": ["/Users/YOUR_USERNAME/poster-skills/skills/index.js"],
         "cwd": "/Users/YOUR_USERNAME/poster-skills"
       }
     }
   }
   ```

3. **验证路径**
   
   在终端运行：
   
   ```bash
   ls ~/poster-skills/skills/index.js
   ```
   
   如果文件存在，会显示文件路径。

4. **修正路径**
   
   将配置中的 `YOUR_USERNAME` 替换为您的实际用户名。

---

## 原因 2：Node.js 未安装或版本过低

### 检查步骤

```bash
node -v
```

### 解决方法

如未安装或版本低于 18.0.0：

1. **使用 Homebrew 安装**
   ```bash
   brew install node
   ```

2. **或从官网下载**
   
   访问 https://nodejs.org/ 下载安装 LTS 版本

---

## 原因 3：技能文件缺失

### 检查步骤

```bash
ls ~/poster-skills/skills/*.json
```

应该看到 8 个 JSON 文件：
- midjourney-composition-optimizer.json
- midjourney-poster-generator.json
- midjourney-series-generator.json
- midjourney-style-matcher.json
- nanobanana-composition-optimizer.json
- nanobanana-poster-generator.json
- nanobanana-series-generator.json
- nanobanana-style-matcher.json

### 解决方法

如文件缺失，重新克隆项目：

```bash
rm -rf ~/poster-skills
git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
```

---

## 原因 4：MCP 服务器无法启动

### 测试服务器

在终端运行：

```bash
node ~/poster-skills/skills/index.js
```

应该看到：

```
🎨 海报设计 AI 技能工具包 MCP 服务器启动中...
已加载 8 个技能:
...
等待 Claude Desktop 连接...
```

### 解决方法

如无法启动，检查错误信息并修复。

---

## 原因 5：配置文件格式错误

### 检查 JSON 格式

在终端运行：

```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool
```

如报错，说明 JSON 格式有误。

### 修正方法

重新编辑配置文件，确保：
- 使用双引号 `"` 而不是单引号 `'`
- 最后一个属性后没有逗号
- 括号正确匹配

---

## 快速修复（推荐）

### 方法一：重新运行安装脚本

```bash
cd ~/poster-skills
bash install-macos.sh
```

### 方法二：手动更新配置

1. 打开配置文件（Settings → Developer → Edit Config）

2. 替换为以下内容（**修改用户名**）：

   ```json
   {
     "mcpServers": {
       "poster-skills": {
         "command": "node",
         "args": ["/Users/YOUR_USERNAME/poster-skills/skills/index.js"],
         "cwd": "/Users/YOUR_USERNAME/poster-skills",
         "env": {}
       }
     }
   }
   ```

3. 保存文件

4. 完全退出 Claude Desktop（菜单栏 → Quit）

5. 重新打开 Claude Desktop

---

## 验证安装成功

重启 Claude Desktop 后：

1. **查看左下角**
   
   应该出现 **🔨 锤子图标**

2. **测试技能**
   
   输入：
   
   ```
   列出可用的海报设计技能
   ```
   
   应该能看到 8 个技能。

---

## 查看日志

### Claude Desktop 日志

在终端运行：

```bash
tail -f ~/Library/Logs/Claude/*.log
```

### MCP 服务器日志

配置文件中的 `env` 添加日志变量：

```json
{
  "mcpServers": {
    "poster-skills": {
      "command": "node",
      "args": ["/Users/YOUR_USERNAME/poster-skills/skills/index.js"],
      "cwd": "/Users/YOUR_USERNAME/poster-skills",
      "env": {
        "DEBUG": "mcp:*"
      }
    }
  }
}
```

---

## 常见问题

### Q: 配置后仍然报错？

A: 完全退出 Claude Desktop（不是关闭窗口），然后重新打开。

### Q: 锤子图标不显示？

A: 检查配置文件路径是否正确，Node.js 是否已安装。

### Q: 技能列表为空？

A: 检查技能文件是否存在，JSON 格式是否正确。

### Q: 提示 "Command failed"？

A: 检查 Node.js 是否已安装，路径是否正确。

---

## 获取帮助

如以上方法都无法解决：

1. **查看完整日志**
   
   ```bash
   cat ~/Library/Logs/Claude/*.log
   ```

2. **提交 Issue**
   
   https://github.com/scudong/poster-design-ai-skills/issues

3. **提供信息**
   
   - 错误截图
   - 配置文件内容
   - 日志内容
   - Node.js 版本

---

<div align="center">

**祝您顺利解决问题！🎉**

</div>

# 🚀 macOS 快速安装指南

## 最简单的方式（一键安装）✨

打开**终端（Terminal）**，复制粘贴以下命令：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/scudong/poster-design-ai-skills/main/install-macos.sh)"
```

**完成！** 脚本会自动完成所有安装步骤。

---

## 手动安装步骤

### 第一步：克隆仓库

```bash
git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
cd ~/poster-skills
```

### 第二步：运行安装脚本

```bash
bash install-macos.sh
```

安装脚本会自动：
1. ✅ 检查 Node.js 环境
2. ✅ 配置 Claude Desktop
3. ✅ 创建 MCP 服务器配置

### 第三步：重启 Claude Desktop

1. 完全退出 Claude Desktop（菜单栏 → Quit）
2. 重新打开 Claude Desktop
3. 左下角出现 **🔨 锤子图标** = 安装成功 ✅

---

## 验证安装

在 Claude Desktop 中输入：

```
列出可用的海报设计技能
```

应该能看到 8 个技能：
- midjourney-poster-generator
- midjourney-style-matcher
- midjourney-composition-optimizer
- midjourney-series-generator
- nanobanana-poster-generator
- nanobanana-style-matcher
- nanobanana-composition-optimizer
- nanobanana-series-generator

---

## 使用示例

### Midjourney 技能

```
使用 Midjourney 主海报生成技能，生成一个未来科技峰会海报
```

```
使用 Midjourney 系列海报批量，生成 5 组爵士音乐节海报
```

### NanoBanana 技能

```
使用 NanoBanana 主海报生成，创建虚拟主播宣传海报
```

```
使用 NanoBanana 系列海报批量，生成 IP 宣传系列
```

---

## 故障排查

### 问题 1：找不到技能

**解决**：重启 Claude Desktop

### 问题 2：配置不生效

**解决**：检查配置文件是否存在：
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

### 问题 3：Node.js 未安装

**解决**：安装 Node.js：
```bash
# 使用 Homebrew
brew install node

# 或从官网下载
# https://nodejs.org/
```

---

## 手动配置（可选）

如自动配置失败，可以手动编辑 Claude Desktop 配置：

### 步骤 1：打开配置文件

在 Claude Desktop 中点击：**Settings → Developer → Edit Config**

### 步骤 2：添加配置

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

> ⚠️ 将 `YOUR_USERNAME` 替换为你的实际用户名

### 步骤 3：保存并重启

保存文件，完全退出并重新打开 Claude Desktop。

---

## 获取帮助

- 完整文档：[INSTALL.md](INSTALL.md)
- 使用教程：[USAGE.md](USAGE.md)
- GitHub Issues: https://github.com/scudong/poster-design-ai-skills/issues

---

<div align="center">

**Made with ❤️ for macOS**

**安装完成，开始创作吧！🎨**

</div>

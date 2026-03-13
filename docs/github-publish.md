# GitHub 发布流程

本指南将帮助您将海报设计 AI 技能工具包发布到 GitHub，并进行版本管理。

---

## 📋 发布前准备

### 1. 检查项目完整性

确保以下文件都存在且内容正确：

```bash
# 检查核心文件
ls -la mcp.json package.json README.md INSTALL.md USAGE.md

# 检查技能文件
ls -la skills/

# 检查脚本文件
ls -la scripts/
```

### 2. 更新版本号和元数据

编辑 `package.json`，更新版本号：

```json
{
  "name": "poster-design-ai-skills",
  "version": "1.0.0",  // 更新版本号
  ...
}
```

编辑 `mcp.json`，确保版本一致：

```json
{
  "name": "poster-design-ai-skills",
  "version": "1.0.0",  // 与 package.json 一致
  ...
}
```

### 3. 运行测试和验证

```bash
# 验证技能格式
npm run validate

# 运行测试
npm run test

# 确保所有测试通过
```

---

## 🚀 发布步骤

### 方式一：使用发布脚本（推荐）

#### 步骤 1：运行发布脚本

```bash
# 添加执行权限
chmod +x scripts/publish-to-github.sh

# 运行发布脚本
npm run publish:github
```

脚本会自动：
1. 检查 Git 状态
2. 提交未提交的更改
3. 创建版本标签（如 v1.0.0）
4. 推送到 GitHub
5. 提供 GitHub Release 创建链接

#### 步骤 2：创建 GitHub Release

1. 点击脚本输出的 GitHub Release 链接
2. 填写 Release 标题（如：v1.0.0 - 初始发布）
3. 填写 Release 说明（见下方模板）
4. 点击 "Publish release"

---

### 方式二：手动发布

#### 步骤 1：初始化 Git 仓库（如未初始化）

```bash
git init
git add .
git commit -m "Initial commit: 海报设计 AI 技能工具包 v1.0.0"
```

#### 步骤 2：添加远程仓库

```bash
# 在 GitHub 上创建新仓库（不要初始化 README）
# 然后添加远程仓库
git remote add origin https://github.com/your-username/poster-design-ai-skills.git
```

#### 步骤 3：推送代码

```bash
# 推送到 main 分支
git push -u origin main

# 创建并推送标签
git tag -a v1.0.0 -m "Release v1.0.0 - 海报设计 AI 技能工具包"
git push origin v1.0.0
```

#### 步骤 4：创建 GitHub Release

1. 访问：https://github.com/your-username/poster-design-ai-skills/releases/new
2. 选择标签：v1.0.0
3. 填写 Release 标题和说明
4. 点击 "Publish release"

---

## 📝 Release 说明模板

### Release 标题
```
v1.0.0 - 海报设计 AI 技能工具包初始发布
```

### Release 说明
```markdown
## 🎉 发布信息

这是海报设计 AI 技能工具包的第一个正式版本，包含 8 个专业级技能，支持 Midjourney 和 NanoBanana 双平台。

## ✨ 主要特性

### Midjourney 海报策展大师（4 个技能）
- 🎨 主海报生成 - 专业级海报提示词生成
- 🎭 艺术风格匹配 - 智能匹配艺术流派与艺术家
- 📐 构图色彩优化 - 高级版式设计优化
- 📦 系列海报批量 - 一次生成 5 组视觉统一的海报

### NanoBanana 海报策展大师（4 个技能）
- 👤 主海报生成 - 强化角色一致性和 IP 稳定
- 🎭 艺术风格匹配 - 支持 IP 风格定位
- 📐 构图色彩优化 - 角色姿态与场景协调
- 📦 系列海报批量 - 强制保持角色一致性

## 📦 安装方法

```bash
# 克隆项目
git clone https://github.com/your-username/poster-design-ai-skills.git
cd poster-design-ai-skills

# 一键安装
npm install
npm run install:skills

# 验证安装
npm run validate
```

详细安装说明请查看 [INSTALL.md](INSTALL.md)

## 📚 使用文档

- [README.md](README.md) - 项目总览
- [INSTALL.md](INSTALL.md) - 安装教程
- [USAGE.md](USAGE.md) - 使用指南 + 20 个提示词案例

## 🔧 技术规格

- 遵循 Claude MCP 标准
- Node.js >= 18.0.0
- 支持 Midjourney v6.0
- 支持 NanoBanana v1

## 📋 更新日志

### v1.0.0 (2026-03-13)
- ✅ 初始版本发布
- ✅ 8 个专业技能
- ✅ 完整文档系统
- ✅ 一键安装脚本
- ✅ 验证和测试工具

## 🙏 致谢

感谢所有贡献者和测试用户！

## 📄 许可证

MIT License - 可自由商用
```

---

## 🔄 后续更新流程

### 更新版本号

遵循语义化版本规范（Semantic Versioning）：

- **主版本号（MAJOR）**: 不兼容的 API 变更
- **次版本号（MINOR）**: 向后兼容的功能新增
- **修订号（PATCH）**: 向后兼容的问题修正

例如：
- `1.0.0` -> `1.0.1` (修复 bug)
- `1.0.0` -> `1.1.0` (新增功能)
- `1.0.0` -> `2.0.0` (重大变更)

### 更新步骤

1. **更新版本号**
   ```bash
   # 编辑 package.json 和 mcp.json
   # 将 version 改为新版本号
   ```

2. **记录变更**
   ```bash
   # 编辑 CHANGELOG.md（如已创建）
   # 或直接在 Release 说明中记录
   ```

3. **提交并推送**
   ```bash
   git add .
   git commit -m "chore: 更新到 v1.1.0"
   git push origin main
   ```

4. **创建新标签**
   ```bash
   git tag -a v1.1.0 -m "Release v1.1.0 - 新增 XXX 功能"
   git push origin v1.1.0
   ```

5. **创建 GitHub Release**
   - 访问 Release 页面
   - 填写新版本说明
   - 发布

---

## 📊 GitHub 仓库优化

### 1. 添加仓库描述

在 GitHub 仓库页面右侧 "About" 区域添加：
```
海报设计 AI 技能工具包 - Midjourney + NanoBanana 双平台专业策展系统
```

### 2. 添加主题标签

添加以下 topics：
```
mcp claude poster-design midjourney nanobanana ai-art prompt-engineering design-tools
```

### 3. 配置 GitHub Pages（可选）

如需在线文档：

1. 进入 Settings > Pages
2. Source 选择 "main branch"
3. Folder 选择 "/ (root)"
4. Save

### 4. 添加徽章

在 README.md 中添加徽章：

```markdown
![Version](https://img.shields.io/github/v/release/your-username/poster-design-ai-skills)
![License](https://img.shields.io/github/license/your-username/poster-design-ai-skills)
![Stars](https://img.shields.io/github/stars/your-username/poster-design-ai-skills)
```

---

## 🐛 问题排查

### 问题 1：推送失败 - 权限错误

**错误**: `remote: Permission denied`

**解决**:
```bash
# 检查远程仓库 URL
git remote -v

# 如不正确，更新为正确的 URL
git remote set-url origin https://github.com/your-username/poster-design-ai-skills.git
```

### 问题 2：标签已存在

**错误**: `tag 'v1.0.0' already exists`

**解决**:
```bash
# 删除本地标签
git tag -d v1.0.0

# 删除远程标签
git push origin :refs/tags/v1.0.0

# 重新创建
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

### 问题 3：分支名称不是 main

**解决**:
```bash
# 重命名分支
git branch -m master main

# 推送并设置上游
git push -u origin main
```

---

## 📈 发布后推广

### 1. 社交媒体

- Twitter/X: 发布项目链接和特性介绍
- LinkedIn: 专业网络分享
- 微信群/QQ 群：相关技术社区

### 2. 技术社区

- Product Hunt: 发布产品
- Hacker News: 分享技术实现
- Reddit: r/webdev, r/design, r/ai 等板块

### 3. 中文社区

- 掘金
- 知乎
- V2EX
- SegmentFault

### 4. 收集反馈

- 鼓励用户提交 Issue
- 创建 Discussion 讨论区
- 收集使用案例和作品

---

## 📞 获取帮助

如遇到问题：

1. 查看 [INSTALL.md](INSTALL.md)
2. 查看 [USAGE.md](USAGE.md)
3. 提交 [GitHub Issue](https://github.com/your-username/poster-design-ai-skills/issues)

---

<div align="center">

**祝发布顺利！🎉**

</div>

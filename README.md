# 海报设计 AI 技能工具包

<p align="center">
  <strong>Midjourney + NanoBanana 双平台专业策展系统</strong>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
  <a href="#"><img src="https://img.shields.io/badge/version-1.0.0-green.svg" alt="Version"></a>
  <a href="#"><img src="https://img.shields.io/badge/MCP-Compatible-orange.svg" alt="MCP Compatible"></a>
  <a href="#"><img src="https://img.shields.io/badge/Node-%3E%3D18.0.0-lightgrey.svg" alt="Node Version"></a>
</p>

---

## 📖 项目简介

本工具包是一套**可商用、可分发、可一键安装**的海报设计 AI 技能系统，严格遵循 Claude MCP 标准，包含 **8 个专业级技能**，覆盖 Midjourney 和 NanoBanana 双平台。

### 核心能力

- 🎨 **专业海报生成** - 艺术策展级别提示词工程
- 🎭 **艺术风格匹配** - 智能匹配艺术流派与艺术家
- 📐 **构图色彩优化** - 高级版式设计与视觉层级
- 📦 **系列海报批量** - 一次生成 5 组视觉统一的系列海报
- 👤 **角色一致性锁定** - NanoBanana 专属 IP 稳定技术

### 适用场景

- 艺术展览主视觉 KV 设计
- 活动宣传海报系列
- 品牌 IP 形象开发
- 产品发布会视觉
- 社交媒体矩阵内容
- 商业海报批量生产

---

## 🚀 快速开始

### 前置要求

- macOS 10.15+
- 其他依赖（Node.js、Claude Desktop 等）安装脚本会自动安装

### macOS 一键安装（最简单）✨

```bash
curl -fsSL https://raw.githubusercontent.com/scudong/poster-design-ai-skills/main/install-macos.sh | bash
```

安装脚本会自动检测并安装所有依赖（Homebrew、Node.js、Claude Desktop），重启 Claude Desktop 即可使用。

### macOS 一键卸载

```bash
curl -fsSL https://raw.githubusercontent.com/scudong/poster-design-ai-skills/main/uninstall-macos.sh | bash
```

完全卸载，可选择清理所有痕迹。

### 手动安装

```bash
# 克隆项目
git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
cd ~/poster-skills

# 运行安装脚本
bash install-macos.sh
```

详细安装和卸载步骤请查看 [安装教程](INSTALL.md)

---

## 📦 技能列表

### Midjourney 海报策展大师（4 个技能）

| 技能名称 | 功能描述 | 文件 |
|---------|---------|------|
| **主海报生成** | 根据主题、风格、氛围生成专业级 Midjourney 海报提示词 | `midjourney-poster-generator.json` |
| **艺术风格匹配** | 智能匹配艺术流派、艺术家、色彩调性 | `midjourney-style-matcher.json` |
| **构图色彩优化** | 提供高级版式设计：构图、焦点、色彩、排版 | `midjourney-composition-optimizer.json` |
| **系列海报批量** | 一次生成 5 组不同风格但视觉统一的系列海报 | `midjourney-series-generator.json` |

### NanoBanana 海报策展大师（4 个技能）

| 技能名称 | 功能描述 | 文件 |
|---------|---------|------|
| **主海报生成** | 专为 NanoBanana 优化，强化角色一致性和 IP 稳定 | `nanobanana-poster-generator.json` |
| **艺术风格匹配** | NanoBanana 专用风格匹配，支持 IP 风格定位 | `nanobanana-style-matcher.json` |
| **构图色彩优化** | 强化角色姿态与场景协调，确保角色不崩坏 | `nanobanana-composition-optimizer.json` |
| **系列海报批量** | 强制保持角色一致性、IP 稳定、多图统一 | `nanobanana-series-generator.json` |

---

## 💡 使用示例

### 示例 1：生成科技峰会海报

```
使用技能：midjourney-poster-generator

输入：
- 主题：未来科技峰会
- 风格：赛博朋克
- 氛围：神秘震撼
- 色彩：霓虹蓝紫撞色
- 比例：2:3

输出：
未来科技峰会主视觉海报，赛博朋克风格，中心放射式构图，主体为发光科技球体悬浮于数字矩阵之上，体积光穿透大气，霓虹蓝紫撞色配色，金属质感与全息投影材质结合，主标题采用无衬线粗体置于视觉焦点，副标题层级分明留白呼吸，8K 超高清分辨率，神秘震撼的未来科技感，专业海报设计，艺术指导级别，视觉传达 masterpiece --ar 2:3 --v 6.0 --style raw
```

### 示例 2：生成角色 IP 系列海报（NanoBanana）

```
使用技能：nanobanana-series-generator

输入：
- 主题：品牌 IP 形象宣传
- 角色定义：银色短发齐耳波波头，蓝色清澈眼眸，穿着白色极简科技风连衣裙，佩戴透明全息眼镜，手持发光平板设备
- 基础色：白 + 银 + 科技蓝
- IP 元素：全息眼镜、发光平板、科技风连衣裙

输出：5 组不同场景但角色高度统一的系列海报提示词
```

更多案例请查看 [使用文档](USAGE.md)

---

## 📚 文档导航

| 文档 | 内容 |
|------|------|
| [README.md](README.md) | 项目总览（当前文档） |
| [INSTALL.md](INSTALL.md) | 安装和卸载教程 |
| [USAGE.md](USAGE.md) | 使用指南 + 20 个提示词案例 |
| [TROUBLESHOOTING_MCP.md](TROUBLESHOOTING_MCP.md) | MCP 连接问题排查 |

---

## 📋 项目结构

```
poster-design-ai-skills/
├── mcp.json                          # MCP 配置文件
├── package.json                      # 项目配置
├── README.md                         # 项目说明
├── INSTALL.md                        # 安装和卸载教程
├── USAGE.md                          # 使用文档
├── TROUBLESHOOTING_MCP.md            # 故障排查指南
├── skills/                           # 技能文件目录
│   ├── midjourney-*.json            # 4 个 Midjourney 技能
│   └── nanobanana-*.json            # 4 个 NanoBanana 技能
├── scripts/                          # 工具脚本
│   └── *.js                          # 辅助脚本
└── install-macos.sh                  # macOS 一键安装脚本
```

---

## 🎯 核心特性

### 1. 专业级提示词工程

所有技能内置的提示词都经过专业策展人、AI 绘画提示词工程师、版式设计师三方打磨，确保：

- ✅ 包含完整艺术策展要素（主题、风格、构图、光影、色彩、材质、排版）
- ✅ 符合 Midjourney/NanoBanana 最优参数结构
- ✅ 输出纯提示词，不解释、不换行、可直接粘贴使用

### 2. 角色一致性技术（NanoBanana 专属）

针对 IP 设计、虚拟主播、品牌角色等场景，提供完整的角色一致性锁定方案：

- ✅ 角色特征详细定义（发型、瞳色、服装、配饰、姿态）
- ✅ 跨场景一致性控制
- ✅ 多角度多表情统一
- ✅ 避免角色崩坏

### 3. MCP 标准兼容

完全符合 Model Context Protocol 标准，支持：

- ✅ 一键安装/卸载
- ✅ 技能热插拔
- ✅ 跨平台兼容（macOS、Windows、Linux）

---

## 🛠️ 开发命令

```bash
# 安装技能
npm run install:skills

# 验证技能格式
npm run validate

# 测试技能
npm run test

# 构建发布
npm run build
```

---

## 📄 开源协议

MIT License - 详见 [LICENSE](LICENSE)

---

## 🔗 相关链接

- [GitHub 仓库](https://github.com/scudong/poster-design-ai-skills)
- [MCP 官网](https://modelcontextprotocol.io/)
- [Claude Desktop](https://claude.ai/download)

---

<div align="center">

**🎨 让 AI 成为你的专业策展人！**

</div>

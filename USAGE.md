# 使用文档

本指南详细介绍如何使用海报设计 AI 技能工具包的 8 个技能。**这些技能专门用于生成高质量的 AI 绘画提示词**，每个提示词都经过专业策展，包含详细的构成说明。

---

## 📖 目录

1. [技能使用总览](#技能使用总览)
2. [技能核心功能说明](#技能核心功能说明)
3. [Midjourney 技能详解](#midjourney-技能详解)
4. [NanoBanana 技能详解](#nanobanana-技能详解)
5. [20 个完整提示词案例](#20-个完整提示词案例)
6. [提示词结构解析](#提示词结构解析)
7. [最佳实践](#最佳实践)
8. [常见问题](#常见问题)

---

## 技能使用总览

### 🎯 技能核心功能

**重要说明**：本工具包的 8 个技能都是**提示词生成器**，不是直接生成图片。它们的作用是：

1. ✅ 根据您的描述生成专业的 AI 绘画提示词
2. ✅ 提示词可直接用于 Midjourney 或 NanoBanana
3. ✅ 每个提示词都包含详细的构成说明
4. ✅ 确保生成的提示词能产出高质量海报

### 调用方式

在 Claude Desktop 中，您可以通过以下方式调用技能：

**方式 1：直接描述需求**
```
帮我生成一个未来科技峰会的海报提示词，赛博朋克风格
```

**方式 2：指定技能名称**
```
使用 midjourney-poster-generator 技能，主题是爵士音乐节
```

**方式 3：使用中文技能名**
```
使用 Midjourney 主海报生成技能，创建一个艺术展览海报
```

### 技能选择指南

| 需求场景 | 推荐技能 | 输出内容 |
|---------|---------|---------|
| 快速生成单张海报 | 主海报生成技能 | 1 个完整提示词 |
| 不确定用什么风格 | 艺术风格匹配技能 | 风格建议 + 关键词组合 |
| 优化现有设计 | 构图色彩优化技能 | 优化建议 + 改进后提示词 |
| 需要系列海报 | 系列海报批量生成技能 | 5 个统一风格的提示词 |
| 涉及角色/IP 设计 | NanoBanana 系列技能 | 带角色锁定的提示词 |

---

## 技能核心功能说明

### 📝 提示词生成原理

每个技能生成的提示词都包含以下核心要素：

```
【主体描述】+【艺术风格】+【构图方式】+【色彩方案】+【光影效果】+【技术参数】
```

#### 示例提示词结构解析

```
International Jazz Music Festival poster,          ← 主体描述
Art Deco style,                                     ← 艺术风格
symmetrical composition,                            ← 构图方式
black and gold luxury color scheme,                 ← 色彩方案
golden saxophone silhouette centered,               ← 视觉焦点
elegant geometric patterns,                         ← 装饰元素
volumetric lighting,                                ← 光影效果
professional music event visual,                    ← 质量描述
8K resolution                                       ← 技术参数
--ar 2:3 --v 6.0 --style raw                       ← Midjourney 参数
```

### 🎨 提示词质量保障

每个生成的提示词都经过以下优化：

1. **主体清晰**：明确描述海报主题和核心视觉
2. **风格专业**：使用艺术史和专业设计术语
3. **构图合理**：包含专业的构图指导
4. **色彩协调**：提供明确的色彩方案
5. **细节丰富**：包含光影、质感、氛围等细节
6. **参数完整**：包含平台特定的技术参数

---

## ✨ 高级功能：文字配置

所有技能都支持**精确文字配置**，让您可以完全控制海报上的文字内容、位置、样式和效果。

### 📝 文字配置参数

#### 1. 基本文字内容

```json
{
  "textConfig": {
    "title": "主标题文字",
    "subtitle": "副标题文字",
    "bodyText": "正文详细信息"
  }
}
```

**说明**：
- `title`: 主标题，通常是活动/主题名称
- `subtitle`: 副标题，补充说明或口号
- `bodyText`: 正文，如时间、地点、主办方等

#### 2. 文字位置布局

```json
{
  "position": "顶部居中"
}
```

**可选位置**：
- **顶部系列**：顶部居中、顶部居左、顶部居右
- **中部系列**：中部居中、中部居左、中部居右
- **底部系列**：底部居中、底部居左、底部居右
- **垂直系列**：左侧垂直、右侧垂直
- **自定义**：自定义位置（在描述中说明）

#### 3. 主标题样式配置

```json
{
  "titleStyle": {
    "fontFamily": "思源黑体 Bold",
    "fontSize": "超大 (占画面 20-30%)",
    "fontWeight": "粗体",
    "color": "白色渐变到霓虹蓝",
    "spacing": "宽"
  }
}
```

**字体选择**：
- **现代风格**：思源黑体、站酷高端黑、阿里巴巴普惠体
- **传统风格**：思源宋体、书法体
- **活泼风格**：站酷黄油体、手写体
- **艺术风格**：艺术字体

**字号大小**：
- 超大：占画面 20-30%，视觉冲击力强
- 大：占画面 15-20%，醒目突出
- 中：占画面 10-15%，平衡适中
- 小：占画面 5-10%，精致细节

**字间距**：
- 特宽：戏剧性效果，适合标题
- 宽：高端感，呼吸感强
- 正常：标准排版
- 窄：紧凑密集
- 特窄：特殊效果

#### 4. 副标题样式配置

```json
{
  "subtitleStyle": {
    "fontFamily": "思源黑体 Regular",
    "fontSize": "中",
    "fontWeight": "常规",
    "color": "浅灰色"
  }
}
```

#### 5. 文字特效配置

```json
{
  "effects": {
    "shadow": "轻微阴影",
    "stroke": "无",
    "glow": "微弱发光",
    "gradient": "线性渐变"
  }
}
```

**特效选项**：
- **阴影**：无、轻微阴影、明显阴影、发光阴影
- **描边**：无、细描边、中描边、粗描边
- **发光**：无、微弱发光、明显发光、强烈发光
- **渐变**：无、线性渐变、径向渐变、角度渐变

---

### 🎯 使用案例

#### 案例 1：科技峰会海报

```
使用 Midjourney 主海报生成技能
主题：未来科技峰会
风格：赛博朋克
色彩：霓虹蓝紫

文字配置：
- 主标题："2026 未来科技峰会"
- 副标题："探索·创新·突破"
- 正文："3 月 15-17 日 | 北京·国家会议中心"
- 位置：顶部居中
- 标题样式：思源黑体 Bold，超大字号，白色渐变到霓虹蓝，宽间距
- 副标题样式：思源黑体 Regular，中号，浅灰色
- 特效：轻微阴影 + 微弱发光 + 线性渐变
```

**生成效果**：
- ✅ 主标题"2026 未来科技峰会"位于顶部居中，超大字号，使用思源黑体粗体
- ✅ 文字颜色从白色渐变到霓虹蓝色，增强科技感
- ✅ 宽字间距营造高端大气的视觉效果
- ✅ 轻微阴影和微弱发光让文字在深色背景上更清晰
- ✅ 副标题"探索·创新·突破"位于主标题下方，中号字号，浅灰色
- ✅ 正文信息位于底部，小号字号，包含时间地点

#### 案例 2：音乐节海报

```
使用 Midjourney 主海报生成技能
主题：爵士音乐节
风格：艺术装饰风格
色彩：黑金奢华

文字配置：
- 主标题："2026 国际爵士音乐节"
- 副标题："经典·永恒·激情"
- 位置：左侧垂直
- 标题样式：书法体，超大字号，金色，特宽间距
- 特效：明显阴影 + 无描边 + 无发光
```

**生成效果**：
- ✅ 主标题"2026 国际爵士音乐节"垂直排列在左侧
- ✅ 使用书法体营造艺术感和手写质感
- ✅ 金色文字在黑金配色中凸显奢华感
- ✅ 特宽字间距增强视觉张力和设计感
- ✅ 明显阴影确保文字清晰可读

#### 案例 3：艺术展览海报

```
使用 Midjourney 主海报生成技能
主题：当代艺术展
风格：极简主义
色彩：莫兰迪色系

文字配置：
- 主标题："边界·融合"
- 副标题："当代艺术邀请展"
- 正文："2026.04.01-05.15 | 上海当代艺术博物馆"
- 位置：底部居中
- 标题样式：思源宋体 Regular，大号字号，深灰色，正常间距
- 副标题样式：思源宋体 Regular，小号，浅灰色，宽间距
- 特效：无阴影 + 无描边 + 无发光（极简风格）
```

**生成效果**：
- ✅ 主标题"边界·融合"位于底部居中，使用思源宋体
- ✅ 深灰色文字与莫兰迪色系完美融合
- ✅ 正常字间距保持极简风格的克制感
- ✅ 无任何特效，符合极简主义理念
- ✅ 副标题使用宽间距，增强呼吸感和高级感

---

### 💡 最佳实践

#### 1. 文字内容原则

- ✅ **简洁有力**：标题控制在 4-10 个字以内
- ✅ **层次清晰**：主标题 > 副标题 > 正文，信息层级明确
- ✅ **重点突出**：最重要的信息放在主标题
- ✅ **易读性强**：避免过长的句子和复杂词汇

#### 2. 字体搭配技巧

- ✅ **不超过 3 种字体**：主标题、副标题、正文各一种
- ✅ **对比产生层次**：粗体标题 + 细体正文
- ✅ **风格统一**：现代配现代，传统配传统
- ✅ **可读性优先**：避免使用过于花哨的字体

#### 3. 位置布局建议

- ✅ **顶部居中**：正式、庄重，适合会议、峰会
- ✅ **底部居中**：稳定、平衡，适合展览、演出
- ✅ **左侧/右侧垂直**：创意、独特，适合艺术、设计
- ✅ **居中系列**：聚焦、突出，适合活动、宣传

#### 4. 特效使用原则

- ✅ **少即是多**：特效服务于可读性，不要过度
- ✅ **风格匹配**：科技感用发光，传统感用阴影
- ✅ **背景对比**：深色背景用浅色文字 + 阴影
- ✅ **适度原则**：轻微效果优于强烈效果

---

### ⚠️ 注意事项

#### Midjourney 文字渲染限制

1. **文字准确性**
   - Midjourney v6.0 可能无法完美渲染复杂中文
   - 建议生成多张选择最佳效果
   - 或使用后期软件（如 PS）修正文字

2. **文字长度**
   - 避免过长的标题（建议 4-10 字）
   - 正文信息尽量简化
   - 复杂信息可分多行

3. **字体识别**
   - 指定具体字体名称（如"思源黑体 Bold"）
   - 使用常见字体，避免冷门字体
   - 可以描述风格（如"粗体无衬线"）

4. **商用授权**
   - 免费字体：思源系列、站酷系列、阿里巴巴普惠体
   - 付费字体：造字工房、方正、汉仪等需购买授权

---

### 🎨 快速配置模板

#### 科技感海报
```json
{
  "textConfig": {
    "title": "你的标题",
    "position": "顶部居中",
    "titleStyle": {
      "fontFamily": "思源黑体 Bold",
      "fontSize": "超大",
      "color": "白色渐变到蓝色",
      "spacing": "宽"
    },
    "effects": {
      "shadow": "轻微阴影",
      "glow": "微弱发光",
      "gradient": "线性渐变"
    }
  }
}
```

#### 传统文化海报
```json
{
  "textConfig": {
    "title": "你的标题",
    "position": "左侧垂直",
    "titleStyle": {
      "fontFamily": "书法体",
      "fontSize": "超大",
      "color": "黑色或深红色",
      "spacing": "特宽"
    },
    "effects": {
      "shadow": "无",
      "stroke": "无",
      "glow": "无"
    }
  }
}
```

#### 商业活动海报
```json
{
  "textConfig": {
    "title": "你的标题",
    "position": "顶部居中",
    "titleStyle": {
      "fontFamily": "站酷高端黑",
      "fontSize": "超大",
      "color": "金色或银色",
      "spacing": "宽"
    },
    "effects": {
      "shadow": "明显阴影",
      "gradient": "线性渐变"
    }
  }
}
```

---

## Midjourney 技能详解

### 1. Midjourney 主海报生成

**技能名称**: `midjourney-poster-generator`

**功能**: 根据主题、风格、氛围生成专业级 Midjourney 海报提示词

**输入参数**:
- `theme` (必填): 海报主题
- `style` (可选): 艺术风格
- `mood` (可选): 氛围情绪
- `colorScheme` (可选): 色彩方案
- `aspectRatio` (可选): 画面比例，默认 2:3

#### 使用案例 1：爵士音乐节海报

**输入**:
```
使用 Midjourney 主海报生成技能

主题：国际爵士音乐节
风格：装饰艺术风格（Art Deco）
氛围：优雅复古
色彩：黑金奢华配色
比例：2:3
```

**输出提示词**:
```
International Jazz Music Festival poster, Art Deco style, elegant geometric patterns, golden saxophone silhouette centered, black and gold luxury color scheme, symmetrical composition, vintage typography, elegant and sophisticated mood, 1920s glamour aesthetic, high contrast, metallic gold foil texture, bold geometric borders, professional music event visual, 8K resolution --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
| 组成部分 | 内容 | 作用 |
|---------|------|------|
| 主体描述 | International Jazz Music Festival poster | 明确海报主题 |
| 艺术风格 | Art Deco style | 确定视觉风格基调 |
| 核心元素 | golden saxophone silhouette centered | 视觉焦点定位 |
| 构图方式 | symmetrical composition | 指导画面布局 |
| 色彩方案 | black and gold luxury color scheme | 统一色彩调性 |
| 装饰细节 | elegant geometric patterns, bold geometric borders | 增加风格细节 |
| 氛围营造 | elegant and sophisticated mood, 1920s glamour aesthetic | 强化情绪表达 |
| 质量保障 | professional music event visual, 8K resolution | 确保输出质量 |
| 技术参数 | --ar 2:3 --v 6.0 --style raw | Midjourney 特定参数 |

#### 使用案例 2：科技产品发布会

**输入**:
```
使用 Midjourney 主海报生成技能

主题：智能手机新品发布会
风格：极简未来主义
氛围：高端专业
色彩：黑 + 银 + 霓虹蓝
比例：16:9
```

**输出提示词**:
```
Smartphone product launch poster, minimalist futurism style, sleek smartphone product floating at center, black background with silver metallic accents, neon blue lighting strips, clean geometric composition, premium tech aesthetic, professional corporate visual, studio lighting, 8K resolution --ar 16:9 --v 6.0 --style raw
```

**提示词解析**:
- `minimalist futurism style` - 极简未来主义风格定位
- `sleek smartphone product floating at center` - 产品悬浮中心构图
- `black background with silver metallic accents` - 黑底银边配色
- `neon blue lighting strips` - 霓虹蓝灯带点缀
- `clean geometric composition` - 简洁几何构图
- `premium tech aesthetic` - 高端科技美学
- `studio lighting` - 专业影棚布光

---

### 2. Midjourney 艺术风格匹配

**技能名称**: `midjourney-style-matcher`

**功能**: 根据主题自动匹配艺术流派、艺术家、色彩调性、视觉关键词

**输入参数**:
- `theme` (必填): 主题或使用场景
- `industry` (可选): 所属行业
- `targetAudience` (可选): 目标受众

#### 使用案例：高端腕表发布会

**输入**:
```
使用 Midjourney 艺术风格匹配技能

主题：高端腕表品牌发布会
行业：奢侈品
目标受众：高净值人群
```

**输出**:
```
【艺术流派】Art Deco, Minimalism, Swiss Design, Luxury Branding, High-End Editorial
【代表艺术家】Helmut Newton, Irving Penn, Richard Avedon, Jean-Paul Goude, Fabien Baron
【色彩调性】Monochrome with Gold Accent, Deep Charcoal, Platinum Silver, Champagne Gold
【视觉关键词】Sophisticated, Timeless, Precise, Exclusive, Craftsmanship, Heritage, Elegance
【推荐风格组合】Art Deco + Monochrome with Gold Accent + Swiss Design Typography + Luxury Editorial Photography
```

**生成的提示词示例**:
```
Luxury watch brand launch poster, Art Deco and Minimalism fusion, monochrome with gold accent color scheme, Swiss Design typography, high-end editorial photography style, sophisticated and timeless aesthetic, precise craftsmanship visual, exclusive and heritage atmosphere, deep charcoal background, platinum silver and champagne gold details, professional product photography, 8K resolution --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
- 融合了 Art Deco 的奢华和 Minimalism 的简洁
- 使用单色 + 金色点缀的经典奢侈品配色
- 瑞士设计风格确保排版专业
- 高端杂志摄影风格提升质感

---

### 3. Midjourney 构图色彩优化

**技能名称**: `midjourney-composition-optimizer`

**功能**: 为现有海报设计提供专业级构图、色彩、排版优化建议

**输入参数**:
- `content` (必填): 现有提示词或设计描述
- `focusArea` (可选): 优化重点，默认"整体"
- `format` (可选): 输出格式，默认"竖版"

#### 使用案例：科技产品海报优化

**输入**:
```
使用 Midjourney 构图色彩优化技能

现有设计：科技产品海报，蓝色背景，中间放产品图片，上面写标题

优化重点：整体
格式：竖版
```

**输出**:
```
【构图方案】中心放射式构图 + 三分法结合，产品位于视觉中心偏上黄金分割点
【视觉焦点】产品主体占据画面 40% 面积，顶部留白用于标题，底部 1/3 区域放置辅助信息
【色彩搭配】主色：深空蓝 (#0A1628)，辅色：科技蓝 (#1E3A5F)，点缀色：霓虹青 (#00F0FF)
【排版层级】主标题：无衬线粗体 72pt 置于顶部 1/3 区域，副标题：中等字重 36pt，正文信息：细体 18pt 置于底部
【留白比例】顶部留白 25%，两侧各留白 15%，底部留白 20%
【情绪氛围】专业、高端、未来感、可信赖
【优化后完整提示词】Tech product launch poster, center radial composition with rule of thirds, premium smartphone product floating at golden ratio point, deep space blue background #0A1628, neon cyan accent lighting #00F0FF, volumetric light beams radiating from product, minimalist sans-serif typography hierarchy, 25% top white space for headline, professional corporate aesthetic, high-end tech visual, 8K resolution, studio lighting, product photography masterpiece --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
- `center radial composition with rule of thirds` - 中心放射 + 三分法构图
- `floating at golden ratio point` - 黄金分割点定位
- `deep space blue background #0A1628` - 精确色彩值
- `neon cyan accent lighting #00F0FF` - 霓虹青点缀光
- `volumetric light beams radiating from product` - 体积光放射效果
- `typography hierarchy` - 字体层级系统
- `25% top white space` - 顶部 25% 留白

---

### 4. Midjourney 系列海报批量生成

**技能名称**: `midjourney-series-generator`

**功能**: 根据同一主题一次生成 5 组不同风格但视觉统一的系列海报

**输入参数**:
- `theme` (必填): 系列海报统一主题
- `coreElement` (必填): 必须保持统一的核心视觉元素
- `colorBase` (可选): 统一的基础色彩基调
- `quantity` (可选): 生成数量，默认 5
- `aspectRatio` (可选): 画面比例，默认 2:3

#### 使用案例：城市马拉松系列海报

**输入**:
```
使用 Midjourney 系列海报批量生成技能

主题：城市马拉松比赛
核心元素：奔跑者剪影 + 城市天际线
基础色：橙色 + 深蓝
数量：5
比例：2:3
```

**输出**:
```
【系列海报 1/5 - 极简主义风格】
City Marathon poster, minimalist design, runner silhouette in bright orange against deep blue background, simple city skyline, clean geometric shapes, bold sans-serif typography, lots of negative space, modern sports event visual --ar 2:3 --v 6.0 --style raw

【系列海报 2/5 - 赛博朋克风格】
City Marathon poster, cyberpunk style, neon orange runner silhouette with light trails, futuristic city skyline with holographic buildings, volumetric fog, laser beams, urban night atmosphere --ar 2:3 --v 6.0 --style raw

【系列海报 3/5 - 包豪斯风格】
City Marathon poster, Bauhaus design movement, abstract geometric runner shapes, orange and deep blue color blocking, circular track pattern, grid-based layout, functional typography, classic modernist aesthetic --ar 2:3 --v 6.0 --style raw

【系列海报 4/5 - 动态模糊风格】
City Marathon poster, dynamic motion style, multiple runner silhouettes with motion blur, orange light streaks, city skyline at sunrise, energetic and fast-paced, action photography aesthetic --ar 2:3 --v 6.0 --style raw

【系列海报 5/5 - 手绘插画风格】
City Marathon poster, hand-drawn illustration style, orange ink runner silhouette, watercolor city skyline background, visible brush strokes, organic shapes, warm analog feel, artistic expression --ar 2:3 --v 6.0 --style raw

【视觉统一性说明】所有 5 组海报保持：奔跑者剪影、城市天际线、橙色 + 深蓝配色、马拉松主题氛围。通过不同艺术风格实现差异化。
```

**提示词解析**:

**系列 1 - 极简主义**:
- `minimalist design` - 极简设计理念
- `clean geometric shapes` - 简洁几何形状
- `lots of negative space` - 大量留白

**系列 2 - 赛博朋克**:
- `neon orange runner silhouette with light trails` - 霓虹光轨效果
- `holographic buildings` - 全息建筑
- `volumetric fog, laser beams` - 体积雾和激光束

**系列 3 - 包豪斯**:
- `Bauhaus design movement` - 包豪斯设计运动
- `abstract geometric runner shapes` - 抽象几何跑者形状
- `grid-based layout` - 网格布局

**系列 4 - 动态模糊**:
- `dynamic motion style` - 动态运动风格
- `motion blur` - 运动模糊效果
- `orange light streaks` - 橙色光带

**系列 5 - 手绘插画**:
- `hand-drawn illustration style` - 手绘插画风格
- `watercolor city skyline background` - 水彩城市背景
- `visible brush strokes` - 可见笔触

---

## NanoBanana 技能详解

### 5. NanoBanana 主海报生成

**技能名称**: `nanobanana-poster-generator`

**功能**: 专为 NanoBanana 优化的海报提示词生成器，强化角色一致性和 IP 稳定性

**输入参数**:
- `theme` (必填): 海报主题
- `character` (可选): 角色描述
- `characterFeatures` (可选): 角色特征细节
- `style` (可选): 艺术风格
- `mood` (可选): 氛围情绪
- `colorScheme` (可选): 色彩方案
- `aspectRatio` (可选): 画面比例，默认 2:3

#### 使用案例：游戏角色宣传海报

**输入**:
```
使用 NanoBanana 主海报生成技能

主题：游戏角色宣传海报
角色：魔法少女
角色特征：粉色双马尾长发，紫色大眼睛，穿着蓝白魔法少女制服，手持星星魔杖
风格：二次元动漫
氛围：梦幻可爱
色彩：粉紫 + 蓝白
比例：2:3
```

**输出提示词**:
```
Magical girl character, pink twin-tail long hair, purple big eyes, wearing blue-white magical girl uniform, holding star-topped magic wand, character identity lock, consistent facial features, stable character design, consistent body proportions, unchanged costume design, game character promotional poster, anime style, fantasy background with magical circles and sparkles, dynamic pose, soft pastel lighting, pink-purple and blue-white color scheme, cel shading, 8K resolution, dreamy and cute mood, character consistency lock, IP stable, professional anime poster --ar 2:3 --nb-v1
```

**提示词解析**:

**角色描述部分**:
- `pink twin-tail long hair` - 粉色双马尾长发
- `purple big eyes` - 紫色大眼睛
- `wearing blue-white magical girl uniform` - 穿着蓝白魔法少女制服
- `holding star-topped magic wand` - 手持星星魔杖

**角色一致性锁定**:
- `character identity lock` - 角色身份锁定
- `consistent facial features` - 一致的面部特征
- `stable character design` - 稳定的角色设计
- `consistent body proportions` - 一致的身体比例
- `unchanged costume design` - 不变的服装设计
- `character consistency lock` - 角色一致性锁定
- `IP stable` - IP 稳定

**场景和风格**:
- `fantasy background with magical circles and sparkles` - 魔法阵和闪光的奇幻背景
- `dynamic pose` - 动态姿势
- `soft pastel lighting` - 柔和的粉彩 lighting
- `cel shading` - 赛璐璐上色

**技术参数**:
- `--ar 2:3` - 2:3 画面比例
- `--nb-v1` - NanoBanana v1 引擎

---

### 6. NanoBanana 艺术风格匹配

**技能名称**: `nanobanana-style-matcher`

**功能**: NanoBanana 专用艺术风格匹配，支持 IP 风格定位和角色风格适配

**输入参数**:
- `theme` (必填): 主题或使用场景
- `characterType` (可选): 角色类型
- `ipGoal` (可选): IP 目标
- `industry` (可选): 所属行业

#### 使用案例：咖啡店品牌 IP

**输入**:
```
使用 NanoBanana 艺术风格匹配技能

主题：咖啡店品牌 IP
角色类型：可爱卡通吉祥物
IP 目标：品牌代言 + 周边产品
行业：餐饮
```

**输出**:
```
【艺术流派】Cartoon Network Style, Disney Style, Vector Art, Kawaii Culture, Pop Art
【代表艺术家】Craig McCracken, Pendleton Ward, Disney Character Designers, Sanrio Designers
【色彩调性】Warm Coffee Browns, Cream Whites, Accent Orange or Green, Soft Pastel Background
【视觉关键词】Cute, Friendly, Approachable, Simple Shapes, Bold Outlines, Expressive Eyes, Memorable Silhouette
【角色设计要点】简化造型便于识别和复制、夸张头部比例增加可爱度、设计标志性表情和姿势、加入咖啡相关元素（如咖啡豆帽子、拿铁拉花图案）、色彩不宜超过 5 种便于周边印刷
【IP 识别元素】标志性配色方案、独特发型或头饰、代表性道具（咖啡杯/咖啡豆）、品牌 logo 融合设计、可识别剪影轮廓
【推荐风格组合】Disney Cartoon Style + Warm Coffee Color Palette + Simple Vector Art + Kawaii Expression
```

**生成的提示词示例**:
```
Coffee shop mascot character, Disney cartoon style, cute cartoon character with coffee bean hat, warm coffee brown and cream white color scheme, simple vector art, kawaii expression, big expressive eyes, friendly smile, holding coffee cup, memorable silhouette, bold outlines, soft pastel background, brand ambassador design, merchandise ready, 8K resolution --ar 2:3 --nb-v1
```

**提示词解析**:
- `Disney cartoon style` - 迪士尼卡通风格
- `coffee bean hat` - 咖啡豆帽子（IP 识别元素）
- `warm coffee brown and cream white color scheme` - 温暖的咖啡棕 + 奶油白配色
- `simple vector art` - 简洁矢量艺术
- `kawaii expression` - 可爱表情
- `merchandise ready` - 适合周边制作

---

### 7. NanoBanana 构图色彩优化

**技能名称**: `nanobanana-composition-optimizer`

**功能**: NanoBanana 专用构图优化，强化角色姿态与场景协调，确保角色不崩坏

**输入参数**:
- `content` (必填): 现有提示词或设计描述
- `characterDescription` (可选): 角色详细描述
- `focusArea` (可选): 优化重点，默认"整体"
- `format` (可选): 输出格式，默认"竖版"

#### 使用案例：魔法少女角色优化

**输入**:
```
使用 NanoBanana 构图色彩优化技能

现有设计：魔法少女角色站在城市天台上，夜晚场景

角色描述：粉色双马尾长发，紫色大眼睛，穿着蓝白魔法少女制服，手持星星魔杖，身高 160cm，萝莉体型

优化重点：整体
格式：竖版
```

**输出**:
```
【构图方案】三分法构图，角色位于右侧黄金分割点，城市天际线作为背景层次
【角色姿态】动态姿态 - 魔法少女单脚站立于天台边缘，一手高举魔杖，一手轻按裙摆，披风飘扬
【场景融合】角色与城市夜景融合，魔杖光芒照亮周围，城市灯光作为背景散景
【视觉焦点】魔杖顶端的魔法光芒作为第一视觉焦点，角色面部作为第二焦点
【色彩搭配】主色：夜空深蓝 (#0B1026)，辅色：城市暖黄灯光，点缀色：魔法粉紫 (#FF69B4) 和星星金 (#FFD700)
【角色一致性锁定】pink twin-tail long hair, purple big eyes, blue-white magical girl uniform, star-topped magic wand, 160cm height, loli body type, consistent facial features, stable character design, fixed costume details, unchanged accessory placement, character identity lock
【优化后完整提示词】Magical girl character standing on city rooftop at night, pink twin-tail long hair, purple big eyes, wearing blue-white magical girl uniform, holding star-topped magic wand, 160cm height loli body type, dynamic pose with one leg on rooftop edge, one hand raising wand high, other hand holding skirt, cape flowing in wind, rule of thirds composition, character at right golden ratio point, city skyline background layers, magical glow from wand illuminating surroundings, city lights as bokeh background, deep night blue #0B1026 main color, warm yellow city lights, magical pink-purple #FF69B4 and star gold #FFD700 accent colors, volumetric lighting, particle effects, sparkles, urban fantasy atmosphere, consistent facial features, stable character design, fixed costume details, character identity lock, IP stable, professional anime poster, 8K resolution --ar 2:3 --nb-v1
```

**提示词解析**:

**构图优化**:
- `rule of thirds composition` - 三分法构图
- `character at right golden ratio point` - 角色位于右侧黄金分割点
- `city skyline background layers` - 城市天际线背景层次

**角色姿态**:
- `dynamic pose with one leg on rooftop edge` - 单脚站立于天台边缘的动态姿势
- `one hand raising wand high, other hand holding skirt` - 一手高举魔杖，一手轻按裙摆
- `cape flowing in wind` - 披风飘扬

**光影效果**:
- `magical glow from wand illuminating surroundings` - 魔杖光芒照亮周围
- `city lights as bokeh background` - 城市灯光作为背景散景
- `volumetric lighting, particle effects, sparkles` - 体积光、粒子效果、闪光

**角色锁定**:
- 完整的角色特征描述
- 多重一致性锁定关键词
- 确保 NanoBanana 生成时角色不崩坏

---

### 8. NanoBanana 系列海报批量生成

**技能名称**: `nanobanana-series-generator`

**功能**: NanoBanana 专用系列生成器，强制保持角色一致性、IP 稳定、多图统一

**输入参数**:
- `theme` (必填): 系列海报统一主题
- `characterDefinition` (必填): 完整角色定义
- `colorBase` (可选): 统一的基础色彩基调
- `ipElements` (可选): 必须保持的 IP 识别元素
- `quantity` (可选): 生成数量，默认 5
- `aspectRatio` (可选): 画面比例，默认 2:3

#### 使用案例：虚拟主播 IP 宣传系列

**输入**:
```
使用 NanoBanana 系列海报批量生成技能

主题：虚拟主播 IP 宣传系列
角色定义：银色长发及腰，蓝色挑染，金色眼眸，穿着黑红哥特萝莉装，佩戴蝙蝠翅膀头饰，手持麦克风，身高 165cm，纤细体型
基础色：黑 + 红 + 银
IP 元素：蝙蝠翅膀、麦克风、哥特萝莉装
数量：5
比例：2:3
```

**输出**:
```
【角色一致性锁定关键词】（每组必含）
Silver long hair to waist with blue highlights, golden eyes, wearing black-red gothic lolita dress, bat wing headpiece, holding microphone, 165cm height, slim body type, character identity lock, consistent facial features, stable character design, consistent body proportions, unchanged costume design, consistent expression style, fixed character color palette, IP stable, character consistency lock

【系列海报 1/5 - 舞台演出风格】
[完整角色锁定关键词], performing on concert stage, spotlight from above, audience light sticks in background, dynamic singing pose, confident expression, stage smoke effects, dramatic lighting, live performance atmosphere --ar 2:3 --nb-v1

【系列海报 2/5 - 哥特城堡风格】
[完整角色锁定关键词], standing on gothic castle balcony, full moon background, dark fantasy architecture, mysterious atmosphere, elegant pose, night sky with stars, volumetric fog, cinematic composition --ar 2:3 --nb-v1

【系列海报 3/5 - 赛博都市风格】
[完整角色锁定关键词], in cyberpunk city street at night, neon signs and holographic ads, rain reflections on pavement, futuristic atmosphere, cool pose leaning against wall, neon red and blue lighting --ar 2:3 --nb-v1

【系列海报 4/5 - 玫瑰花园风格】
[完整角色锁定关键词], in romantic rose garden, blooming red roses everywhere, soft natural lighting, elegant gazebo background, gentle pose holding rose, dreamy atmosphere, soft focus --ar 2:3 --nb-v1

【系列海报 5/5 - 录音室风格】
[完整角色锁定关键词], in professional recording studio, microphone stand and sound equipment, warm studio lighting, focused expression, professional singer atmosphere, modern music production environment --ar 2:3 --nb-v1

【IP 统一性说明】所有 5 组海报强制保持：银色长发蓝色挑染、金色眼眸、黑红哥特萝莉装、蝙蝠翅膀头饰、麦克风、165cm 纤细体型。通过角色锁定关键词确保 NanoBanana 生成时角色不崩坏、IP 高度统一。
```

**提示词解析**:

**角色锁定机制**:
每个提示词都包含完整的角色定义，确保：
- 发型发色一致：`Silver long hair to waist with blue highlights`
- 眼睛颜色一致：`golden eyes`
- 服装一致：`wearing black-red gothic lolita dress`
- 配饰一致：`bat wing headpiece, holding microphone`
- 体型一致：`165cm height, slim body type`
- 多重锁定：`character identity lock, consistent facial features, stable character design, IP stable`

**场景多样性**:
- 舞台演出：`concert stage, spotlight, audience light sticks`
- 哥特城堡：`gothic castle balcony, full moon, dark fantasy`
- 赛博都市：`cyberpunk city street, neon signs, holographic ads`
- 玫瑰花园：`romantic rose garden, blooming red roses`
- 录音室：`professional recording studio, microphone stand`

---

## 20 个完整提示词案例

### 案例 1-5：Midjourney 商业海报

#### 案例 1：科技产品发布会

**技能**: `midjourney-poster-generator`

**输入**:
- 主题：智能手机新品发布会
- 风格：极简未来主义
- 氛围：高端专业
- 色彩：黑 + 银 + 霓虹蓝
- 比例：16:9

**输出提示词**:
```
Smartphone product launch poster, minimalist futurism style, sleek smartphone product floating at center, black background with silver metallic accents, neon blue lighting strips, clean geometric composition, premium tech aesthetic, professional corporate visual, studio lighting, 8K resolution --ar 16:9 --v 6.0 --style raw
```

**提示词解析**:
- `minimalist futurism style` - 极简未来主义风格，去除多余元素
- `floating at center` - 中心悬浮构图，突出产品
- `silver metallic accents` - 银色金属点缀，提升质感
- `neon blue lighting strips` - 霓虹蓝灯带，增加科技感
- `premium tech aesthetic` - 高端科技美学定位

---

#### 案例 2：音乐节海报

**技能**: `midjourney-poster-generator`

**输入**:
- 主题：夏季电子音乐节
- 风格：赛博朋克 + 迷幻艺术
- 氛围：狂热活力
- 色彩：霓虹紫 + 荧光绿 + 粉红
- 比例：2:3

**输出提示词**:
```
Summer electronic music festival poster, cyberpunk and psychedelic art style, DJ silhouette with neon headphones, purple and fluorescent green and pink color scheme, laser beams and light trails, geometric patterns, energetic and wild atmosphere, rave culture visual, dynamic composition, 8K resolution --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
- `cyberpunk and psychedelic art style` - 赛博朋克 + 迷幻艺术融合
- `DJ silhouette with neon headphones` - DJ 剪影 + 霓虹耳机
- `laser beams and light trails` - 激光束 + 光轨效果
- `rave culture visual` - 锐舞文化视觉风格

---

#### 案例 3：艺术展览海报

**技能**: `midjourney-style-matcher`

**输入**:
- 主题：当代艺术展览
- 行业：文化艺术
- 目标受众：艺术爱好者

**输出风格建议**:
```
【艺术流派】Contemporary Art, Minimalism, Abstract Expressionism, Gallery Style, Museum Branding
【色彩调性】White Cube Gallery, Black Frame Accent, Neutral Tones, Bold Primary Color Pop
【视觉关键词】Sophisticated, Intellectual, Curated, Thought-Provoking, Artistic, Cultural
```

**生成提示词**:
```
Contemporary art exhibition poster, minimalism and abstract expressionism fusion, white cube gallery aesthetic, black frame accents, neutral background with bold primary color pop, sophisticated and intellectual atmosphere, curated visual, thought-provoking composition, museum branding quality, 8K resolution --ar 2:3 --v 6.0 --style raw
```

---

#### 案例 4：电影海报

**技能**: `midjourney-poster-generator`

**输入**:
- 主题：科幻电影《星际穿越》风格海报
- 风格：硬科幻 + 太空歌剧
- 氛围：史诗感、探索精神
- 色彩：深空黑 + 星云紫 + 恒星金

**输出提示词**:
```
Sci-fi movie poster, hard science fiction and space opera style, astronaut silhouette against massive black hole, deep space black with nebula purple and star gold, epic scale, sense of exploration, cosmic phenomenon, gravitational lensing effect, dramatic space lighting, cinematic composition, IMAX quality visual, 8K resolution --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
- `astronaut silhouette against massive black hole` - 宇航员剪影 + 黑洞背景
- `gravitational lensing effect` - 引力透镜效应（硬科幻元素）
- `epic scale, sense of exploration` - 史诗规模、探索精神
- `IMAX quality visual` - IMAX 级别视觉效果

---

#### 案例 5：餐饮品牌海报

**技能**: `midjourney-poster-generator`

**输入**:
- 主题：精品咖啡店开业海报
- 风格：北欧极简 + 手工艺风格
- 氛围：温暖、匠心
- 色彩：原木色 + 咖啡棕 + 奶油白

**输出提示词**:
```
Artisan coffee shop opening poster, Nordic minimalism and handcraft style fusion, pour-over coffee brewing scene, warm wood grain texture with coffee brown and cream white, natural lighting, cozy and crafted atmosphere, minimalist typography, hygge aesthetic, specialty coffee culture visual, 8K resolution --ar 2:3 --v 6.0 --style raw
```

**提示词解析**:
- `pour-over coffee brewing scene` - 手冲咖啡场景
- `warm wood grain texture` - 温暖木纹质感
- `hygge aesthetic` - 丹麦舒适美学
- `specialty coffee culture visual` - 精品咖啡文化视觉

---

### 案例 6-10：Midjourney 系列海报

#### 案例 6：品牌 VI 系列（5 张）

**技能**: `midjourney-series-generator`

**输入**:
- 主题：科技公司品牌 VI 海报
- 核心元素：品牌 Logo 几何图形
- 基础色：深蓝 + 白 + 银灰
- 数量：5

**输出**（节选 2 张）:
```
【系列 1 - 企业形象】
Tech company brand poster, corporate image style, abstract geometric logo pattern centered, deep blue and white and silver gray, clean professional layout, business formal aesthetic, trustworthy and innovative --ar 2:3 --v 6.0 --style raw

【系列 2 - 产品展示】
Tech company brand poster, product showcase style, geometric logo pattern as background frame, product silhouette highlighted, deep blue background with silver accents, modern tech presentation --ar 2:3 --v 6.0 --style raw
```

---

### 案例 11-15：NanoBanana 角色海报

#### 案例 11：游戏角色 - 剑士

**技能**: `nanobanana-poster-generator`

**输入**:
- 主题：奇幻游戏剑士角色
- 角色：年轻女剑士
- 特征：银色短发，绿色眼睛，穿着轻甲，手持长剑
- 风格：日式奇幻
- 色彩：银 + 绿 + 皮革棕

**输出提示词**:
```
Young female swordsman character, silver short hair, green eyes, wearing light armor with leather details, holding long sword, character identity lock, consistent facial features, stable character design, fantasy game poster, Japanese fantasy style, medieval castle background, dynamic battle pose, dramatic lighting, silver and green and leather brown color scheme, cel shading, 8K resolution --ar 2:3 --nb-v1
```

---

#### 案例 12：虚拟主播 - 兔耳娘

**技能**: `nanobanana-poster-generator`

**输入**:
- 主题：虚拟主播出道宣传
- 角色：兔耳少女
- 特征：粉色长发，红色兔耳，异色瞳（左蓝右粉），穿着偶像演出服
- 风格：偶像系二次元
- 色彩：粉 + 白 + 蓝

**输出提示词**:
```
Virtual streamer debut poster, bunny girl character, pink long hair with red bunny ears, heterochromia eyes (left blue right pink), wearing idol performance costume, character identity lock, consistent features, stable design, idol anime style, stage background with spotlights and hearts, cute and energetic pose, pink and white and blue color scheme, sparkles and stage effects, 8K resolution --ar 2:3 --nb-v1
```

**提示词解析**:
- `heterochromia eyes (left blue right pink)` - 异色瞳详细描述
- `idol performance costume` - 偶像演出服
- `stage background with spotlights and hearts` - 舞台背景 + 聚光灯 + 爱心
- `cute and energetic pose` - 可爱活力的姿势

---

### 案例 16-20：NanoBanana 系列海报

#### 案例 16：IP 角色日常系列（5 张）

**技能**: `nanobanana-series-generator`

**输入**:
- 主题：咖啡店吉祥物日常系列
- 角色定义：咖啡豆造型的卡通角色，棕色身体，绿色叶子头饰，大眼睛，微笑表情，手持咖啡杯
- 基础色：咖啡棕 + 绿 + 奶油白
- IP 元素：咖啡豆造型、绿叶头饰、咖啡杯
- 数量：5

**输出**（节选 3 张）:
```
【角色锁定关键词】
Coffee bean shaped cartoon character, brown body, green leaf headpiece, big expressive eyes, friendly smile, holding coffee cup, character identity lock, consistent features, stable design, IP stable

【系列 1 - 早晨咖啡】
[角色锁定关键词], morning scene in cozy cafe, sunlight through window, steaming coffee cup, warm and fresh atmosphere, soft morning lighting --ar 2:3 --nb-v1

【系列 2 - 制作拿铁】
[角色锁定关键词], making latte art at coffee machine, focused expression, milk pitcher in hand, professional barista scene, cafe interior background --ar 2:3 --nb-v1

【系列 3 - 与顾客互动】
[角色锁定关键词], interacting with customers at cafe counter, friendly wave gesture, happy expression, warm cafe atmosphere, customer service scene --ar 2:3 --nb-v1
```

---

## 提示词结构解析

### 标准提示词构成

每个生成的提示词都遵循以下结构：

```
【主体描述】+【艺术风格】+【构图方式】+【色彩方案】+【光影效果】+【细节装饰】+【质量描述】+【技术参数】
```

#### 示例解析

以爵士音乐节海报为例：

```
International Jazz Music Festival poster,          ← 主体描述：明确主题
Art Deco style,                                     ← 艺术风格：确定视觉风格
symmetrical composition,                            ← 构图方式：指导画面布局
black and gold luxury color scheme,                 ← 色彩方案：统一色彩调性
golden saxophone silhouette centered,               ← 视觉焦点：核心元素定位
elegant geometric patterns,                         ← 细节装饰：增加风格细节
volumetric lighting,                                ← 光影效果：营造氛围
professional music event visual,                    ← 质量描述：确保输出质量
8K resolution                                       ← 技术参数：分辨率要求
--ar 2:3 --v 6.0 --style raw                       ← 平台参数：Midjourney 特定
```

### 提示词质量要素

#### 1. 主体清晰
- ✅ 明确说明是什么类型的海报
- ✅ 突出核心视觉元素
- ✅ 避免模糊不清的描述

#### 2. 风格专业
- ✅ 使用艺术史术语（Art Deco、Bauhaus 等）
- ✅ 包含具体的艺术流派
- ✅ 参考知名艺术家风格

#### 3. 构图合理
- ✅ 提供明确的构图指导
- ✅ 包含视觉焦点定位
- ✅ 考虑画面平衡和层次

#### 4. 色彩协调
- ✅ 定义主色、辅色、点缀色
- ✅ 提供色彩情感定位
- ✅ 考虑色彩心理学

#### 5. 细节丰富
- ✅ 包含光影效果描述
- ✅ 添加质感细节
- ✅ 营造氛围情绪

#### 6. 参数完整
- ✅ 画面比例（--ar）
- ✅ 引擎版本（--v 或 --nb-v1）
- ✅ 风格参数（--style raw）

---

## 最佳实践

### 1. 提示词使用流程

```
1. 明确需求 → 2. 选择技能 → 3. 生成提示词 → 4. 查看解析 → 5. 使用提示词
```

#### 步骤说明

**步骤 1：明确需求**
- 确定海报主题
- 明确目标受众
- 考虑使用场景

**步骤 2：选择技能**
- 单张海报 → 主海报生成
- 风格不确定 → 艺术风格匹配
- 需要优化 → 构图色彩优化
- 系列海报 → 系列生成器
- 角色/IP → NanoBanana 系列

**步骤 3：生成提示词**
- 提供详细的输入参数
- 包含必要的细节描述
- 指定风格和色彩偏好

**步骤 4：查看解析**
- 理解提示词各部分作用
- 学习专业术语用法
- 掌握构图色彩原理

**步骤 5：使用提示词**
- 直接复制到 Midjourney 或 NanoBanana
- 根据需要微调参数
- 保存优质提示词作为模板

### 2. 提示词优化技巧

#### 技巧 1：增加细节

**基础版**:
```
Tech product poster, blue background
```

**优化版**:
```
Tech product poster, deep space blue #0A1628 background, neon cyan accent lighting, volumetric light beams, minimalist composition, premium corporate aesthetic
```

#### 技巧 2：使用专业术语

**基础版**:
```
Old style poster, fancy patterns
```

**优化版**:
```
Art Deco poster, elegant geometric patterns, metallic gold foil texture, 1920s glamour aesthetic
```

#### 技巧 3：明确构图

**基础版**:
```
Product in the middle
```

**优化版**:
```
Product floating at golden ratio point, rule of thirds composition, center radial layout
```

### 3. 角色一致性保障

使用 NanoBanana 技能时，确保角色一致性的关键：

#### 必须包含的锁定关键词

```
character identity lock
consistent facial features
stable character design
consistent body proportions
unchanged costume design
IP stable
character consistency lock
```

#### 角色定义模板

```
[发色发型], [眼睛颜色], wearing [服装描述], holding [道具], 
[身高] height, [体型] body type, 
character identity lock, consistent facial features, stable character design
```

---

## 常见问题

### Q1: 这些技能生成的是什么？

**A**: 这些技能生成的是**AI 绘画提示词**（Prompt），不是直接生成图片。

生成的提示词可以直接用于：
- Midjourney（通过 Discord）
- NanoBanana（通过相应平台）
- 其他支持英文提示词的 AI 绘画工具

### Q2: 如何使用生成的提示词？

**A**: 复制生成的提示词，粘贴到对应的 AI 绘画工具中即可。

**Midjourney 使用方式**:
```
在 Discord 中输入：/imagine prompt: [粘贴提示词]
```

**NanoBanana 使用方式**:
```
在对应平台输入框中粘贴提示词，点击生成
```

### Q3: 提示词可以修改吗？

**A**: 可以且推荐根据个人需求调整。

**可调整的部分**:
- 色彩值（如 `#0A1628` 改为其他颜色）
- 画面比例（如 `--ar 2:3` 改为 `--ar 16:9`）
- 具体元素（如添加品牌 Logo 描述）
- 氛围情绪（如从 `elegant` 改为 `energetic`）

### Q4: 如何确保角色在多张图中保持一致？

**A**: 使用 NanoBanana 系列技能，并包含以下要素：

1. **完整的角色定义**（发色、眼睛、服装、道具等）
2. **多重锁定关键词**（character identity lock、consistent facial features 等）
3. **统一的 IP 元素**（标志性配色、头饰、道具等）
4. **使用 `--nb-v1` 参数**（NanoBanana v1 引擎）

### Q5: 提示词太长会影响生成吗？

**A**: 不会。Midjourney 和 NanoBanana 都能处理长提示词。

**建议**:
- 保持提示词结构清晰
- 使用逗号分隔不同元素
- 重要的元素放在前面
- 包含必要的技术参数

### Q6: 可以混合使用多个技能吗？

**A**: 可以。常见组合：

**组合 1**: 风格匹配 → 主海报生成
```
1. 先用风格匹配技能确定艺术方向
2. 将推荐风格用于主海报生成
```

**组合 2**: 主海报生成 → 构图优化
```
1. 先生成基础海报提示词
2. 用构图优化技能改进
```

**组合 3**: 系列生成 → 单张优化
```
1. 用系列生成创建 5 个版本
2. 选择最满意的用构图优化进一步改进
```

---

## 总结

### 🎯 核心要点

1. **技能定位**: 生成专业的 AI 绘画提示词，不是直接生成图片
2. **提示词结构**: 主体 + 风格 + 构图 + 色彩 + 光影 + 细节 + 参数
3. **角色一致性**: 使用 NanoBanana 技能 + 锁定关键词
4. **系列统一性**: 保持核心元素一致，变化艺术风格

### 📚 学习路径

```
新手 → 使用主海报生成技能 → 查看提示词解析 → 学习构成原理 
     → 尝试艺术风格匹配 → 理解风格术语 → 积累专业词汇
     → 使用构图优化技能 → 掌握构图原理 → 提升审美水平
     → 挑战系列生成 → 学习统一性设计 → 成为提示词专家
```

### 💡 进阶建议

1. **建立提示词库**: 保存优质提示词作为模板
2. **学习艺术史**: 了解不同艺术流派特点
3. **研究色彩学**: 掌握色彩搭配原理
4. **练习构图**: 理解视觉焦点和画面平衡
5. **分析案例**: 拆解优秀海报的构成要素

---

<div align="center">

**用专业提示词，创造卓越海报！** 🎨✨

</div>

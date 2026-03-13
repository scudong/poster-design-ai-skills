# 使用文档

本指南将详细介绍如何使用海报设计 AI 技能工具包的 8 个技能，包含 20 个完整提示词案例。

---

## 📖 目录

1. [技能使用总览](#技能使用总览)
2. [Midjourney 技能详解](#midjourney-技能详解)
3. [NanoBanana 技能详解](#nanobanana-技能详解)
4. [20 个提示词案例](#20-个提示词案例)
5. [最佳实践](#最佳实践)
6. [常见问题](#常见问题)

---

## 技能使用总览

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

| 需求场景 | 推荐技能 |
|---------|---------|
| 快速生成单张海报 | 主海报生成技能 |
| 不确定用什么风格 | 艺术风格匹配技能 |
| 优化现有设计 | 构图色彩优化技能 |
| 需要系列海报 | 系列海报批量生成技能 |
| 涉及角色/IP 设计 | NanoBanana 系列技能 |

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

**使用示例**:
```
使用 Midjourney 主海报生成技能

主题：国际爵士音乐节
风格：装饰艺术风格（Art Deco）
氛围：优雅复古
色彩：黑金奢华配色
比例：2:3
```

**输出示例**:
```
International Jazz Music Festival poster, Art Deco style, elegant geometric patterns, golden saxophone silhouette centered, black and gold luxury color scheme, symmetrical composition, vintage typography, elegant and sophisticated mood, 1920s glamour aesthetic, high contrast, metallic gold foil texture, bold geometric borders, professional music event visual, 8K resolution --ar 2:3 --v 6.0 --style raw
```

---

### 2. Midjourney 艺术风格匹配

**技能名称**: `midjourney-style-matcher`

**功能**: 根据主题自动匹配艺术流派、艺术家、色彩调性、视觉关键词

**输入参数**:
- `theme` (必填): 主题或使用场景
- `industry` (可选): 所属行业
- `targetAudience` (可选): 目标受众

**使用示例**:
```
使用 Midjourney 艺术风格匹配技能

主题：高端腕表品牌发布会
行业：奢侈品
目标受众：高净值人群
```

**输出示例**:
```
【艺术流派】Art Deco, Minimalism, Swiss Design, Luxury Branding, High-End Editorial
【代表艺术家】Helmut Newton, Irving Penn, Richard Avedon, Jean-Paul Goude, Fabien Baron
【色彩调性】Monochrome with Gold Accent, Deep Charcoal, Platinum Silver, Champagne Gold
【视觉关键词】Sophisticated, Timeless, Precise, Exclusive, Craftsmanship, Heritage, Elegance
【推荐风格组合】Art Deco + Monochrome with Gold Accent + Swiss Design Typography + Luxury Editorial Photography
```

---

### 3. Midjourney 构图色彩优化

**技能名称**: `midjourney-composition-optimizer`

**功能**: 为现有海报设计提供专业级构图、色彩、排版优化建议

**输入参数**:
- `content` (必填): 现有提示词或设计描述
- `focusArea` (可选): 优化重点，默认"整体"
- `format` (可选): 输出格式，默认"竖版"

**使用示例**:
```
使用 Midjourney 构图色彩优化技能

现有设计：科技产品海报，蓝色背景，中间放产品图片，上面写标题

优化重点：整体
格式：竖版
```

**输出示例**:
```
【构图方案】中心放射式构图 + 三分法结合，产品位于视觉中心偏上黄金分割点
【视觉焦点】产品主体占据画面 40% 面积，顶部留白用于标题，底部 1/3 区域放置辅助信息
【色彩搭配】主色：深空蓝 (#0A1628)，辅色：科技蓝 (#1E3A5F)，点缀色：霓虹青 (#00F0FF)
【排版层级】主标题：无衬线粗体 72pt 置于顶部 1/3 区域，副标题：中等字重 36pt，正文信息：细体 18pt 置于底部
【留白比例】顶部留白 25%，两侧各留白 15%，底部留白 20%
【情绪氛围】专业、高端、未来感、可信赖
【优化后完整提示词】Tech product launch poster, center radial composition with rule of thirds, premium smartphone product floating at golden ratio point, deep space blue background #0A1628, neon cyan accent lighting #00F0FF, volumetric light beams radiating from product, minimalist sans-serif typography hierarchy, 25% top white space for headline, professional corporate aesthetic, high-end tech visual, 8K resolution, studio lighting, product photography masterpiece --ar 2:3 --v 6.0 --style raw
```

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

**使用示例**:
```
使用 Midjourney 系列海报批量生成技能

主题：城市马拉松比赛
核心元素：奔跑者剪影 + 城市天际线
基础色：橙色 + 深蓝
数量：5
比例：2:3
```

**输出示例**:
```
【系列海报 1/5 - 极简主义风格】
City Marathon poster, minimalist design, runner silhouette in bright orange against deep blue background, simple city skyline, clean geometric shapes, bold sans-serif typography, lots of negative space, modern sports event visual --ar 2:3 --v 6.0 --style raw

【系列海报 2/5 - 赛博朋克风格】
City Marathon poster, cyberpunk style, neon orange runner silhouette with light trails, futuristic city skyline with holographic buildings, volumetric fog, laser beams, dynamic motion blur, urban night atmosphere --ar 2:3 --v 6.0 --style raw

【系列海报 3/5 - 包豪斯风格】
City Marathon poster, Bauhaus design movement, abstract geometric runner shapes, orange and deep blue color blocking, circular track pattern, grid-based layout, functional typography, classic modernist aesthetic --ar 2:3 --v 6.0 --style raw

【系列海报 4/5 - 动态模糊风格】
City Marathon poster, dynamic motion style, multiple runner silhouettes with motion blur, orange light streaks, city skyline at sunrise, energetic and fast-paced, action photography aesthetic --ar 2:3 --v 6.0 --style raw

【系列海报 5/5 - 手绘插画风格】
City Marathon poster, hand-drawn illustration style, orange ink runner silhouette, watercolor city skyline background, visible brush strokes, organic shapes, warm analog feel, artistic expression --ar 2:3 --v 6.0 --style raw

【视觉统一性说明】所有 5 组海报保持：奔跑者剪影、城市天际线、橙色 + 深蓝配色、马拉松主题氛围。通过不同艺术风格实现差异化。
```

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

**使用示例**:
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

**输出示例**:
```
Magical girl character, pink twin-tail long hair, purple big eyes, wearing blue-white magical girl uniform, holding star-topped magic wand, character identity lock, consistent facial features, stable character design, consistent body proportions, unchanged costume design, game character promotional poster, anime style, fantasy background with magical circles and sparkles, dynamic pose, soft pastel lighting, pink-purple and blue-white color scheme, cel shading, 8K resolution, dreamy and cute mood, character consistency lock, IP stable, professional anime poster --ar 2:3 --nb-v1
```

---

### 6. NanoBanana 艺术风格匹配

**技能名称**: `nanobanana-style-matcher`

**功能**: NanoBanana 专用艺术风格匹配，支持 IP 风格定位和角色风格适配

**输入参数**:
- `theme` (必填): 主题或使用场景
- `characterType` (可选): 角色类型
- `ipGoal` (可选): IP 目标
- `industry` (可选): 所属行业

**使用示例**:
```
使用 NanoBanana 艺术风格匹配技能

主题：咖啡店品牌 IP
角色类型：可爱卡通吉祥物
IP 目标：品牌代言 + 周边产品
行业：餐饮
```

**输出示例**:
```
【艺术流派】Cartoon Network Style, Disney Style, Vector Art, Kawaii Culture, Pop Art
【代表艺术家】Craig McCracken, Pendleton Ward, Disney Character Designers, Sanrio Designers
【色彩调性】Warm Coffee Browns, Cream Whites, Accent Orange or Green, Soft Pastel Background
【视觉关键词】Cute, Friendly, Approachable, Simple Shapes, Bold Outlines, Expressive Eyes, Memorable Silhouette
【角色设计要点】简化造型便于识别和复制、夸张头部比例增加可爱度、设计标志性表情和姿势、加入咖啡相关元素（如咖啡豆帽子、拿铁拉花图案）、色彩不宜超过 5 种便于周边印刷
【IP 识别元素】标志性配色方案、独特发型或头饰、代表性道具（咖啡杯/咖啡豆）、品牌 logo 融合设计、可识别剪影轮廓
【推荐风格组合】Disney Cartoon Style + Warm Coffee Color Palette + Simple Vector Art + Kawaii Expression
```

---

### 7. NanoBanana 构图色彩优化

**技能名称**: `nanobanana-composition-optimizer`

**功能**: NanoBanana 专用构图优化，强化角色姿态与场景协调，确保角色不崩坏

**输入参数**:
- `content` (必填): 现有提示词或设计描述
- `characterDescription` (可选): 角色详细描述
- `focusArea` (可选): 优化重点，默认"整体"
- `format` (可选): 输出格式，默认"竖版"

**使用示例**:
```
使用 NanoBanana 构图色彩优化技能

现有设计：魔法少女角色站在城市天台上，夜晚场景

角色描述：粉色双马尾长发，紫色大眼睛，穿着蓝白魔法少女制服，手持星星魔杖，身高 160cm，萝莉体型

优化重点：整体
格式：竖版
```

**输出示例**:
```
【构图方案】三分法构图，角色位于右侧黄金分割点，城市天际线作为背景层次
【角色姿态】动态姿态 - 魔法少女单脚站立于天台边缘，一手高举魔杖，一手轻按裙摆，披风飘扬
【场景融合】角色与城市夜景融合，魔杖光芒照亮周围，城市灯光作为背景散景
【视觉焦点】魔杖顶端的魔法光芒作为第一视觉焦点，角色面部作为第二焦点
【色彩搭配】主色：夜空深蓝 (#0B1026)，辅色：城市暖黄灯光，点缀色：魔法粉紫 (#FF69B4) 和星星金 (#FFD700)
【角色一致性锁定】pink twin-tail long hair, purple big eyes, blue-white magical girl uniform, star-topped magic wand, 160cm height, loli body type, consistent facial features, stable character design, fixed costume details, unchanged accessory placement, character identity lock
【优化后完整提示词】Magical girl character standing on city rooftop at night, pink twin-tail long hair, purple big eyes, wearing blue-white magical girl uniform, holding star-topped magic wand, 160cm height loli body type, dynamic pose with one leg on rooftop edge, one hand raising wand high, other hand holding skirt, cape flowing in wind, rule of thirds composition, character at right golden ratio point, city skyline background layers, magical glow from wand illuminating surroundings, city lights as bokeh background, deep night blue #0B1026 main color, warm yellow city lights, magical pink-purple #FF69B4 and star gold #FFD700 accent colors, volumetric lighting, particle effects, sparkles, urban fantasy atmosphere, consistent facial features, stable character design, fixed costume details, character identity lock, IP stable, professional anime poster, 8K resolution --ar 2:3 --nb-v1
```

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

**使用示例**:
```
使用 NanoBanana 系列海报批量生成技能

主题：虚拟主播 IP 宣传系列
角色定义：银色长发及腰，蓝色挑染，金色眼眸，穿着黑红哥特萝莉装，佩戴蝙蝠翅膀头饰，手持麦克风，身高 165cm，纤细体型
基础色：黑 + 红 + 银
IP 元素：蝙蝠翅膀、麦克风、哥特萝莉装
数量：5
比例：2:3
```

**输出示例**:
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

---

## 20 个提示词案例

### 案例 1-5：Midjourney 商业海报

#### 案例 1：科技产品发布会

```
使用技能：midjourney-poster-generator

输入：
- 主题：智能手机新品发布会
- 风格：极简未来主义
- 氛围：高端专业
- 色彩：黑 + 银 + 霓虹蓝
- 比例：16:9

输出：
Smartphone product launch poster, minimalist futurism style, sleek smartphone product floating at center, black background with silver metallic accents, neon blue lighting strips, clean geometric composition, premium tech aesthetic, professional corporate visual, studio lighting, 8K resolution, high-end product photography --ar 16:9 --v 6.0 --style raw
```

#### 案例 2：音乐节海报

```
使用技能：midjourney-poster-generator

输入：
- 主题：夏季电子音乐节
- 风格：赛博朋克 + 迷幻艺术
- 氛围：狂热活力
- 色彩：霓虹紫 + 荧光绿 + 粉红
- 比例：2:3

输出：
Summer electronic music festival poster, cyberpunk and psychedelic art style, DJ silhouette with neon headphones, purple and fluorescent green and pink color scheme, laser beams and light trails, geometric patterns, energetic and wild atmosphere, rave culture visual, dynamic composition, 8K resolution --ar 2:3 --v 6.0 --style raw
```

#### 案例 3：艺术展览海报

```
使用技能：midjourney-style-matcher

输入：
- 主题：当代艺术展览
- 行业：文化艺术
- 目标受众：艺术爱好者

输出：
【艺术流派】Contemporary Art, Minimalism, Abstract Expressionism, Conceptual Art, Gallery White Cube
【代表艺术家】Yayoi Kusama, Banksy, Ai Weiwei, Olafur Eliasson, Anish Kapoor
【色彩调性】Gallery White, Charcoal Gray, Bold Accent Colors, Monochrome with Red
【视觉关键词】Sophisticated, Intellectual, Provocative, Minimal, Bold, Conceptual, Cultural
【推荐风格组合】Contemporary Minimalism + Gallery White Background + Bold Typography + Conceptual Photography
```

#### 案例 4：品牌活动系列海报

```
使用技能：midjourney-series-generator

输入：
- 主题：咖啡品牌春季促销
- 核心元素：咖啡杯 + 樱花
- 基础色：粉 + 棕 + 白
- 数量：5

输出：5 组不同风格的咖啡品牌海报（极简、手绘、水彩、拼贴、3D 渲染）
```

#### 案例 5：房地产广告海报

```
使用技能：midjourney-composition-optimizer

输入：
- 内容：高端公寓广告，图片是建筑外观，加上价格信息
- 优化重点：整体
- 格式：竖版

输出：完整优化方案，包含黄金分割构图、奢华配色、高端排版层级
```

---

### 案例 6-10：NanoBanana 角色 IP

#### 案例 6：虚拟主播出道宣传

```
使用技能：nanobanana-poster-generator

输入：
- 主题：虚拟主播出道宣传
- 角色：二次元少女
- 特征：粉色长发，蓝色蝴蝶结，偶像演出服，手持麦克风
- 风格：日系偶像
- 色彩：粉 + 白 + 金

输出：
Virtual idol debut poster, anime girl character, pink long hair with blue bow, wearing white-gold idol performance outfit, holding microphone, character identity lock, consistent facial features, stable character design, stage spotlight, sparkles and heart effects, pink-white-gold color scheme, cute and energetic mood, professional anime poster --ar 2:3 --nb-v1
```

#### 案例 7：游戏角色设计

```
使用技能：nanobanana-style-matcher

输入：
- 主题：奇幻 RPG 游戏角色
- 角色类型：精灵法师
- IP 目标：游戏主角 + 周边开发
- 行业：游戏

输出：完整的奇幻风格指南，包含角色设计要点和 IP 元素建议
```

#### 案例 8：品牌吉祥物系列

```
使用技能：nanobanana-series-generator

输入：
- 主题：奶茶品牌吉祥物宣传
- 角色定义：Q 版小熊，棕色毛发，戴着奶茶杯帽子，围着条纹围巾，手持珍珠奶茶杯
- 基础色：棕 + 白 + 粉
- IP 元素：奶茶杯帽子、珍珠奶茶杯
- 数量：5

输出：5 组不同场景的吉祥物海报（店内、户外、节日、季节、促销）
```

#### 案例 9：漫画角色设定

```
使用技能：nanobanana-composition-optimizer

输入：
- 内容：热血少年漫画主角，站在天台上
- 角色描述：黑色刺猬头，橙色头带，穿着橙色运动外套，蓝色牛仔裤，175cm，健壮体型
- 优化重点：角色姿态
- 格式：竖版

输出：优化的角色姿态和场景融合方案
```

#### 案例 10：儿童绘本角色

```
使用技能：nanobanana-poster-generator

输入：
- 主题：儿童绘本封面
- 角色：小兔子
- 特征：白色毛发，粉色耳朵内侧，蓝色背带裤，抱着胡萝卜玩偶
- 风格：温馨手绘
- 色彩：柔和 pastel 色系

输出：温馨可爱的儿童绘本封面提示词
```

---

### 案例 11-15：活动宣传海报

#### 案例 11：婚礼邀请函

```
使用技能：midjourney-poster-generator

输入：
- 主题：婚礼邀请函
- 风格：浪漫水彩
- 氛围：温馨优雅
- 色彩：香槟金 + 玫瑰金 + 白
- 比例：方形

输出：
Wedding invitation poster, romantic watercolor style, elegant floral arrangements, champagne gold and rose gold and white color scheme, soft pastel background, delicate calligraphy typography, warm and elegant atmosphere, dreamy wedding aesthetic, 8K resolution --ar 1:1 --v 6.0 --style raw
```

#### 案例 12：美食节海报

```
使用技能：midjourney-series-generator

输入：
- 主题：国际美食节
- 核心元素：地球仪 + 各国美食图标
- 基础色：暖橙色系
- 数量：5

输出：5 组不同国家风格的美食节海报
```

#### 案例 13：健身俱乐部广告

```
使用技能：midjourney-poster-generator

输入：
- 主题：健身俱乐部开业
- 风格：动感活力
- 氛围：激励向上
- 色彩：黑 + 红 + 黄
- 比例：2:3

输出：
Fitness club grand opening poster, dynamic and energetic style, muscular athlete silhouette in action pose, black background with red and yellow accents, dramatic lighting, motion blur effects, motivational and inspiring atmosphere, bold typography, high contrast visual --ar 2:3 --v 6.0 --style raw
```

#### 案例 14：教育培训机构宣传

```
使用技能：midjourney-composition-optimizer

输入：
- 内容：儿童编程培训，图片是孩子在电脑前学习
- 优化重点：色彩和排版
- 格式：横版

输出：优化的儿童友好配色和清晰信息层级
```

#### 案例 15：车展宣传海报

```
使用技能：midjourney-poster-generator

输入：
- 主题：国际汽车展览会
- 风格：速度感 + 未来感
- 氛围：震撼激情
- 色彩：深蓝 + 银 + 红
- 比例：16:9

输出：
International auto show poster, speed and futuristic style, sports car with motion blur on racetrack, deep blue and silver and red color scheme, dramatic low angle shot, dynamic composition, light trails, exciting and passionate atmosphere, high-end automotive photography --ar 16:9 --v 6.0 --style raw
```

---

### 案例 16-20：NanoBanana 进阶应用

#### 案例 16：盲盒 IP 系列

```
使用技能：nanobanana-series-generator

输入：
- 主题：森林精灵盲盒系列
- 角色定义：Q 版精灵，尖耳朵，绿色短发，穿着树叶连衣裙，手持魔法棒，背后有小翅膀
- 基础色：绿 + 棕 + 金
- IP 元素：尖耳朵、树叶裙、魔法棒、翅膀
- 数量：5

输出：5 组不同森林场景的精灵海报（晨雾、阳光、雨天、夜晚、秋季）
```

#### 案例 17：电竞战队宣传

```
使用技能：nanobanana-poster-generator

输入：
- 主题：电竞战队宣传
- 角色：电竞选手二次元形象
- 特征：银色短发，戴着电竞耳机，穿着战队队服，手持游戏鼠标
- 风格：赛博电竞
- 色彩：战队色（蓝 + 白）

输出：
Esports team promotional poster, anime character, silver short hair wearing gaming headset, team jersey in blue and white, holding gaming mouse, cyber esports style, neon blue lighting, tech background with circuit patterns, competitive and professional atmosphere, character consistency lock --ar 2:3 --nb-v1
```

#### 案例 18：节日促销海报

```
使用技能：nanobanana-series-generator

输入：
- 主题：圣诞节促销系列
- 角色定义：圣诞精灵少女，红色双马尾，绿色眼睛，穿着红绿圣诞装，戴着圣诞帽，手持礼物袋
- 基础色：红 + 绿 + 金
- IP 元素：圣诞帽、礼物袋
- 数量：5

输出：5 组不同圣诞场景（雪景、室内、礼物堆、驯鹿、圣诞树）
```

#### 案例 19：美妆品牌 IP

```
使用技能：nanobanana-style-matcher

输入：
- 主题：美妆品牌 IP 形象
- 角色类型：时尚都市女性
- IP 目标：品牌代言 + 产品包装
- 行业：美妆

输出：完整的美妆风格指南和角色设计建议
```

#### 案例 20：旅游宣传系列

```
使用技能：nanobanana-series-generator

输入：
- 主题：日本旅游宣传
- 角色定义：旅游博主少女，棕色长发，相机挂在脖子上，穿着休闲旅行装，背着双肩包
- 基础色：根据场景变化
- IP 元素：相机、双肩包
- 数量：5

输出：5 组日本不同景点（樱花、神社、都市、温泉、雪景）
```

---

## 最佳实践

### 1. 提示词优化技巧

✅ **好的做法**:
- 具体描述角色特征（发型、发色、眼睛、服装、配饰）
- 使用明确的色彩值（如 #FF69B4）
- 指定构图方式（三分法、黄金分割、中心放射）
- 包含光影描述（体积光、轮廓光、柔光）
- 设定画面情绪和氛围

❌ **避免**:
- 模糊的描述（"好看"、"漂亮"）
- 过多冲突的风格词
- 忽略角色一致性关键词
- 缺少比例参数

### 2. 角色一致性最佳实践

**NanoBanana 角色锁定模板**:
```
{角色定义}, character identity lock, consistent facial features, stable character design, consistent body proportions, unchanged costume design, consistent expression style, fixed character color palette, IP stable, character consistency lock
```

**必须包含的 7 要素**:
1. 发型和发色
2. 眼睛形状和颜色
3. 服装款式和颜色
4. 配饰细节
5. 体型和身高
6. 表情风格
7. 标志性 IP 元素

### 3. 系列海报统一性技巧

- 使用相同的 `coreElement` 或 `characterDefinition`
- 保持基础色彩基调一致
- 在每组提示词开头重复锁定关键词
- 通过场景、光影、风格制造差异化
- 确保 IP 识别元素在所有组中出现

### 4. Midjourney vs NanoBanana 选择

| 场景 | 推荐平台 |
|------|---------|
| 风景、建筑、抽象艺术 | Midjourney |
| 角色设计、IP 开发 | NanoBanana |
| 商业海报、活动 KV | Midjourney |
| 动漫、游戏角色 | NanoBanana |
| 系列角色海报 | NanoBanana |
| 系列风景/概念海报 | Midjourney |

---

## 常见问题

### Q1: 如何获得更高质量的海报？

**A**: 
1. 使用 8K resolution 关键词
2. 添加专业术语（professional poster design, art direction）
3. 指定具体参数（--v 6.0 --style raw）
4. 使用构图技能优化布局

### Q2: 角色总是画崩怎么办？

**A**:
1. 使用 NanoBanana 而非 Midjourney
2. 在提示词开头重复完整角色定义
3. 添加角色锁定关键词（character identity lock 等）
4. 使用 `nanobanana-series-generator` 的强制锁定功能

### Q3: 如何生成中文海报？

**A**:
1. 技能接受中文输入，自动转换为英文提示词
2. 如需中文文字，在提示词中添加：`Chinese typography, {你的中文文字}`
3. 注意：AI 生成的文字可能有误，建议后期 PS 添加文字

### Q4: 系列海报如何保持统一？

**A**:
1. 使用系列生成技能（而非手动生成）
2. 确保核心元素/IP 元素明确定义
3. 保持基础色彩一致
4. 检查每组提示词都包含统一元素

### Q5: 如何调整海报比例？

**A**:
- Midjourney: 使用 `--ar 比例` 参数（如 --ar 2:3, --ar 16:9, --ar 1:1）
- NanoBanana: 使用 `--ar 比例` 参数
- 在输入时直接指定 `aspectRatio` 参数

### Q6: 提示词太长怎么办？

**A**:
1. 技能会自动优化长度
2. 保留核心要素，删除冗余描述
3. 使用缩写和关键词而非完整句子
4. Midjourney v6 支持较长提示词，无需过度担心

### Q7: 如何商用这些海报？

**A**:
1. 本工具包采用 MIT 许可，可自由商用
2. 生成的海报版权归您所有
3. 注意：AI 生成内容的版权法律仍在发展中，建议咨询法律专业人士

---

## 获取帮助

如遇到其他问题：

1. 查看 [安装教程](INSTALL.md)
2. 查阅 [故障排查文档](docs/troubleshooting.md)
3. 提交 [GitHub Issue](https://github.com/scudong/poster-design-ai-skills/issues)

---

<div align="center">

**祝您创作出精彩的海报作品！🎨**

</div>

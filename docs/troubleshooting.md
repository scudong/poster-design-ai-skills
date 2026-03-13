# 429/1113 报错解决方案

本文档提供 429（API 限流）和 1113（配置错误）错误的完整解决方案，适用于 Cline 和智谱 AI 平台。

---

## 📋 错误代码说明

### 429 Too Many Requests

**含义**: API 请求频率过高，触发限流机制

**常见原因**:
- 短时间内发送过多请求
- 多个技能同时调用 API
- 订阅配额已用尽
- 网络重试机制导致请求堆积

### 1113 Configuration Error

**含义**: API 配置错误，通常与认证或端点设置相关

**常见原因**:
- API Key 无效或过期
- API 端点配置错误
- 认证格式不正确
- 账户欠费或暂停

---

## 🔧 Cline 平台解决方案

### 问题 1: 429 限流错误

#### 症状
```
Error 429: Too Many Requests
Rate limit exceeded. Please try again later.
```

#### 解决方案

**方法 1: 添加请求延迟**

在 Cline 设置中配置请求间隔：

```json
{
  "requestDelay": 2000,  // 请求间隔 2 秒
  "maxRetries": 3,
  "retryDelay": 5000
}
```

**方法 2: 升级订阅**

1. 访问 Cline 官网
2. 升级到更高配额套餐
3. 或购买额外配额包

**方法 3: 使用本地模型**

如条件允许，使用本地部署的模型：

```bash
# 使用 Ollama 部署本地模型
ollama run llama2

# 配置 Cline 使用本地模型
export CLINE_API_ENDPOINT="http://localhost:11434"
```

**方法 4: 批量请求优化**

避免同时调用多个技能，改为顺序执行：

```javascript
// ❌ 错误：并发请求
Promise.all([
  callSkill1(),
  callSkill2(),
  callSkill3()
]);

// ✅ 正确：顺序执行
await callSkill1();
await callSkill2();
await callSkill3();
```

---

### 问题 2: 1113 配置错误

#### 症状
```
Error 1113: Configuration Error
Invalid API key or endpoint
```

#### 解决方案

**方法 1: 检查 API Key**

1. 登录 Cline 控制台
2. 进入 API Keys 页面
3. 确认 API Key 状态为 Active
4. 复制最新的 API Key

**方法 2: 更新配置文件**

编辑 Cline 配置文件（通常位于 `~/.cline/config.json`）：

```json
{
  "apiKey": "YOUR_VALID_API_KEY",
  "endpoint": "https://api.cline.ai/v1",
  "model": "claude-3",
  "timeout": 30000
}
```

**方法 3: 检查环境变量**

确保环境变量正确设置：

```bash
# macOS/Linux
export CLINE_API_KEY="your-api-key-here"
export CLINE_ENDPOINT="https://api.cline.ai/v1"

# Windows
set CLINE_API_KEY=your-api-key-here
set CLINE_ENDPOINT=https://api.cline.ai/v1
```

**方法 4: 验证账户状态**

1. 登录 Cline 控制台
2. 检查账户余额/配额
3. 确认账户未欠费
4. 如欠费，充值后等待 5-10 分钟生效

---

## 🧠 智谱 AI（Zhipu）平台解决方案

### 问题 1: 429 限流错误

#### 症状
```
Error 429: 请求过于频繁
API rate limit exceeded
```

#### 解决方案

**方法 1: 实现指数退避重试**

```javascript
async function callWithRetry(apiFunction, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await apiFunction();
    } catch (error) {
      if (error.status === 429 && i < maxRetries - 1) {
        // 指数退避：1s, 2s, 4s
        const delay = Math.pow(2, i) * 1000;
        console.log(`请求限流，${delay}ms 后重试...`);
        await sleep(delay);
      } else {
        throw error;
      }
    }
  }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
```

**方法 2: 添加请求队列**

```javascript
class RequestQueue {
  constructor(concurrency = 1) {
    this.queue = [];
    this.concurrency = concurrency;
    this.running = 0;
  }

  async add(task) {
    return new Promise((resolve, reject) => {
      this.queue.push({ task, resolve, reject });
      this.next();
    });
  }

  async next() {
    if (this.running >= this.concurrency || this.queue.length === 0) {
      return;
    }

    const { task, resolve, reject } = this.queue.shift();
    this.running++;

    task()
      .then(resolve)
      .catch(reject)
      .finally(() => {
        this.running--;
        this.next();
      });
  }
}

// 使用示例
const queue = new RequestQueue(1); // 同时只运行 1 个请求

queue.add(() => callSkill1());
queue.add(() => callSkill2());
queue.add(() => callSkill3());
```

**方法 3: 升级智谱账户**

1. 访问智谱 AI 控制台：https://open.bigmodel.cn/
2. 进入账户充值页面
3. 选择适合的套餐
4. 充值后配额立即生效

**方法 4: 申请企业配额**

如个人配额不足：

1. 准备企业资质
2. 联系智谱商务：business@zhipuai.cn
3. 说明使用场景和需求量
4. 获取更高配额

---

### 问题 2: 1113 配置错误

#### 症状
```
Error 1113: 配置错误
无效的 API Key 或端点
```

#### 解决方案

**方法 1: 重新生成 API Key**

1. 登录智谱 AI 控制台：https://open.bigmodel.cn/
2. 进入「API 密钥管理」
3. 删除旧密钥
4. 创建新密钥
5. 立即复制保存（只显示一次）

**方法 2: 检查端点配置**

智谱 AI 的正确端点：

```javascript
const ZHIPU_CONFIG = {
  endpoint: 'https://open.bigmodel.cn/api/paas/v4',
  // 或旧版本
  // endpoint: 'https://open.bigmodel.cn/api/paas/v3',
  
  // Chat 模型
  chatModel: 'chatglm_turbo',
  
  // 绘画模型（如支持）
  // imageModel: 'cogview-3',
};
```

**方法 3: 验证认证格式**

智谱 AI 使用 JWT Token 认证：

```javascript
const jwt = require('jsonwebtoken');

function generateZhipuToken(apiKey, apiSecret) {
  const [apiKeyPart1, apiKeyPart2] = apiKey.split('.');
  
  const payload = {
    api_key: apiKey,
    exp: Math.floor(Date.now() / 1000) + 3600 * 1000, // 1000 小时
    timestamp: Date.now()
  };
  
  return jwt.sign(payload, apiSecret, {
    algorithm: 'HS256',
    header: {
      alg: 'HS256',
      sign_type: 'SIGN'
    }
  });
}

// 使用示例
const token = generateZhipuToken(API_KEY, API_SECRET);

// 在请求头中使用
headers: {
  'Authorization': `Bearer ${token}`
}
```

**方法 4: 检查账户状态**

```bash
# 使用 curl 测试 API Key 是否有效
curl -X GET "https://open.bigmodel.cn/api/paas/v4/models" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

如返回 401，说明 Token 无效；如返回 402，说明账户欠费。

---

## 🛠️ 通用解决方案

### 方案 1: 实现请求缓存

避免重复请求相同内容：

```javascript
class RequestCache {
  constructor(ttl = 3600000) { // 默认 1 小时
    this.cache = new Map();
    this.ttl = ttl;
  }

  get(key) {
    const item = this.cache.get(key);
    if (!item) return null;
    
    if (Date.now() > item.expiry) {
      this.cache.delete(key);
      return null;
    }
    
    return item.data;
  }

  set(key, data) {
    this.cache.set(key, {
      data,
      expiry: Date.now() + this.ttl
    });
  }
}

// 使用示例
const cache = new RequestCache();

async function getPosterPrompt(theme) {
  const cached = cache.get(theme);
  if (cached) return cached;
  
  const result = await callSkill(theme);
  cache.set(theme, result);
  return result;
}
```

### 方案 2: 使用备用 API

配置多个 API 源，自动切换：

```javascript
const API_PROVIDERS = [
  { name: 'primary', endpoint: 'https://api1.example.com', key: KEY1 },
  { name: 'backup', endpoint: 'https://api2.example.com', key: KEY2 }
];

async function callWithFallback(data, providerIndex = 0) {
  if (providerIndex >= API_PROVIDERS.length) {
    throw new Error('所有 API 提供商都不可用');
  }

  const provider = API_PROVIDERS[providerIndex];
  
  try {
    return await callAPI(provider, data);
  } catch (error) {
    if (error.status === 429 || error.status === 1113) {
      console.log(`${provider.name} 不可用，切换到备用提供商...`);
      return callWithFallback(data, providerIndex + 1);
    }
    throw error;
  }
}
```

### 方案 3: 监控和告警

添加请求监控：

```javascript
class RequestMonitor {
  constructor() {
    this.requests = [];
    this.errors = [];
  }

  recordRequest(duration, status) {
    this.requests.push({
      timestamp: Date.now(),
      duration,
      status
    });
    
    // 保留最近 1 小时的数据
    const oneHourAgo = Date.now() - 3600000;
    this.requests = this.requests.filter(r => r.timestamp > oneHourAgo);
  }

  recordError(error) {
    this.errors.push({
      timestamp: Date.now(),
      message: error.message,
      status: error.status
    });
    
    // 告警
    if (error.status === 429) {
      console.warn('⚠️  检测到限流错误，建议降低请求频率');
    } else if (error.status === 1113) {
      console.error('❌ 检测到配置错误，请检查 API Key');
    }
  }

  getStats() {
    const total = this.requests.length;
    const errors = this.requests.filter(r => r.status >= 400).length;
    const errorRate = total > 0 ? (errors / total * 100).toFixed(2) : 0;
    
    return {
      totalRequests: total,
      errorCount: errors,
      errorRate: `${errorRate}%`,
      recentErrors: this.errors.slice(-5)
    };
  }
}

// 使用示例
const monitor = new RequestMonitor();

async function monitoredCall() {
  const start = Date.now();
  
  try {
    const result = await callAPI();
    monitor.recordRequest(Date.now() - start, 200);
    return result;
  } catch (error) {
    monitor.recordRequest(Date.now() - start, error.status);
    monitor.recordError(error);
    throw error;
  }
}
```

---

## 📊 预防措施

### 1. 优化提示词长度

过长的提示词会消耗更多配额：

```javascript
// ❌ 冗长的提示词
const prompt = "我想要一个非常漂亮的海报，这个海报的主题是未来科技，要有赛博朋克的风格，颜色要鲜艳一点，最好有霓虹灯的效果...";

// ✅ 简洁的提示词
const prompt = "未来科技峰会海报，赛博朋克风格，霓虹蓝紫撞色，中心放射构图，8K 分辨率 --ar 2:3";
```

### 2. 使用技能批量生成

使用系列生成技能一次获取多个方案，而非多次调用：

```javascript
// ❌ 错误：多次调用
for (let i = 0; i < 5; i++) {
  await callSingleGenerator(theme);
}

// ✅ 正确：一次调用
await callSeriesGenerator(theme, { quantity: 5 });
```

### 3. 本地测试

在正式调用前，使用 mock 数据测试：

```javascript
const MOCK_RESPONSE = {
  prompt: "测试用提示词...",
  style: "测试风格"
};

async function testWithMock(useMock = true) {
  if (useMock) {
    return MOCK_RESPONSE;
  }
  return await callRealAPI();
}
```

---

## 📞 获取帮助

### Cline 支持

- 官网：https://cline.ai/
- 文档：https://docs.cline.ai/
- 邮箱：support@cline.ai
- Discord: https://discord.gg/cline

### 智谱 AI 支持

- 官网：https://open.bigmodel.cn/
- 文档：https://open.bigmodel.cn/dev/api
- 邮箱：support@zhipuai.cn
- 电话：400-xxx-xxxx（工作日 9:00-18:00）

### 社区支持

- GitHub Issues: https://github.com/scudong/poster-design-ai-skills/issues
- 微信群：扫码加入用户交流群
- QQ 群：xxxxxxx

---

## 🔗 相关资源

- [Cline API 文档](https://docs.cline.ai/)
- [智谱 AI 开发者文档](https://open.bigmodel.cn/dev/api)
- [HTTP 状态码详解](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status)
- [API 限流最佳实践](https://github.com/shwars/workshop-ai-prompts)

---

<div align="center">

**祝您使用顺利！如有问题请随时反馈 🚀**

</div>

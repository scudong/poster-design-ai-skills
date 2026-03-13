{
  "name": "poster-design-ai-skills",
  "version": "1.0.0",
  "description": "海报设计 AI 技能工具包 - Midjourney + NanoBanana 双平台专业策展系统",
  "author": "Poster Design AI Team",
  "license": "MIT",
  "repository": "https://github.com/scudong/poster-design-ai-skills",
  "homepage": "https://github.com/scudong/poster-design-ai-skills#readme",
  "bugs": {
    "url": "https://github.com/scudong/poster-design-ai-skills/issues"
  },
  "keywords": [
    "mcp",
    "claude",
    "poster",
    "midjourney",
    "nanobanana",
    "ai-art",
    "design",
    "curator",
    "prompt-engineering"
  ],
  "main": "server.js",
  "type": "module",
  "scripts": {
    "start": "node server.js",
    "dev": "node --watch server.js"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0"
  },
  "engines": {
    "node": ">=18.0.0"
  },
  "files": [
    "server.js",
    "skills/",
    "README.md",
    "LICENSE"
  ],
  "mcp": {
    "capabilities": {
      "skills": true,
      "prompts": true
    },
    "skills": [
      {
        "name": "midjourney-poster-generator",
        "file": "skills/midjourney-poster-generator.json"
      },
      {
        "name": "midjourney-style-matcher",
        "file": "skills/midjourney-style-matcher.json"
      },
      {
        "name": "midjourney-composition-optimizer",
        "file": "skills/midjourney-composition-optimizer.json"
      },
      {
        "name": "midjourney-series-generator",
        "file": "skills/midjourney-series-generator.json"
      },
      {
        "name": "nanobanana-poster-generator",
        "file": "skills/nanobanana-poster-generator.json"
      },
      {
        "name": "nanobanana-style-matcher",
        "file": "skills/nanobanana-style-matcher.json"
      },
      {
        "name": "nanobanana-composition-optimizer",
        "file": "skills/nanobanana-composition-optimizer.json"
      },
      {
        "name": "nanobanana-series-generator",
        "file": "skills/nanobanana-series-generator.json"
      }
    ]
  }
}

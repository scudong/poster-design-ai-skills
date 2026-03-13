#!/bin/bash

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 检查是否安装了 Homebrew
check_homebrew() {
    if command -v brew &> /dev/null; then
        print_success "Homebrew 已安装"
        return 0
    else
        print_warning "Homebrew 未安装"
        return 1
    fi
}

# 安装 Homebrew
install_homebrew() {
    print_info "正在安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew 安装完成"
}

# 检查 Node.js
check_nodejs() {
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v | cut -d'.' -f1 | sed 's/v//')
        if [ "$NODE_VERSION" -ge 18 ]; then
            print_success "Node.js 版本符合要求：$(node -v)"
            return 0
        else
            print_warning "Node.js 版本过低：$(node -v)，需要 >= 18.0.0"
            return 1
        fi
    else
        print_warning "Node.js 未安装"
        return 1
    fi
}

# 安装 Node.js
install_nodejs() {
    print_info "正在安装 Node.js 18..."
    brew install node@18
    print_success "Node.js 安装完成：$(node -v)"
}

# 升级 Node.js
upgrade_nodejs() {
    print_info "正在升级 Node.js..."
    brew upgrade node@18
    print_success "Node.js 升级完成：$(node -v)"
}

# 检查 Claude Desktop
check_claude() {
    if [ -d "/Applications/Claude.app" ]; then
        print_success "Claude Desktop 已安装"
        return 0
    else
        print_warning "Claude Desktop 未安装"
        return 1
    fi
}

# 安装 Claude Desktop
install_claude() {
    print_info "正在安装 Claude Desktop..."
    brew install --cask claude
    print_success "Claude Desktop 安装完成"
}

# 克隆项目
clone_project() {
    print_info "正在克隆项目..."
    if [ -d "$HOME/poster-skills" ]; then
        print_warning "~/poster-skills 已存在，正在更新..."
        cd ~/poster-skills
        git pull
    else
        git clone https://github.com/scudong/poster-design-ai-skills.git ~/poster-skills
    fi
    print_success "项目克隆完成"
}

# 配置 MCP 服务器
configure_mcp() {
    print_info "正在配置 MCP 服务器..."
    
    CONFIG_DIR="$HOME/Library/Application Support/Claude"
    CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"
    
    # 创建配置目录
    mkdir -p "$CONFIG_DIR"
    
    # 备份现有配置
    if [ -f "$CONFIG_FILE" ]; then
        cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
        print_info "已备份现有配置"
    fi
    
    # 创建新配置
    cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "poster-design-skills": {
      "command": "node",
      "args": ["$HOME/poster-skills/skills/index.js"],
      "cwd": "$HOME/poster-skills",
      "env": {}
    }
  }
}
EOF
    
    print_success "MCP 服务器配置完成"
}

# 主流程
main() {
    echo ""
    echo "======================================"
    echo "  海报设计 AI 技能工具包 - 完整安装"
    echo "======================================"
    echo ""
    
    # 步骤 1：检查/安装 Homebrew
    echo "步骤 1/6：检查 Homebrew..."
    if ! check_homebrew; then
        install_homebrew
    fi
    echo ""
    
    # 步骤 2：检查/安装 Node.js
    echo "步骤 2/6：检查 Node.js..."
    if ! check_nodejs; then
        if command -v node &> /dev/null; then
            upgrade_nodejs
        else
            install_nodejs
        fi
    fi
    echo ""
    
    # 步骤 3：检查/安装 Claude Desktop
    echo "步骤 3/6：检查 Claude Desktop..."
    if ! check_claude; then
        install_claude
    fi
    echo ""
    
    # 步骤 4：克隆项目
    echo "步骤 4/6：克隆项目..."
    clone_project
    echo ""
    
    # 步骤 5：配置 MCP
    echo "步骤 5/6：配置 MCP 服务器..."
    configure_mcp
    echo ""
    
    # 步骤 6：完成
    echo "步骤 6/6：完成！"
    echo ""
    print_success "所有组件安装完成！"
    echo ""
    echo "======================================"
    echo "  安装总结"
    echo "======================================"
    echo ""
    echo "✅ Homebrew: $(brew --version | head -n1)"
    echo "✅ Node.js: $(node -v)"
    echo "✅ npm: $(npm -v)"
    echo "✅ Claude Desktop: 已安装"
    echo "✅ 项目位置：~/poster-skills"
    echo ""
    echo "======================================"
    echo "  下一步操作"
    echo "======================================"
    echo ""
    echo "1. 完全退出 Claude Desktop（菜单栏 → Quit）"
    echo "2. 重新打开 Claude Desktop"
    echo "3. 输入测试命令：列出可用的海报设计技能"
    echo ""
    print_success "安装完成！"
    echo ""
}

# 运行主流程
main

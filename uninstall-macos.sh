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

# 安全地移除 MCP 配置（使用 Node.js 处理 JSON）
remove_mcp_config() {
    local config_file="$1"
    
    node -e "
const fs = require('fs');
const configPath = '$config_file';

try {
  // 读取配置
  const config = JSON.parse(fs.readFileSync(configPath, 'utf-8'));
  
  // 检查是否有 mcpServers
  if (!config.mcpServers) {
    console.log('NO_MCP_SERVERS');
    process.exit(0);
  }
  
  // 检查是否有 poster-skills
  if (!config.mcpServers['poster-skills']) {
    console.log('NO_POSTER_SKILLS');
    process.exit(0);
  }
  
  // 移除 poster-skills
  delete config.mcpServers['poster-skills'];
  
  // 如果 mcpServers 为空，也删除它
  if (Object.keys(config.mcpServers).length === 0) {
    delete config.mcpServers;
  }
  
  // 写回配置（保持格式）
  fs.writeFileSync(configPath, JSON.stringify(config, null, 2) + '\n', 'utf-8');
  
  console.log('REMOVED');
} catch (error) {
  console.error('ERROR:', error.message);
  process.exit(1);
}
"
}

# 主流程
main() {
    echo ""
    echo "======================================"
    echo "  海报设计 AI 技能工具包 - 完全卸载"
    echo "======================================"
    echo ""
    
    # 确认卸载
    print_warning "此操作将完全卸载海报设计 AI 技能工具包"
    echo ""
    read -p "是否继续？[y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "卸载已取消"
        exit 0
    fi
    
    echo ""
    
    # 步骤 1：找到 Claude Desktop 配置目录
    CONFIG_DIR="$HOME/Library/Application Support/Claude"
    CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"
    
    print_info "步骤 1/5：检查配置..."
    echo "📁 配置目录：$CONFIG_DIR"
    echo ""
    
    # 步骤 2：备份配置
    print_info "步骤 2/5：备份配置..."
    BACKUP_FILE=""
    if [ -f "$CONFIG_FILE" ]; then
        BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
        cp "$CONFIG_FILE" "$BACKUP_FILE"
        print_success "已备份配置：$BACKUP_FILE"
    else
        print_warning "配置文件不存在"
    fi
    echo ""
    
    # 步骤 3：安全移除 MCP 配置
    print_info "步骤 3/5：移除 MCP 配置..."
    if [ -f "$CONFIG_FILE" ]; then
        # 使用 Node.js 安全处理 JSON
        RESULT=$(remove_mcp_config "$CONFIG_FILE")
        
        case "$RESULT" in
            "REMOVED")
                print_success "已安全移除 poster-skills 配置"
                ;;
            "NO_POSTER_SKILLS")
                print_warning "配置文件中未找到 poster-skills"
                ;;
            "NO_MCP_SERVERS")
                print_warning "配置文件中没有 mcpServers 配置"
                ;;
            ERROR*)
                print_error "移除配置失败：$RESULT"
                print_warning "配置文件可能已损坏，建议从备份恢复"
                print_info "备份文件：$BACKUP_FILE"
                exit 1
                ;;
        esac
    else
        print_warning "配置文件不存在"
    fi
    echo ""
    
    # 步骤 4：删除项目文件
    print_info "步骤 4/5：删除项目文件..."
    if [ -d "$HOME/poster-skills" ]; then
        rm -rf "$HOME/poster-skills"
        print_success "已删除 ~/poster-skills"
    else
        print_warning "~/poster-skills 不存在"
    fi
    
    # 也检查 Documents 目录
    if [ -d "$HOME/Documents/trae_projects/poster-skills" ]; then
        rm -rf "$HOME/Documents/trae_projects/poster-skills"
        print_success "已删除 ~/Documents/trae_projects/poster-skills"
    fi
    echo ""
    
    # 步骤 5：清理缓存
    print_info "步骤 5/5：清理缓存..."
    CACHE_DIR="$HOME/Library/Caches/Claude"
    if [ -d "$CACHE_DIR" ]; then
        # 只删除与技能相关的缓存
        find "$CACHE_DIR" -name "*poster*" -type f -delete 2>/dev/null || true
        find "$CACHE_DIR" -name "*mcp*" -type f -delete 2>/dev/null || true
        find "$CACHE_DIR" -name "*poster*" -type d -delete 2>/dev/null || true
        find "$CACHE_DIR" -name "*mcp*" -type d -delete 2>/dev/null || true
        print_success "已清理缓存"
    else
        print_warning "缓存目录不存在"
    fi
    echo ""
    
    # 完成
    echo "======================================"
    print_success "卸载完成！"
    echo "======================================"
    echo ""
    print_info "请重启 Claude Desktop 以应用更改"
    echo ""
    
    # 显示备份文件位置
    if [ -n "$BACKUP_FILE" ] && [ -f "$BACKUP_FILE" ]; then
        echo "======================================"
        print_info "配置备份已保存"
        echo "======================================"
        echo "$BACKUP_FILE"
        echo ""
        print_info "如需恢复配置，执行："
        echo "cp \"$BACKUP_FILE\" \"$CONFIG_FILE\""
        echo ""
    fi
    
    # 提示
    echo "======================================"
    echo "  可选：完全清理（删除所有痕迹）"
    echo "======================================"
    echo ""
    print_warning "以下操作将删除 Claude Desktop 的所有缓存和日志"
    echo ""
    read -p "是否执行完全清理？[y/N] " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        
        # 清理所有缓存
        if [ -d "$CACHE_DIR" ]; then
            rm -rf "$CACHE_DIR"/*
            print_success "已清理所有缓存"
        fi
        
        # 清理日志
        LOG_DIR="$HOME/Library/Logs/Claude"
        if [ -d "$LOG_DIR" ]; then
            rm -rf "$LOG_DIR"/*
            print_success "已清理所有日志"
        fi
        
        echo ""
        print_success "完全清理完成！"
    fi
    
    echo ""
    echo "======================================"
    print_success "再见！👋"
    echo "======================================"
    echo ""
}

# 运行主流程
main

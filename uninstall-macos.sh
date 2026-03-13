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
    if [ -f "$CONFIG_FILE" ]; then
        BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d%H%M%S)"
        cp "$CONFIG_FILE" "$BACKUP_FILE"
        print_success "已备份配置：$BACKUP_FILE"
    else
        print_warning "配置文件不存在"
    fi
    echo ""
    
    # 步骤 3：移除 MCP 配置
    print_info "步骤 3/5：移除 MCP 配置..."
    if [ -f "$CONFIG_FILE" ]; then
        # 检查是否包含 poster-design-skills
        if grep -q "poster-design-skills" "$CONFIG_FILE"; then
            # 创建临时文件
            TEMP_FILE="$CONFIG_FILE.tmp"
            
            # 使用 grep 移除相关行（简单处理）
            # 注意：这是简化处理，复杂 JSON 建议使用 jq
            cat "$CONFIG_FILE" | grep -v "poster-design-skills" | grep -v '"command": "node"' | grep -v '"args":' | grep -v '"cwd":' | grep -v '"env":' > "$TEMP_FILE" || true
            
            # 清理空的大括号
            cat "$TEMP_FILE" | sed '/^[[:space:]]*$/d' > "$CONFIG_FILE"
            rm -f "$TEMP_FILE"
            
            print_success "已移除 poster-design-skills 配置"
        else
            print_warning "配置文件中未找到 poster-design-skills"
        fi
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
    echo ""
    
    # 步骤 5：清理缓存
    print_info "步骤 5/5：清理缓存..."
    CACHE_DIR="$HOME/Library/Caches/Claude"
    if [ -d "$CACHE_DIR" ]; then
        # 只删除与技能相关的缓存
        find "$CACHE_DIR" -name "*poster*" -type f -delete 2>/dev/null || true
        find "$CACHE_DIR" -name "*mcp*" -type f -delete 2>/dev/null || true
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
    if [ -f "$BACKUP_FILE" ]; then
        print_info "配置备份已保存：$BACKUP_FILE"
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
            rm -rf "$LOG_DIR"/claude*.log
            print_success "已清理日志"
        fi
        
        echo ""
        print_success "完全清理完成！"
    fi
    echo ""
}

# 运行主流程
main

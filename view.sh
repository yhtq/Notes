#!/usr/bin/env bash
# 输入相对路径，生成 sftp 链接
# 使用 eth1 中的 ipv6 地址

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "用法: $0 <相对路径>"
    exit 1
fi

# 获取 eth1 上第一个 global unicast IPv6 地址（排除 link-local fe80::）
IPV6=$(ip -6 addr show eth1 scope global | grep -oP '(?<=inet6 )[\da-f:]+(?=/)' | grep -v '^fe80' | head -1)

if [ -z "$IPV6" ]; then
    echo "错误: 未在 eth1 上找到 global IPv6 地址"
    exit 1
fi

# 将相对路径解析为绝对路径
ABS_PATH=$(realpath -m "$1")

# 生成 sftp 链接，IPv6 地址需要用方括号括起来
SFTP_LINK="sftp://[$IPV6]${ABS_PATH}"

echo "$SFTP_LINK"

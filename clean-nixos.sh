#!/bin/bash

# 确保脚本以 root 用户运行
if [ "$(id -u)" -ne 0 ]; then
    echo "此脚本必须以 root 用户运行" >&2
    exit 1
fi

# 获取所有系统生成的列表，并提取生成号
generations=$(nix-env -p /nix/var/nix/profiles/system --list-generations | awk '{print $1}' | sed 's/generation //' | sort -n)

# 将生成号转换为数组
mapfile -t gen_array <<< "$generations"

# 获取总生成数
total=${#gen_array[@]}

if [ $total -gt 2 ]; then
    # 获取倒数第二个生成号（即第二个最新的生成）
    second_last=${gen_array[-2]}
    
    # 删除所有比倒数第二个生成号更旧的生成
    for gen in "${gen_array[@]}"; do
        if [ $gen -lt $second_last ]; then
            nix-env -p /nix/var/nix/profiles/system --delete-generations $gen
        fi
    done
    echo "已删除生成号小于 $second_last 的所有生成"
else
    echo "系统中只有两个或更少的生成，无需删除"
fi

#!/usr/bin/env bash

# 保留最近 2 个 system generations，其余删除
echo "Deleting old system generations..."
sudo nix-env --delete-generations +2 --profile /nix/var/nix/profiles/system

# 垃圾回收，删除不再使用的 Nix store 对象
echo "Running garbage collection..."
sudo nix-collect-garbage -d

echo "Cleanup complete. Only the latest 2 system snapshots are retained."


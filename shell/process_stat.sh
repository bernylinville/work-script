#!/bin/bash
# 统计 Linux 进程相关数量信息

procs=0
running=0
sleeping=0
stoped=0
zombie=0

for pid in /proc/[1-9]*; do
  procs=$((procs+1))
  stat=$(awk '{print $3}' "${pid}/stat")
  case "${stat}" in
    R)
      running=$((running+1))
      ;;
    S)
      sleeping=$((sleeping+1))
      ;;
    T)
      stoped=$((stoped+1))
      ;;
    Z)
      zombie=$((zombie+1))
      ;;
  esac
done
echo "进程统计信息如下"
echo "总进程数为：${procs}"
echo "Running 进程数为：${running}"
echo "Sleeping 进程数为：${sleeping}"
echo "Stoped 进程数为：${stoped}"
echo "Zombie 进程数为：${zombie}"
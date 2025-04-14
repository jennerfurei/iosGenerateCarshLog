#!/bin/bash

# 设置输入文件夹
input_folder="./ips"
# 设置输出文件夹
output_folder="./crash"
# 设置符号化文件夹
dsym_folder="./dsym"
# 设置日志文件夹
log_folder="./log"

# 创建输出文件夹和日志文件夹（如果不存在）
mkdir -p $output_folder
mkdir -p $log_folder

# 查找第一个 .ips 文件
input_file=$(find $input_folder -type f -name "*.ips" | head -n 1)

# 检查是否找到 .ips 文件
if [ -z "$input_file" ]; then
    echo "无ips文件"
    exit 1
fi

# 设置完整的输出文件路径
output_path="$output_folder/ll.crash"

# 执行 Swift 命令
swift convertFromJSON.swift -i $input_file -o $output_path

# 检查 Swift 命令是否成功
if [ $? -ne 0 ]; then
    echo "Swift 命令执行失败"
    exit 1
fi

# 查找第一个 .dsym 文件
#dsym_file=$(find $dsym_folder -type f -name "*.app.dSYM" | head -n 1)
dsym_file=$(find $dsym_folder -type f | head -n 1)

# 检查是否找到 .dsym 文件
if [ -z "$dsym_file" ]; then
    echo "无 dsym 文件"
    exit 1
fi

# 设置日志文件路径
log_file="$log_folder/crash.log"

# 执行 symbolicatecrash 命令
./symbolicatecrash $output_path $dsym_file > $log_file 2>&1

# 检查是否报错 "DEVELOPER_DIR" 未定义
if grep -q 'Error: "DEVELOPER_DIR" is not defined' $log_file; then
    export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
    ./symbolicatecrash $output_path $dsym_file > $log_file 2>&1
fi

# 删除 crash 文件和 dsym 文件
# rm $output_path


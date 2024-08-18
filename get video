#!/bin/bash

# 检查you-get是否已安装
function check_youget() {
    if ! command -v you-get &> /dev/null; then
        echo "you-get 未安装，需要安装。"
        install_youget
    else
        echo "you-get 已安装。"
    fi
}

# 检查ffmpeg是否已安装
function check_ffmpeg() {
    if ! command -v ffmpeg &> /dev/null; then
        echo "ffmpeg 未安装，需要安装。"
        install_ffmpeg
    else
        echo "ffmpeg 已安装。"
    fi
}

# 安装you-get
function install_youget() {
    echo "正在安装you-get..."
    pip install you-get -i https://pypi.tuna.tsinghua.edu.cn/simple || { echo "you-get 安装失败"; exit 1; }
    echo "you-get 安装完成"
}

# 安装ffmpeg
function install_ffmpeg() {
    echo "正在安装ffmpeg..."
    # 根据你的系统使用合适的包管理器命令，这里以 apt 为例
    sudo apt-get update && sudo apt-get install -y ffmpeg || { echo "ffmpeg 安装失败"; exit 1; }
    echo "ffmpeg 安装完成"
}

# 下载视频
function download_video() {
    local video_url=$1
    if [ -z "$video_url" ]; then
        echo "错误：没有提供视频链接。"
        exit 1
    fi

    echo "开始下载视频：$video_url"
    you-get -o . "$video_url"
    if [ $? -ne 0 ]; then
        echo "视频下载失败。"
        exit 1
    fi

 # 询问用户是否合并视频文件
read -p "检测到多个视频片段，是否合并为单个视频文件？(y/n): " merge_choice
if [[ "$merge_choice" == "y" ]]; then
    echo "用户选择合并视频文件。"
    # 假设视频片段以数字命名，例如 video001.flv, video002.flv 等
    ffmpeg -i "video%03d.flv" -c copy merged_video.mp4
    if [ $? -eq 0 ]; then
        echo "视频合并成功，合并文件为 merged_video.mp4。"
    else
        echo "视频合并失败。"
    fi
else
    echo "用户选择不合并视频文件，片段将保持独立。"
fi

    local delete_choice
    read -p "是否删除弹幕文件（*.xml）？(y/n): " delete_choice
    if [[ "$delete_choice" == "y" ]]; then
        echo "删除弹幕文件..."
        rm -f *.xml
    fi
}

# 免责声明
echo "欢迎使用视频下载脚本"
echo "请确保您遵守所有适用的版权法律和条款"
read -p "点击回车键继续..." 

# 主程序
check_youget
check_ffmpeg
read -p "请输入视频链接: " video_url
download_video "$video_url"

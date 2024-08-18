#!/bin/bash

# 检查参数数量
if [ "$#" -ne 2 ]; then
    echo "用法: $0 <视频文件完整路径> <输出目录>"
    echo "例如：$0 /path/to/video.mp4 /path/to/output"
    exit 1
fi

# 读取用户输入的视频文件路径和输出目录
VIDEO_PATH="$1"
OUTPUT_DIR="$2"

# 检查输出目录是否存在，如果不存在则创建
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "输出目录不存在：$OUTPUT_DIR"
    read -p "是否需要创建此目录？(y/n): " confirm
    if [[ $confirm == [Yy] ]]; then
        mkdir -p "$OUTPUT_DIR"
        if [ $? -eq 0 ]; then
            echo "目录已创建：$OUTPUT_DIR"
        else
            echo "目录创建失败，请检查权限或路径是否正确。"
            exit 1
        fi
    else
        echo "操作已取消。"
        exit 1
    fi
fi

# 检查视频文件是否存在
if [ ! -f "$VIDEO_PATH" ]; then
    echo "错误：视频文件不存在，请检查路径是否正确。"
    exit 1
fi

# 从视频文件路径中提取文件名和扩展名
VIDEO_NAME=$(basename -- "$VIDEO_PATH")
BASENAME="${VIDEO_NAME%.*}"

# 定义音频输出文件的完整路径（.mp3格式）
AUDIOFILE="${OUTPUT_DIR}/${BASENAME}.mp3"

# 使用ffmpeg分离音频并保存为mp3格式
echo "正在分离音频..."
ffmpeg -i "$VIDEO_PATH" -vn -acodec libmp3lame -ab 320k "$AUDIOFILE" && echo "音频已提取到 $AUDIOFILE"

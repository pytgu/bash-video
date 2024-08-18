#!/bin/bash
echo "仅供测试尽量用 https://lrc.moyutime.cn/ 此网站"
# 音频文件的路径
MUSIC_FILE="/storage/emulated/0/速删/files/output.mp3"

# 确保音频文件存在
if [ ! -f "$MUSIC_FILE" ]; then
    echo "音乐文件不存在，请检查路径。"
    exit 1
fi

# 检查id3lib是否已安装
if command -v id3 &> /dev/null; then
    echo "id3lib 已安装。"
else
    echo "id3lib 未安装，正在尝试安装..."
    pkg install id3lib -y
    if [ $? -ne 0 ]; then
        echo "id3lib 安装失败，请检查您的网络连接或包源。"
        exit 1
    fi
fi

# 使用id3lib提取LRC歌词
echo "正在尝试提取LRC歌词..."
id3 --extract-lyrics "$MUSIC_FILE"

# 检查LRC文件是否提取成功
LRC_FILE="$(dirname "$MUSIC_FILE")/lyrics.lrc"
if [ -f "$LRC_FILE" ]; then
    echo "LRC歌词文件提取成功，位于：$LRC_FILE"
else
    echo "未在音频文件中找到LRC歌词或提取失败。"
fi

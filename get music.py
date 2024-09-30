#!/usr/bin/env python3
import os
import subprocess
import sys

# 免责声明
disclaimer = """
注意：本脚本仅供学习和研究使用，请确保您下载的音乐遵守相关版权法规。
使用本脚本下载音乐时，您应确保拥有相应的版权或已获得授权。
"""

# 显示免责声明
print(disclaimer)

# 等待用户同意
user_agreement = input("如果您同意上述条款，请输入'同意'并按回车键继续：")
if user_agreement != '同意':
    print("您未同意免责声明，脚本将退出。")
    sys.exit(1)

# 自动安装必要的软件包
def install_packages():
    packages = ['wget', 'sox', 'mpg123', 'ffmpeg']
    for package in packages:
        subprocess.run(['pkg', 'install', package], check=True)

# 下载音乐文件
def download_music(url):
    try:
        print(f"正在从 {url} 下载音乐...")
        subprocess.run(['wget', '-O', 'music.mp3', url], check=True)
        print("音乐下载完成。")
    except subprocess.CalledProcessError:
        print("音乐下载失败。")
        sys.exit(1)

# 主函数
def main():
    # 安装软件包
    install_packages()
    
    # 获取用户输入的音乐链接
    music_url = input("请输入音乐文件的下载链接：")
    
    # 下载音乐
    download_music(music_url)
    
    # 播放音乐（需要sox或mpg123）
    print("正在播放音乐...")
    subprocess.run(['pla
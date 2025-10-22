# 使用 Debian 版 n8n，支援 apt-get
FROM n8nio/n8n:latest-debian

# 以 root 權限修正套件源並安裝 ffmpeg
USER root
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list \
    && sed -i 's|security.debian.org|archive.debian.org/debian-security|g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 切換回 n8n 預設用戶
USER node
WORKDIR /data

# 開放 5678 埠給 Zeabur 偵測
EXPOSE 5678

# 啟動 n8n
CMD ["n8n", "start"]

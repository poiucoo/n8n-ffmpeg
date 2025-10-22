# 使用 Debian 版映像，支援 apt-get
FROM n8nio/n8n:latest-debian

# 以 root 權限安裝 ffmpeg
USER root
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 切換回 n8n 預設用戶
USER node
WORKDIR /data

# 開放 5678 埠給 Zeabur 偵測
EXPOSE 5678

# 啟動 n8n
CMD ["n8n", "start"]

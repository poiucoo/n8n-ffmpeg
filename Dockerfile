# ✅ 使用最新版 n8n（基於 Debian 12 Bookworm + Node 20）
FROM n8nio/n8n:latest

# 以 root 權限安裝 ffmpeg
USER root
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 切換回 n8n 預設使用者
USER node
WORKDIR /data

# 開放給 Zeabur 偵測的埠
EXPOSE 5678

# 啟動 n8n
CMD ["n8n", "start"]

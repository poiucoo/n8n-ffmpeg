# ✅ 最新 n8n + Debian 環境，支援 apt-get
FROM n8nio/n8n:latest-debian

# 以 root 權限安裝系統工具與 Python
USER root
RUN apt-get update && apt-get install -y \
    ffmpeg \
    wget \
    curl \
    git \
    unzip \
    python3 \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

# ✅ 安裝常用 AI SDK
RUN pip3 install --no-cache-dir \
    google-generativeai \
    openai \
    langchain \
    requests \
    elevenlabs \
    apify-client \
    d-id \
    pydub

# ✅ 設定工作目錄
USER node
WORKDIR /data

# ✅ Zeabur 監聽埠
EXPOSE 5678

# ✅ 啟動 n8n
CMD ["n8n", "start"]

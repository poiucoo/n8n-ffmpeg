# ✅ 改用 Debian 12 (Bookworm) 版 n8n，apt-get 可正常使用
FROM n8nio/n8n:1.120.1-debian

# 使用 root 權限安裝必要工具與 AI SDK
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

# ✅ 設定工作目錄與權限
USER node
WORKDIR /data
EXPOSE 5678

# ✅ 啟動 n8n
CMD ["n8n", "start"]

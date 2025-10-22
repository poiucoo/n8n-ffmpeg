# 🐧 基於 Debian Bookworm（含 Python 3.11）
FROM python:3.11-slim-bookworm

# ⚙️ 基本設定
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV NODE_VERSION=20

# ✅ 安裝 Node.js + ffmpeg + 其他工具
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ffmpeg \
    wget \
    unzip \
    build-essential \
 && curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/*

# ✅ 安裝 n8n（最新穩定版）
RUN npm install -g n8n

# ✅ 安裝常用 AI SDK
RUN pip install --no-cache-dir \
    google-generativeai \
    openai \
    langchain \
    requests \
    elevenlabs \
    apify-client \
    pydub

# ✅ 顯示版本確認
RUN echo "---- Environment Versions ----" && \
    node -v && \
    npm -v && \
    n8n --version && \
    python3 --version && \
    ffmpeg -version | head -n 1 && \
    echo "--------------------------------"

# ✅ 工作目錄與埠
WORKDIR /data
EXPOSE 5678

# ✅ 啟動 n8n
CMD ["n8n", "start"]

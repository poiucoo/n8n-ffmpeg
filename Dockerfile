# ✅ 使用 n8n 最新穩定版 + Debian 基底
FROM n8nio/n8n:latest-debian

# 切換為 root 權限以安裝工具
USER root

# ✅ 安裝系統依賴
RUN apt-get update && apt-get install -y \
    ffmpeg \
    wget \
    curl \
    git \
    unzip \
    python3 \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

# ✅ 安裝常用 AI 套件
RUN pip3 install --no-cache-dir \
    google-generativeai \
    openai \
    langchain \
    requests \
    elevenlabs \
    apify-client \
    d-id \
    pydub

# ✅ 顯示版本確認（在部署時輸出環境資訊）
RUN echo "---- Environment Versions ----" && \
    n8n --version && \
    python3 --version && \
    ffmpeg -version | head -n 1 && \
    echo "--------------------------------"

# ✅ 切回 n8n 預設用戶
USER node
WORKDIR /data

# ✅ 開放 n8n 預設埠
EXPOSE 5678

# ✅ 啟動 n8n
CMD ["n8n", "start"]

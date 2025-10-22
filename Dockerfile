# ✅ 使用官方最新穩定版 n8n
FROM n8nio/n8n:1.120.1

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

# ✅ 確認版本輸出（方便你在 Zeabur Logs 中看到）
RUN echo "---- Environment Versions ----" && \
    n8n --version && \
    python3 --version && \
    ffmpeg -version | head -n 1 && \
    echo "--------------------------------"

USER node
WORKDIR /data
EXPOSE 5678
CMD ["n8n", "start"]

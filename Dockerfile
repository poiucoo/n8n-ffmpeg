# ✅ 使用 Ubuntu base（apt-get、Python 都能用）
FROM n8nio/n8n:1.120.1-ubuntu

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

USER node
WORKDIR /data
EXPOSE 5678
CMD ["n8n", "start"]

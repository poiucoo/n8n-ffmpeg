# ✅ 使用 Debian 版 n8n（支援 apt-get）
FROM n8nio/n8n:latest-debian

USER root
RUN apt-get update && apt-get install -y \
    ffmpeg \
    wget \
    curl \
    unzip \
    git \
 && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /data
EXPOSE 5678
CMD ["n8n", "start"]

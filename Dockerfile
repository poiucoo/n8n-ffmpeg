# 基於 Debian Bookworm（含 Python 3.11）
FROM python:3.11-slim-bookworm

# ⚙️ 基本設定
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV NODE_VERSION=20

# ============================================
# 安裝 OS 依賴 + zip + ffmpeg + Node.js
# ============================================
RUN apt-get update && apt-get install -y \
    # ---- 基本工具 ----
    curl \
    wget \
    git \
    zip \
    unzip \
    build-essential \
    ca-certificates \
    openssl \
    # ---- ffmpeg ----
    ffmpeg \
    # ---- Playwright 依賴 ----
    libnss3 \
    libgbm1 \
    libxss1 \
    libasound2 \
    libxtst6 \
    libxrandr2 \
    libu2f-udev \
    libappindicator3-1 \
    fonts-liberation \
    libatk-bridge2.0-0 \
 && curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/*

# ============================================
# 安裝 n8n（最新穩定版）
# ============================================
RUN npm install -g n8n

# ============================================
# 安裝 Playwright（正確流程：先清 cache → 安裝）
# ============================================
RUN npm cache clean --force \
 && npm install playwright \
 && npx playwright install-deps \
 && npx playwright install chromium

# ============================================
# 安裝常用 AI SDK（Python）
# ============================================
RUN pip install --no-cache-dir \
    google-generativeai \
    openai \
    langchain \
    requests \
    elevenlabs \
    apify-client \
    pydub

# ============================================
# 顯示版本確認
# ============================================
RUN echo "---- Environment Versions ----" && \
    node -v && \
    npm -v && \
    n8n --version && \
    python3 --version && \
    ffmpeg -version | head -n 1 && \
    echo "--------------------------------"

# ============================================
# 建立 n8n 預設資料夾
# ============================================
RUN mkdir -p /home/n8n/.n8n

# 宣告 Volume
VOLUME ["/home/n8n/.n8n"]

# 設定工作目錄
WORKDIR /home/n8n

# 開放 port
EXPOSE 5678

# 啟動 n8n
CMD ["n8n", "start"]

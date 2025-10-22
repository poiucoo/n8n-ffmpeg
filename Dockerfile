FROM n8nio/n8n:latest

USER root
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /data
EXPOSE 5678
CMD ["n8n", "start"]

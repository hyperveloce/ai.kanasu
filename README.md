
### OVERVIEW

This repo leverages Docker Compose to quickly deploy Ollama's AI-powered model-building environment with preloaded models, simplifying the setup and management of multi-container applications.

### HARDWARE
- RTX 3080 Ti,
- Ryzen 5600,
- 16GB RAM,
- 2TB storage

### MODELS

#### 1. Llama 3 8B

This is a great all-around model with strong performance that will run smoothly on your hardware.

```
ollama run llama3:8b
```

**Why it's a good fit:**

- Balances performance and resource usage
- 8B parameter size fits comfortably within your 12GB VRAM
- Excellent for general-purpose tasks like chatting, writing, and basic coding
- Will run at good speeds on your 3080 Ti


```cardlink
url: https://ollama.com/library/llama3:8b
title: "llama3:8b"
description: "Meta Llama 3: The most capable openly available LLM to date"
host: ollama.com
favicon: https://ollama.com/public/icon-16x16.png
image: https://ollama.com/public/og.png
```
[llama3:8b](https://ollama.com/library/llama3:8b)

#### 2. Mistral 7B Instruct

This is an excellent instruction-following model that performs remarkably well for its size.

```
ollama run mistral:7b-instruct
```

**Why it's a good fit:**

- Efficient 7B parameter size uses less VRAM
- Very good at following instructions and handling specific tasks
- Will run with fast response times on your hardware
- Great for more structured interactions


```cardlink
url: https://ollama.com/library/mistral:7b-instruct-v0.2-q5_K_M
title: "mistral:7b-instruct-v0.2-q5_K_M"
description: "The 7B model released by Mistral AI, updated to version 0.3."
host: ollama.com
favicon: https://ollama.com/public/icon-16x16.png
image: https://ollama.com/public/og.png
```
[mistral:7b-instruct-v0.2-q5_K_M](https://ollama.com/library/mistral:7b-instruct-v0.2-q5_K_M)

### setup docker

```bash
docker-compose up -d

```

```yml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
	command: >
      bash -c "
        # Pull the first model if it's not already present
        if [ ! -f /models/$MODEL_1 ]; then
          ollama pull $MODEL_1;
        fi;
        # Pull the second model if it's not already present
        if [ ! -f /models/$MODEL_2 ]; then
          ollama pull $MODEL_2;
        fi;
        # Start Ollama
        ollama start"
    ports:
      - "11434:11434"
    environment:
      - MODEL_NAME=llama3:8b
      - MODEL_NAME=7b-instruct-v0.2-q5_K_M
    volumes:
      - /mnt/debian.data/ollama_data:/root/.ollama
      - /mnt/debian.data/ollama_models:/models
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 0
              capabilities: [gpu]
    networks:
      - app_network

volumes:
  ollama_data:
	name: ollama_data

networks:
  app_network:
    driver: bridge
```

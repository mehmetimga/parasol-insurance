# Parasol Insurance - Complete Setup Guide

## 🚀 Quick Start with Docker

This guide will help you run the complete Parasol Insurance application with AI capabilities using Docker.

### Prerequisites
- Docker and Docker Compose installed
- At least 4GB of free disk space for AI model
- 8GB RAM recommended

### 🏃‍♂️ One-Command Setup

```bash
./scripts/setup.sh
```

This script will:
1. Build the React frontend
2. Build the Node.js backend 
3. Start Ollama AI service
4. Download the Llama 3.1 AI model (~4GB)
5. Start the application with pre-seeded data

### 🔧 Manual Setup

If you prefer manual setup:

```bash
# Build and start all services
docker-compose up -d --build

# Check service status
docker-compose ps

# View logs
docker-compose logs -f parasol-app
docker-compose logs -f ollama
```

### 🌐 Access the Application

- **Application**: http://localhost:8080
- **Ollama API**: http://localhost:11434

### 📊 Features

✅ **Pre-seeded Data**: 6 sample insurance claims  
✅ **AI Chatbot**: Ask questions about claims using Llama 3.1  
✅ **Real-time Chat**: WebSocket-based communication  
✅ **Responsive UI**: PatternFly React components  

### 🧪 Testing the Application

1. Open http://localhost:8080 in your browser
2. Click on any insurance claim from the list
3. Click the chat icon to open the AI chatbot
4. Ask questions like:
   - "What happened in this claim?"
   - "What was the damage?"
   - "Who was at fault?"
   - "What is the sentiment of this claim?"

### 🛠️ Development

For local development without Docker:

```bash
# Start AI service
docker-compose up ollama -d

# Install backend dependencies
cd app
npm install

# Build frontend
npm run buildui

# Start backend
npm start
```

### 🔧 Configuration

Environment variables (in `app/.env`):
- `AI_CHAT_MODEL_NAME=llama3.1`
- `AI_CHAT_BASE_URL=http://localhost:11434/v1`
- `AI_CHAT_MODEL_TEMPERATURE=0.3`
- `PORT=8080`

### 🛑 Stopping the Application

```bash
docker-compose down
```

To remove all data:
```bash
docker-compose down -v
```

### 📝 Sample Claims Data

The application includes 6 pre-seeded insurance claims:
- Marty McFly's DeLorean accident
- John T. Anderson's urgent complaint
- Jane Doe's anxious first claim
- Dominic Toretto's high-speed incident  
- Saul Goodman's frustrated follow-up
- Tyrion Lannister's King's Landing collision

Each claim has different statuses (New, In Process, Processed, Denied) and sentiment analysis.

### 🔍 Troubleshooting

**Application not starting?**
- Check Docker is running: `docker info`
- Check ports aren't in use: `netstat -an | grep 8080`

**AI not responding?**
- Check Ollama is running: `docker logs parasol-ollama`
- Verify model is downloaded: `docker exec parasol-ollama ollama list`

**Build failures?**
- Clean Docker cache: `docker system prune -a`
- Rebuild: `docker-compose up --build --force-recreate`
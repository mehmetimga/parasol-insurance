#!/bin/bash
set -e

echo "🚀 Setting up Parasol Insurance Application..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build and start the services
echo "📦 Building and starting services..."
docker-compose up -d --build

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
until docker-compose exec -T parasol-app curl -f http://localhost:8080/ >/dev/null 2>&1; do
    echo "   Still waiting for application to be ready..."
    sleep 10
done

echo "✅ Application is now running!"
echo ""
echo "🌐 Application URL: http://localhost:8080"
echo "🤖 Ollama API: http://localhost:11434"
echo ""
echo "📊 To check service status:"
echo "   docker-compose ps"
echo ""
echo "📝 To view logs:"
echo "   docker-compose logs -f parasol-app"
echo "   docker-compose logs -f ollama"
echo ""
echo "🛑 To stop services:"
echo "   docker-compose down"
echo ""
echo "💾 The application includes pre-seeded insurance claims data."
echo "🎯 Navigate to the application and click on any claim to test the AI chatbot!"
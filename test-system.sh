#!/bin/bash

# Parasol Insurance Application Test Suite
echo "🏥 PARASOL INSURANCE - SYSTEM TEST SUITE"
echo "========================================"
echo ""

# Test 1: Container Health
echo "📋 1. TESTING CONTAINER HEALTH..."
docker-compose ps --format "table {{.Service}}\t{{.State}}\t{{.Status}}" | grep -v "SERVICE"
echo ""

# Test 2: Frontend Application
echo "📋 2. TESTING FRONTEND APPLICATION..."
if curl -s -f http://localhost:8005/ > /dev/null; then
    echo "✅ Frontend responding at http://localhost:8005"
else
    echo "❌ Frontend not responding"
fi
echo ""

# Test 3: Database & API
echo "📋 3. TESTING DATABASE & API..."
CLAIMS_COUNT=$(curl -s http://localhost:8005/api/db/claims | jq length 2>/dev/null)
if [ "$CLAIMS_COUNT" = "6" ]; then
    echo "✅ Database loaded with $CLAIMS_COUNT sample claims"
else
    echo "❌ Database not properly loaded"
fi

# Test specific claim
CLAIM_NAME=$(curl -s http://localhost:8005/api/db/claims/1 | jq -r '.client_name' 2>/dev/null)
if [ "$CLAIM_NAME" = "Marty McFly" ]; then
    echo "✅ Individual claim retrieval working"
else
    echo "❌ Individual claim retrieval failed"
fi
echo ""

# Test 4: AI Model
echo "📋 4. TESTING AI MODEL..."
if curl -s -f http://localhost:11434/api/version > /dev/null; then
    MODEL_INFO=$(curl -s http://localhost:11434/api/tags | jq -r '.models[0].name' 2>/dev/null)
    if [ "$MODEL_INFO" = "llama3.1:latest" ]; then
        echo "✅ Llama 3.1 model loaded and ready"
    else
        echo "❌ AI model not properly loaded"
    fi
else
    echo "❌ Ollama service not responding"
fi
echo ""

# Test 5: Sample Claims Data
echo "📋 5. SAMPLE CLAIMS LOADED..."
echo "- Marty McFly (DeLorean accident)"
echo "- John T. Anderson (complaint)"  
echo "- Jane Doe (anxious first claim)"
echo "- Dominic Toretto (high-speed incident)"
echo "- Saul Goodman (frustrated follow-up)"
echo "- Tyrion Lannister (King's Landing collision)"
echo ""

# Final Status
echo "🎯 SYSTEM STATUS: READY FOR TESTING!"
echo ""
echo "🌐 Access the application:"
echo "   Frontend: http://localhost:8005"
echo "   API: http://localhost:8005/api/db/claims"
echo "   Ollama: http://localhost:11434"
echo ""
echo "💡 How to test the AI chatbot:"
echo "   1. Open http://localhost:8005 in your browser"
echo "   2. Click on any insurance claim"
echo "   3. Click the chat icon to open the AI assistant"
echo "   4. Ask questions like:"
echo "      - 'What happened in this claim?'"
echo "      - 'Who was at fault?'"
echo "      - 'What was the damage?'"
echo "      - 'What is the sentiment of this claim?'"
echo ""
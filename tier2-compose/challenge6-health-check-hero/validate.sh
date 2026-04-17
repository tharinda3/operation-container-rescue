#!/bin/bash
echo "🔍 Validating Challenge 6: Health Check Hero"
echo ""

echo "📊 Checking stack status..."
docker compose down >/dev/null 2>&1
sleep 2

echo "🚀 Starting fresh stack..."
docker compose up -d 2>&1

echo "⏳ Waiting for services..."
sleep 10

# Check if app is healthy
APP_HEALTH=$(docker compose ps app --format json 2>/dev/null | grep -o '"Status":"[^"]*"' | head -1)

if docker compose ps 2>/dev/null | grep "app" | grep -q "Up"; then
    RESPONSE=$(curl -s http://localhost:8080/health 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "✅ App started successfully after DB was healthy!"
        echo ""
        echo "🎉 SUCCESS! Your flag:"
        FLAG=$(echo "$RESPONSE" | grep -o "FLAG{[^}]*}")
        echo "$FLAG"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
        curl -sf -X POST http://localhost:9000/api/complete \
          -H "Content-Type: application/json" \
          -d '{"challenge":"6","flag":"'"$FLAG"'"}' 2>/dev/null || true
    else
        echo "❌ App running but not responding correctly"
    fi
else
    echo "❌ App failed to start. Check your health checks and depends_on configuration."
    echo ""
    echo "Debug info:"
    docker compose ps
    docker compose logs app --tail 20
fi

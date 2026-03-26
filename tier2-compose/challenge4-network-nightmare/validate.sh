#!/bin/bash
echo "🔍 Validating Challenge 4: Network Nightmare"
echo ""

# Check if compose stack is running
if docker compose ps 2>/dev/null | grep -q "running"; then
    echo "✅ Compose stack is running"
    echo ""
    echo "🔗 Testing web -> api connectivity..."
    
    RESPONSE=$(curl -s http://localhost:8080/api/health 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "🎉 SUCCESS! All services communicating! Your flag:"
        echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    else
        echo "❌ Web can't reach API. Check your network configuration."
        echo "   Response: $RESPONSE"
    fi
else
    echo "❌ Compose stack not running. Start it with: docker compose up -d"
fi

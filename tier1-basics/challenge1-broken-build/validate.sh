#!/bin/bash
echo "🔍 Validating Challenge 1: The Broken Build"
echo ""

if docker images | grep -q "challenge1.*fixed"; then
    echo "✅ Image 'challenge1:fixed' found!"
    echo ""
    echo "🚀 Starting container to verify..."
    CONTAINER_ID=$(docker run -d -p 5001:5000 challenge1:fixed 2>/dev/null)
    sleep 3
    
    RESPONSE=$(curl -s http://localhost:5001/ 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "🎉 SUCCESS! Your flag:"
        FLAG=$(echo "$RESPONSE" | grep -o "FLAG{[^}]*}")
        echo "$FLAG"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
        curl -sf -X POST http://localhost:9000/api/complete \
          -H "Content-Type: application/json" \
          -d '{"challenge":"1","flag":"'"$FLAG"'"}' 2>/dev/null || true
    else
        echo "❌ Container running but app not responding correctly"
    fi
    
    docker stop $CONTAINER_ID >/dev/null 2>&1
    docker rm $CONTAINER_ID >/dev/null 2>&1
else
    echo "❌ Image 'challenge1:fixed' not found. Did you build it?"
    echo "   Run: docker build -t challenge1:fixed ."
fi

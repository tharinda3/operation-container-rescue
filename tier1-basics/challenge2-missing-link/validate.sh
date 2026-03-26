#!/bin/bash
echo "🔍 Validating Challenge 2: The Missing Link"
echo ""

if docker images | grep -q "challenge2.*fixed"; then
    echo "✅ Image 'challenge2:fixed' found!"
    echo ""
    echo "🚀 Testing if you can run it with the right config..."
    
    CONTAINER_ID=$(docker run -d -p 5002:5000 -e DATABASE_URL=postgres://localhost/mydb challenge2:fixed 2>/dev/null)
    sleep 3
    
    RESPONSE=$(curl -s http://localhost:5002/ 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "🎉 SUCCESS! Your flag:"
        echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    else
        echo "❌ Container not responding. Did you figure out the missing environment variable?"
    fi
    
    docker stop $CONTAINER_ID >/dev/null 2>&1
    docker rm $CONTAINER_ID >/dev/null 2>&1
else
    echo "❌ Image 'challenge2:fixed' not found. Build it first!"
fi

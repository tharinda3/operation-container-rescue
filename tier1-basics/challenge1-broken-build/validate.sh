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
        echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    else
        echo "❌ Container running but app not responding correctly"
    fi
    
    docker stop $CONTAINER_ID >/dev/null 2>&1
    docker rm $CONTAINER_ID >/dev/null 2>&1
else
    echo "❌ Image 'challenge1:fixed' not found. Did you build it?"
    echo "   Run: docker build -t challenge1:fixed ."
fi

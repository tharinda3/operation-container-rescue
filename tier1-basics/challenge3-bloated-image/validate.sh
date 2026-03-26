#!/bin/bash
echo "🔍 Validating Challenge 3: The Bloated Image"
echo ""

if docker images | grep -q "challenge3.*slim"; then
    SIZE=$(docker images challenge3:slim --format "{{.Size}}")
    SIZE_MB=$(echo $SIZE | grep -oE '[0-9]+' | head -1)
    
    echo "📦 Image 'challenge3:slim' size: $SIZE"
    
    # Check if size is under 200MB (rough check)
    if echo "$SIZE" | grep -qE "^[0-9]+(\.[0-9]+)?MB$"; then
        SIZE_NUM=$(echo "$SIZE" | grep -oE '[0-9]+' | head -1)
        if [ "$SIZE_NUM" -lt 200 ]; then
            echo "✅ Image is under 200MB! Great optimization!"
            echo ""
            echo "🚀 Verifying it still works..."
            
            CONTAINER_ID=$(docker run -d -p 5003:8080 challenge3:slim 2>/dev/null)
            sleep 2
            
            RESPONSE=$(curl -s http://localhost:5003/ 2>/dev/null)
            
            if echo "$RESPONSE" | grep -q "FLAG{"; then
                echo ""
                echo "🎉 SUCCESS! Your flag:"
                echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
                echo ""
                echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
            else
                echo "❌ Container running but app not responding"
            fi
            
            docker stop $CONTAINER_ID >/dev/null 2>&1
            docker rm $CONTAINER_ID >/dev/null 2>&1
        else
            echo "❌ Image still too big! Target: under 200MB"
        fi
    else
        echo "⚠️  Could not parse size. Checking if it works anyway..."
    fi
else
    echo "❌ Image 'challenge3:slim' not found."
    echo "   Build your optimized image as: docker build -t challenge3:slim ."
fi

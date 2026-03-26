#!/bin/bash
echo "🔍 Validating Challenge 8: Service Exposure"
echo ""

# Try common ports that might be exposed
PORTS="8080 8888 30000 30001 30080 31000 32000"
FLAG_FOUND=false

echo "🔍 Scanning for exposed service..."

for PORT in $PORTS; do
    RESPONSE=$(curl -s --connect-timeout 2 http://localhost:$PORT/ 2>/dev/null)
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "✅ Service found on port $PORT!"
        echo ""
        echo "🎉 SUCCESS! Your flag:"
        echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
        FLAG_FOUND=true
        break
    fi
done

if [ "$FLAG_FOUND" = false ]; then
    echo ""
    echo "❌ Could not reach the service from localhost."
    echo ""
    echo "Make sure you've exposed the service using one of:"
    echo "  - NodePort: kubectl patch svc exposure-service -p '{\"spec\": {\"type\": \"NodePort\"}}'"
    echo "  - Port forward: kubectl port-forward svc/exposure-service 8080:80"
    echo ""
    echo "Then run this validation again."
fi

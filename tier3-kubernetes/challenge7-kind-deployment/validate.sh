#!/bin/bash
echo "🔍 Validating Challenge 7: KinD Deployment"
echo ""

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Is it installed?"
    exit 1
fi

# Check cluster connection
if ! kubectl cluster-info --context docker-desktop &> /dev/null; then
    echo "❌ Cannot connect to Kubernetes cluster."
    echo "   Make sure Docker Desktop Kubernetes is enabled and running in KinD mode."
    exit 1
fi

echo "✅ Connected to Kubernetes cluster"
echo ""

# Check deployment
echo "📊 Checking deployment status..."
READY=$(kubectl get deployment rescue-app -o jsonpath='{.status.readyReplicas}' 2>/dev/null)

if [ "$READY" == "2" ]; then
    echo "✅ Deployment 'rescue-app' has 2/2 replicas ready!"
    echo ""
    
    # Port forward and test
    echo "🔗 Testing application..."
    kubectl port-forward svc/rescue-service 8888:80 &>/dev/null &
    PF_PID=$!
    sleep 3
    
    RESPONSE=$(curl -s http://localhost:8888/ 2>/dev/null)
    
    kill $PF_PID 2>/dev/null
    
    if echo "$RESPONSE" | grep -q "FLAG{"; then
        echo ""
        echo "🎉 SUCCESS! App deployed and running! Your flag:"
        FLAG=$(echo "$RESPONSE" | grep -o "FLAG{[^}]*}")
        echo "$FLAG"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
        curl -sf -X POST http://localhost:9000/api/complete \
          -H "Content-Type: application/json" \
          -d '{"challenge":"7","flag":"'"$FLAG"'","metrics":{"replicas":"'"$READY"'"}}' 2>/dev/null || true
    else
        echo "❌ App deployed but not responding correctly"
    fi
else
    echo "❌ Deployment not ready. Current ready replicas: $READY"
    echo ""
    echo "Debug info:"
    kubectl get pods -l app=rescue
    kubectl describe deployment rescue-app | tail -20
fi

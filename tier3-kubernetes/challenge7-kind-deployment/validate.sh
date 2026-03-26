#!/bin/bash
echo "🔍 Validating Challenge 7: KinD Deployment"
echo ""

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Is it installed?"
    exit 1
fi

# Check cluster connection
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Cannot connect to Kubernetes cluster. Is KinD running?"
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
        echo "$RESPONSE" | grep -o "FLAG{[^}]*}"
        echo ""
        echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
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

#!/bin/bash
echo "🔨 Building image and loading into KinD..."
echo ""

docker build -t exposure-app:v1 ./app
kind load docker-image exposure-app:v1

echo ""
echo "✅ Image loaded. Now deploy with: kubectl apply -f manifests/"
echo "   Then figure out how to expose the service!"

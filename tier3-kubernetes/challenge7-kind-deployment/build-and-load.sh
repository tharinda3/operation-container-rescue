#!/bin/bash
echo "🔨 Building image and loading into KinD..."
echo ""

# Build the image
docker build -t rescue-app:v1 ./app

# Load into KinD
kind load docker-image rescue-app:v1

echo ""
echo "✅ Image 'rescue-app:v1' loaded into KinD cluster"
echo "   Now fix the manifests and run: kubectl apply -f manifests/"

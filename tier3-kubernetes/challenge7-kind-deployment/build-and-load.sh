#!/bin/bash
echo "Building image and loading into KinD..."
echo ""

docker build -t rescue-app:v1 ./app
kind load docker-image rescue-app:v1 --name rescue-cluster

echo ""
echo "Image 'rescue-app:v1' loaded into KinD cluster"
echo "Now fix the manifests and run: kubectl apply -f manifests/"

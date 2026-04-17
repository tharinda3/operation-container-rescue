#!/bin/bash

echo "========================================="
echo "  Operation Container Rescue"
echo "  Environment Setup Check"
echo "========================================="
echo ""

PASS=0
FAIL=0

check() {
    local label="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        echo "  [OK]   $label"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] $label"
        FAIL=$((FAIL + 1))
    fi
}

echo "Checking required tools..."
echo ""

check "Docker CLI installed"        "docker --version"
check "Docker daemon running"       "docker info"
check "Docker Compose installed"    "docker compose version"
check "kubectl installed"           "kubectl version --client"

echo ""
echo "Checking Docker Desktop Kubernetes (KinD mode)..."
echo ""

# Check that Docker Desktop Kubernetes is enabled and running
KD_STATUS=$(docker desktop kubernetes status 2>/dev/null | grep "State:" | awk '{print $2}')
KD_MODE=$(docker desktop kubernetes status 2>/dev/null | grep "Mode:" | awk '{print $2}')
KD_VERSION=$(docker desktop kubernetes status 2>/dev/null | grep "Version:" | awk '{print $2}')

if [ "$KD_STATUS" = "running" ]; then
    echo "  [OK]   Docker Desktop Kubernetes is running"
    PASS=$((PASS + 1))
else
    echo "  [FAIL] Docker Desktop Kubernetes is not running (current state: ${KD_STATUS:-unknown})"
    echo "         Go to Docker Desktop Settings > Kubernetes, select 'Kind' mode, and click Enable."
    FAIL=$((FAIL + 1))
fi

if [ "$KD_MODE" = "kind" ]; then
    echo "  [OK]   Kubernetes mode is KinD"
    PASS=$((PASS + 1))
else
    echo "  [FAIL] Kubernetes mode is not KinD (current mode: ${KD_MODE:-unknown})"
    echo "         In Docker Desktop Settings > Kubernetes, make sure 'Kind' is selected."
    FAIL=$((FAIL + 1))
fi

if echo "$KD_VERSION" | grep -q "1.30"; then
    echo "  [OK]   Kubernetes version is v1.30.x (as required)"
    PASS=$((PASS + 1))
else
    echo "  [FAIL] Kubernetes version is not v1.30.x (found: ${KD_VERSION:-unknown})"
    echo "         Your organisation admins have configured v1.30.2. Check with the hackathon host."
    FAIL=$((FAIL + 1))
fi

echo ""
echo "Checking kubectl can reach the cluster..."
echo ""

check "kubectl connected to docker-desktop context"  "kubectl cluster-info --context docker-desktop"

echo ""
echo "========================================="

if [ "$FAIL" -eq 0 ]; then
    echo "  All checks passed! You are ready to go."
else
    echo "  $FAIL check(s) failed. Please fix the above before starting."
    echo "  Ask the hackathon host for help if needed."
fi

echo "========================================="
echo ""

exit $FAIL

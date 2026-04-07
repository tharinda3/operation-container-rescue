## Prerequisites

A KinD cluster must be running before starting this challenge.
If you have not created one yet, run this from the repo root:

    kind create cluster --config kind-config.yaml --name rescue-cluster

Verify it is ready:

    kubectl cluster-info --context kind-rescue-cluster

---

# 🔵 Challenge 8: Service Exposure

**Points: 30**

## Situation

The app is deployed in KinD but users outside the cluster can't access it. You need to properly expose the service so it's accessible from your host machine.

## Your Task

1. The deployment is already running (from Challenge 7 or provided)
2. Currently the service is ClusterIP only
3. Configure a way to access the service from outside the cluster
4. Verify you can curl the endpoint from your terminal
5. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Check current service
kubectl get svc

# Option A: NodePort
kubectl patch svc rescue-service -p '{"spec": {"type": "NodePort"}}'

# Option B: Port forward
kubectl port-forward svc/rescue-service 8080:80

# Option C: Create an Ingress (advanced)

# Test access
curl http://localhost:<port>/

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
ClusterIP services are only accessible within the cluster.
</details>

<details>
<summary>Hint 2 (medium)</summary>
NodePort or port-forward are the simplest ways to expose a service in KinD.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
For NodePort: change service type and use the assigned port. For port-forward: kubectl port-forward svc/rescue-service 8080:80
</details>

# 🔵 Challenge 7: KinD Deployment

**Points: 30**

## Situation

The team wants to test their app on Kubernetes before deploying to production. You need to deploy it to the local KinD cluster, but the manifests have errors.

## Your Task

1. Ensure your KinD cluster is running
2. Examine the Kubernetes manifests
3. Fix the errors in the deployment and service
4. Deploy to the cluster
5. Verify the pods are running
6. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Check KinD cluster
kubectl cluster-info

# Apply manifests
kubectl apply -f manifests/

# Check deployment status
kubectl get pods
kubectl get deployments
kubectl describe pod <pod-name>

# View logs
kubectl logs <pod-name>

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Check the image name and container port carefully.
</details>

<details>
<summary>Hint 2 (medium)</summary>
The deployment has an invalid image pull policy and wrong port.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
imagePullPolicy should be "IfNotPresent" or "Always" (not "Sometimes"). Container port should match what the app listens on (8080).
</details>

#!/bin/bash

echo "🗑️ Cleaning up 3-Tier Application..."

# Delete all resources
kubectl delete -f ingress.yaml
kubectl delete -f frontend.yaml
kubectl delete -f backend.yaml
kubectl delete -f database.yaml
kubectl delete -f pvc.yaml
kubectl delete -f secret.yaml
kubectl delete -f configmap.yaml

# Wait a bit
sleep 5

# Delete namespace
kubectl delete -f namespace.yaml

echo "✅ Cleanup complete!"

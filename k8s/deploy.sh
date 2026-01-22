#!/bin/bash

echo "🚀 Deploying 3-Tier Application to Kubernetes..."

# Create namespace
echo "📦 Creating namespace..."
kubectl apply -f namespace.yaml

# Wait a bit
sleep 2

# Create ConfigMap and Secrets
echo "🔧 Creating ConfigMap and Secrets..."
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml

# Wait a bit
sleep 2

# Create PVC
echo "💾 Creating Persistent Volume Claim..."
kubectl apply -f pvc.yaml

# Wait for PVC to be bound
echo "⏳ Waiting for PVC to be bound..."
kubectl wait --for=jsonpath='{.status.phase}'=Bound pvc/postgres-pvc -n three-tier-app --timeout=60s

# Deploy Database
echo "🗄️ Deploying PostgreSQL..."
kubectl apply -f database.yaml

# Wait for database to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=ready pod -l app=postgres -n three-tier-app --timeout=180s

# Deploy Backend
echo "⚙️ Deploying Backend..."
kubectl apply -f backend.yaml

# Wait for backend to be ready
echo "⏳ Waiting for Backend to be ready..."
kubectl wait --for=condition=ready pod -l app=backend -n three-tier-app --timeout=180s

# Deploy Frontend
echo "🎨 Deploying Frontend..."
kubectl apply -f frontend.yaml

# Wait for frontend to be ready
echo "⏳ Waiting for Frontend to be ready..."
kubectl wait --for=condition=ready pod -l app=frontend -n three-tier-app --timeout=120s

# Deploy Ingress (optional)
echo "🌐 Deploying Ingress..."
kubectl apply -f ingress.yaml

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 Deployment Status:"
kubectl get all -n three-tier-app

echo ""
echo "🔍 To access the application:"
echo "  kubectl port-forward svc/frontend-service 8080:80 -n three-tier-app"
echo "  Then visit: http://localhost:8080"
echo ""
echo "📝 To view logs:"
echo "  kubectl logs -f deployment/backend -n three-tier-app"
echo "  kubectl logs -f deployment/frontend -n three-tier-app"
echo "  kubectl logs -f deployment/postgres -n three-tier-app"

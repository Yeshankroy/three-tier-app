# 🚀 3-Tier Kubernetes Application

A production-ready, cloud-native application demonstrating modern microservices architecture deployed on Kubernetes.

![Architecture](https://img.shields.io/badge/Architecture-3--Tier-blue)
![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-green)
![React](https://img.shields.io/badge/React-18.2-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-326CE5)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Deployment](#detailed-deployment)
- [API Documentation](#api-documentation)
- [Kubernetes Resources](#kubernetes-resources)
- [Monitoring](#monitoring)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

This project demonstrates a complete 3-tier application architecture:

- **Presentation Tier**: React frontend with modern UI/UX
- **Application Tier**: Spring Boot REST API with business logic
- **Data Tier**: PostgreSQL database with persistent storage

**Features:**
- ✅ Full CRUD operations (Create, Read, Update, Delete)
- ✅ RESTful API design
- ✅ Containerized with Docker
- ✅ Orchestrated with Kubernetes
- ✅ Production-ready with health checks
- ✅ Horizontal Pod Autoscaling
- ✅ Persistent data storage
- ✅ Multi-stage Docker builds
- ✅ Non-root containers for security

---

## 🏗 Architecture
┌─────────────────────────────────────────────────────────────┐
│                         Internet                             │
└─────────────────────┬───────────────────────────────────────┘
│
▼
┌─────────────────┐
│  Ingress/LB     │  (Optional)
└────────┬────────┘
│
┌────────────┴────────────┐
│                         │
▼                         ▼
┌──────────────┐          ┌──────────────┐
│   Frontend   │          │   Backend    │
│   Service    │◄─────────┤   Service    │
│  (ClusterIP) │          │  (ClusterIP) │
└──────┬───────┘          └──────┬───────┘
│                         │
▼                         ▼
┌──────────────┐          ┌──────────────┐
│   Frontend   │          │   Backend    │
│  Deployment  │          │  Deployment  │
│              │          │              │
│ ┌──────────┐ │          │ ┌──────────┐ │
│ │ Nginx    │ │          │ │Spring    │ │
│ │ + React  │ │          │ │Boot +    │ │
│ │          │ │          │ │Java 17   │ │
│ └──────────┘ │          │ └──────────┘ │
│ Replicas: 2  │          │ Replicas: 2  │
└──────────────┘          └──────┬───────┘
│
▼
┌──────────────┐
│  PostgreSQL  │
│   Service    │
│  (ClusterIP) │
└──────┬───────┘
│
▼
┌──────────────┐
│  PostgreSQL  │
│  Deployment  │
│              │
│ ┌──────────┐ │
│ │PostgreSQL│ │
│ │    15    │ │
│ └──────────┘ │
│ Replicas: 1  │
└──────┬───────┘
│
▼
┌──────────────┐
│     PVC      │
│   (5GB)      │
└──────────────┘

---

## 💻 Tech Stack

### Frontend
- **React** 18.2 - UI library
- **Nginx** Alpine - Web server
- **CSS3** - Styling

### Backend
- **Java** 17 - Programming language
- **Spring Boot** 3.2.0 - Application framework
- **Spring Data JPA** - Data persistence
- **Hibernate** - ORM
- **Maven** 3.9+ - Build tool
- **Lombok** - Boilerplate reduction

### Database
- **PostgreSQL** 15 - Relational database

### DevOps
- **Docker** - Containerization
- **Kubernetes** - Orchestration
- **Kubectl** - K8s CLI

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

### Required Software

| Software | Version | Check Command |
|----------|---------|---------------|
| Java | 17+ | `java -version` |
| Maven | 3.9+ | `mvn -version` |
| Node.js | 18+ | `node -version` |
| npm | 9+ | `npm -version` |
| Docker | 24+ | `docker --version` |
| kubectl | 1.28+ | `kubectl version` |
| Kubernetes Cluster | 1.28+ | `kubectl cluster-info` |

### Kubernetes Cluster Options

- **Local Development**: Minikube, Kind, Docker Desktop
- **Cloud Providers**: GKE, EKS, AKS
- **On-Premises**: Rancher, OpenShift, Vanilla K8s

### Installation Guides

<details>
<summary><b>Ubuntu/Debian</b></summary>
```bash
# Java 17
sudo apt update
sudo apt install openjdk-17-jdk -y

# Maven
sudo apt install maven -y

# Node.js & npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Minikube (optional)
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
</details>

<details>
<summary><b>macOS</b></summary>
```bash
# Using Homebrew
brew install openjdk@17
brew install maven
brew install node@18
brew install docker
brew install kubectl
brew install minikube
```
</details>

---

## 🚀 Quick Start

### Clone and Deploy in 5 Minutes
```bash
# 1. Clone the repository
git clone https://github.com/YOUR-USERNAME/three-tier-app.git
cd three-tier-app

# 2. Build backend
cd backend
mvn clean package -DskipTests

# 3. Build frontend
cd ../frontend
npm install
npm run build

# 4. Build Docker images
cd ../backend
docker build -t yourusername/three-tier-backend:1.0.0 .

cd ../frontend
docker build -t yourusername/three-tier-frontend:1.0.0 .

# 5. Push to Docker Hub
docker login
docker push yourusername/three-tier-backend:1.0.0
docker push yourusername/three-tier-frontend:1.0.0

# 6. Update k8s YAML files with your image names
# Edit k8s/backend.yaml and k8s/frontend.yaml

# 7. Deploy to Kubernetes
cd ../k8s
chmod +x deploy.sh
./deploy.sh

# 8. Access the application
kubectl port-forward svc/frontend-service 8080:80 -n three-tier-app
# Open: http://localhost:8080
```

---

## 📚 Detailed Deployment

### Step 1: Build Backend Application
```bash
cd backend

# Download dependencies
mvn dependency:go-offline

# Build JAR file
mvn clean package -DskipTests

# Verify build
ls -lh target/app.jar
# Should show: ~45MB JAR file
```

**Test locally (optional):**
```bash
# Start PostgreSQL
docker run -d --name postgres-test \
  -e POSTGRES_DB=threetierdb \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  postgres:15-alpine

# Run backend
java -jar target/app.jar

# Test API
curl http://localhost:8080/api/items
curl http://localhost:8080/actuator/health

# Cleanup
docker rm -f postgres-test
```

### Step 2: Build Frontend Application
```bash
cd frontend

# Install dependencies
npm install

# Create production build
npm run build

# Verify build
ls -lh build/
```

**Test locally (optional):**
```bash
# Start dev server
npm start
# Opens at http://localhost:3000
```

### Step 3: Build Docker Images
```bash
# Backend
cd backend
docker build -t three-tier-backend:1.0.0 .

# Frontend
cd ../frontend
docker build -t three-tier-frontend:1.0.0 .

# Verify images
docker images | grep three-tier
```

### Step 4: Push to Container Registry

#### Docker Hub
```bash
# Login
docker login

# Tag images
docker tag three-tier-backend:1.0.0 yourusername/three-tier-backend:1.0.0
docker tag three-tier-frontend:1.0.0 yourusername/three-tier-frontend:1.0.0

# Push
docker push yourusername/three-tier-backend:1.0.0
docker push yourusername/three-tier-frontend:1.0.0
```

#### Google Container Registry (GCR)
```bash
gcloud auth configure-docker

docker tag three-tier-backend:1.0.0 gcr.io/YOUR-PROJECT/backend:1.0.0
docker tag three-tier-frontend:1.0.0 gcr.io/YOUR-PROJECT/frontend:1.0.0

docker push gcr.io/YOUR-PROJECT/backend:1.0.0
docker push gcr.io/YOUR-PROJECT/frontend:1.0.0
```

#### AWS ECR
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com

docker tag three-tier-backend:1.0.0 YOUR-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/backend:1.0.0
docker tag three-tier-frontend:1.0.0 YOUR-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/frontend:1.0.0

docker push YOUR-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/backend:1.0.0
docker push YOUR-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/frontend:1.0.0
```

### Step 5: Update Kubernetes Manifests

Edit `k8s/backend.yaml`:
```yaml
# Line ~47
image: yourusername/three-tier-backend:1.0.0  # Update this
```

Edit `k8s/frontend.yaml`:
```yaml
# Line ~24
image: yourusername/three-tier-frontend:1.0.0  # Update this
```

Edit `k8s/secret.yaml`:
```yaml
stringData:
  DB_PASSWORD: "ChangeThisPassword123!"  # Update this
  POSTGRES_PASSWORD: "ChangeThisPassword123!"  # Update this
```

### Step 6: Deploy to Kubernetes

#### Automated Deployment
```bash
cd k8s
chmod +x deploy.sh
./deploy.sh
```

#### Manual Deployment
```bash
cd k8s

# Create namespace
kubectl apply -f namespace.yaml

# Create ConfigMap and Secrets
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml

# Create storage
kubectl apply -f pvc.yaml

# Deploy database
kubectl apply -f database.yaml
kubectl wait --for=condition=ready pod -l app=postgres -n three-tier-app --timeout=120s

# Deploy backend
kubectl apply -f backend.yaml
kubectl wait --for=condition=ready pod -l app=backend -n three-tier-app --timeout=180s

# Deploy frontend
kubectl apply -f frontend.yaml
kubectl wait --for=condition=ready pod -l app=frontend -n three-tier-app --timeout=120s

# Deploy ingress (optional)
kubectl apply -f ingress.yaml
```

### Step 7: Verify Deployment
```bash
# Check all resources
kubectl get all -n three-tier-app

# Expected output:
# NAME                            READY   STATUS    RESTARTS   AGE
# pod/backend-xxx                 1/1     Running   0          2m
# pod/frontend-xxx                1/1     Running   0          1m
# pod/postgres-xxx                1/1     Running   0          3m

# Check logs
kubectl logs -f deployment/backend -n three-tier-app
kubectl logs -f deployment/frontend -n three-tier-app
kubectl logs -f deployment/postgres -n three-tier-app
```

### Step 8: Access Application

#### Port Forward (Development)
```bash
kubectl port-forward svc/frontend-service 8080:80 -n three-tier-app
# Access: http://localhost:8080
```

#### LoadBalancer (Cloud)
```bash
kubectl get svc frontend-service -n three-tier-app
# Access: http://<EXTERNAL-IP>
```

#### Ingress (Production)
```bash
kubectl get ingress -n three-tier-app
# Access: http://your-domain.com
```

---

## 📡 API Documentation

### Base URL
http://localhost:8080/api

### Endpoints

#### Health Check
```bash
GET /actuator/health

Response:
{
  "status": "UP",
  "components": {
    "db": {"status": "UP"},
    "diskSpace": {"status": "UP"}
  }
}
```

#### Get All Items
```bash
GET /api/items

Response:
[
  {
    "id": 1,
    "name": "Item Name",
    "description": "Item Description",
    "createdAt": "2026-01-22T10:30:00"
  }
]
```

#### Get Item by ID
```bash
GET /api/items/{id}

Response:
{
  "id": 1,
  "name": "Item Name",
  "description": "Item Description",
  "createdAt": "2026-01-22T10:30:00"
}
```

#### Create Item
```bash
POST /api/items
Content-Type: application/json

{
  "name": "New Item",
  "description": "Description"
}

Response: 201 Created
{
  "id": 2,
  "name": "New Item",
  "description": "Description",
  "createdAt": "2026-01-22T11:00:00"
}
```

#### Update Item
```bash
PUT /api/items/{id}
Content-Type: application/json

{
  "name": "Updated Name",
  "description": "Updated Description"
}

Response: 200 OK
```

#### Delete Item
```bash
DELETE /api/items/{id}

Response: 204 No Content
```

---

## ☸️ Kubernetes Resources

### Namespaces
- `three-tier-app` - Main application namespace

### Deployments
| Name | Replicas | Image |
|------|----------|-------|
| postgres | 1 | postgres:15-alpine |
| backend | 2 (autoscales to 10) | three-tier-backend:1.0.0 |
| frontend | 2 | three-tier-frontend:1.0.0 |

### Services
| Name | Type | Port |
|------|------|------|
| postgres-service | ClusterIP | 5432 |
| backend-service | ClusterIP | 8080 |
| frontend-service | LoadBalancer | 80 |

### ConfigMaps
- `app-config` - Environment variables

### Secrets
- `app-secrets` - Database credentials

### PersistentVolumeClaims
- `postgres-pvc` - 5GB storage for PostgreSQL

### HorizontalPodAutoscaler
- `backend-hpa` - Scales backend from 2-10 pods based on CPU/Memory

---

## 📊 Monitoring

### View Logs
```bash
# Backend logs
kubectl logs -f deployment/backend -n three-tier-app

# Frontend logs
kubectl logs -f deployment/frontend -n three-tier-app

# Database logs
kubectl logs -f deployment/postgres -n three-tier-app

# All pods
kubectl logs -f -l app=backend -n three-tier-app
```

### Resource Usage
```bash
# Pod resources
kubectl top pods -n three-tier-app

# Node resources
kubectl top nodes
```

### Health Checks
```bash
# Backend health
kubectl port-forward svc/backend-service 8080:8080 -n three-tier-app
curl http://localhost:8080/actuator/health

# Database connectivity
kubectl exec -it deployment/backend -n three-tier-app -- nc -zv postgres-service 5432
```

---

## 🐛 Troubleshooting

### Pods Not Starting
```bash
# Check pod status
kubectl get pods -n three-tier-app

# Describe pod for details
kubectl describe pod <pod-name> -n three-tier-app

# Check logs
kubectl logs <pod-name> -n three-tier-app
```

### Image Pull Errors
```bash
# Create image pull secret
kubectl create secret docker-registry regcred \
  --docker-server=docker.io \
  --docker-username=YOUR-USERNAME \
  --docker-password=YOUR-PASSWORD \
  -n three-tier-app

# Add to deployment spec
# imagePullSecrets:
#   - name: regcred
```

### Database Connection Issues
```bash
# Check if database is running
kubectl get pods -l app=postgres -n three-tier-app

# Test from backend pod
kubectl exec -it deployment/backend -n three-tier-app -- sh
nc -zv postgres-service 5432
```

### PVC Not Binding
```bash
# Check PVC status
kubectl get pvc -n three-tier-app

# Check storage classes
kubectl get storageclass

# Describe PVC for details
kubectl describe pvc postgres-pvc -n three-tier-app
```

---

## 🧹 Cleanup

### Quick Cleanup
```bash
cd k8s
./cleanup.sh
```

### Manual Cleanup
```bash
# Delete all resources
kubectl delete namespace three-tier-app

# Verify deletion
kubectl get all -n three-tier-app
```

---

## 📁 Project Structure
three-tier-app/
├── backend/
│   ├── src/
│   │   └── main/
│   │       ├── java/
│   │       │   └── com/example/threetier/
│   │       │       ├── ThreeTierApplication.java
│   │       │       ├── controller/
│   │       │       │   └── ItemController.java
│   │       │       ├── entity/
│   │       │       │   └── ItemEntity.java
│   │       │       ├── repository/
│   │       │       │   └── ItemRepository.java
│   │       │       └── service/
│   │       │           └── ItemService.java
│   │       └── resources/
│   │           └── application.yml
│   ├── pom.xml
│   └── Dockerfile
├── frontend/
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── App.js
│   │   ├── App.css
│   │   ├── index.js
│   │   └── index.css
│   ├── package.json
│   ├── nginx.conf
│   └── Dockerfile
├── k8s/
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── pvc.yaml
│   ├── database.yaml
│   ├── backend.yaml
│   ├── frontend.yaml
│   ├── ingress.yaml
│   ├── deploy.sh
│   └── cleanup.sh
├── .gitignore
└── README.md

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

**Your Name**
- GitHub: https://github.com/Yeshankroy
- LinkedIn: https://www.linkedin.com/in/yeshank-roy-0406691bb

---

## 🙏 Acknowledgments

- Spring Boot Team
- React Team
- Docker Community
- Kubernetes Community
- PostgreSQL Team

---

## 📞 Support

For support, email yeshankroy@gmail.com or open an issue in the repository.

---

**⭐ If you found this project helpful, please give it a star!**
# three-tier-app

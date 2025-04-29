#!/bin/bash

# Configuration
PROJECT_ID="cubz-sample-project-gcp"
CLUSTER_NAME="autopilot-cluster-1"
CLUSTER_ZONE="asia-southeast1-a"

# Build the Docker image using Cloud Build
echo "Building Docker image..."
gcloud builds submit --tag gcr.io/${PROJECT_ID}/hello-world:latest .

# Get GKE credentials
echo "Getting GKE credentials..."
gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${CLUSTER_ZONE} --project ${PROJECT_ID}

# Deploy to GKE
echo "Deploying to GKE..."
kubectl apply -f deployment.yaml

# Wait for deployment to be ready
echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/hello-world

# Get the external IP
echo "Getting external IP..."
kubectl get service hello-world 
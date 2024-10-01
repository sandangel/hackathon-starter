#!/bin/sh

# Apply Kubernetes manifests using Kustomize for the specified environment
kubectl diff -k k8s/overlays/dev
kubectl apply -k k8s/overlays/dev

# Wait for deployment to be successful
kubectl rollout status deployment/web-deployment

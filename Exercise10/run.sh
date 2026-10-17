#!/bin/bash
set -x
minikube stop; minikube delete
minikube start --nodes 3 -p devops-multinode --force
kubectl get nodes
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest  -f Dockerfile.shopping .
minikube -p devops-multinode image load product-catalog:latest
minikube -p devops-multinode image load shopping-cart:latest
minikube -p devops-multinode ssh -- docker images | grep -E "product-catalog|shopping-cart"
kubectl apply -f product_catalog_deployment.yaml -f shopping_cart_deployment.yaml
kubectl apply -f product_catalog_service.yaml -f shopping_cart_service.yaml
kubectl rollout status deployment/product-catalog
kubectl rollout status deployment/shopping-cart
kubectl get pods -o wide
minikube -p devops-multinode service product-catalog-service --url   # terminal 2, keep open
minikube -p devops-multinode service shopping-cart-service  --url   # terminal 3, keep open
# curl <catalog-url>/products ; curl <cart-url>/cart ; curl -X POST <cart-url>/cart -H "Content-Type: application/json" -d '{"id":1,"name":"Laptop","quantity":1}'

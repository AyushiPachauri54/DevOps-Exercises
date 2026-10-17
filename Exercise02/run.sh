#!/bin/bash
set -x
minikube start
eval $(minikube docker-env)
docker build -t flask-app .
kubectl apply -f flask-deployment.yaml
kubectl rollout status deployment/flask-app
kubectl get deployments
kubectl get pods -l app=flask-app
kubectl get services
minikube service flask-app-service --url   # keep open; curl the printed URL in a 2nd terminal

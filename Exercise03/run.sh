#!/bin/bash
set -x
minikube stop; minikube delete
minikube start --nodes=1
kubectl get nodes
eval $(minikube docker-env)
docker build -t flashsale:1.0 .          # build BEFORE applying so the pods can start
kubectl apply -f flashsale-replicaset.yaml
kubectl get rs; kubectl get pods
kubectl scale rs flashsale-rs --replicas=5
kubectl get rs; kubectl get pods
POD=$(kubectl get pods -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod $POD
sleep 5; kubectl get pods
kubectl get pods -o wide

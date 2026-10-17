#!/bin/bash
# Exercise 1 - run on a machine with Docker + Minikube + kubectl
set -x
minikube start
kubectl run hello-k8s --image=nginx --port=80
kubectl wait --for=condition=Ready pod/hello-k8s --timeout=120s
kubectl get pods
kubectl expose pod hello-k8s --type=NodePort --port=80
kubectl get svc hello-k8s
minikube service hello-k8s --url      # keep terminal open (docker driver), then: curl <url>

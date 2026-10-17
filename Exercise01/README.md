Exercise 1 – Hello Pod (Kubernetes Getting Started)

Deploy an Nginx web server on a local Kubernetes cluster using Minikube and kubectl.

Project Structure

Exercise01/
├── run.sh
├── hello-pod.yaml
├── QUESTION.md
├── README.md
├── logs/
└── screenshots/

How It Works

1. Minikube starts a local Kubernetes cluster.
2. A Pod is created using the Nginx container image.
3. kubectl verifies that the Pod is running.
4. A NodePort Service exposes the Nginx Pod.
5. Minikube provides access to the Nginx welcome page.

Steps to Run

1. Start Minikube

minikube start

2. Create the Nginx Pod

kubectl run hello-k8s --image=nginx --port=80

3. Check the Pod status

kubectl get pods

4. Expose the Pod as a Service

kubectl expose pod hello-k8s --type=NodePort --port=80

5. Access the Nginx application

minikube service hello-k8s

The Nginx welcome page should open in the browser.

Verification

Verify that the Pod is running, the Service is available, and the Nginx welcome page can be accessed.

Screenshots

Add screenshots after running the exercise successfully:

* Pod status in the terminal
* Kubernetes Service details
* Nginx welcome page in the browser

Tech Stack

Kubernetes, Minikube, kubectl, Docker, and Nginx.

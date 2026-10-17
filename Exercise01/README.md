# Exercise 1 – Hello Pod (Kubernetes getting started)

**Status: 🔴 BLOCKED – written but NOT executed.** Minikube, kubectl and Docker are not available in the environment where this was prepared. Only the YAML syntax was checked.

## Question (original text in [`QUESTION.md`](QUESTION.md))
You are a DevOps engineer at Zepto. Deploy a web app (simulated with the `nginx` image) on Kubernetes so it is always running, portable and can be scaled later:
1. `minikube start` 2. `kubectl run hello-k8s --image=nginx --port=80` 3. `kubectl get pods` 4. `kubectl expose pod hello-k8s --type=NodePort --port=80` 5. `minikube service hello-k8s` → Nginx welcome page.

## Objective
Run the first container inside Kubernetes (as a **Pod**), make it reachable with a **Service**, and open it in a browser.

## Prerequisites
Docker (or a VM driver), Minikube, kubectl. Install commands for Linux/macOS/Windows/WSL are in `QUESTION.md`.

## Files
| File | Purpose |
|---|---|
| `run.sh` | all commands from the question, in order |
| `hello-pod.yaml` | the same Pod + Service as YAML (declarative form of steps 2 and 4) |

## How to run
```bash
bash run.sh
minikube service hello-k8s     # keep this terminal open when using the Docker driver
```

## Simple explanation (for viva)
* **Pod** = smallest deployable unit; wraps one or more containers.
* A Pod IP works only inside the cluster, so we add a **Service**. `NodePort` opens a port on the node so it can be reached from outside.
* `minikube service` finds that port and opens it for us.
* A bare Pod is not rescheduled if it dies – that is why Exercises 2, 3 and 10 use Deployments/ReplicaSets.

## Verification
| Check | Result |
|---|---|
| YAML syntax of `hello-pod.yaml` | ✅ parsed – [`logs/static-checks.txt`](logs/static-checks.txt) |
| Cluster started, pod Running, nginx page opened | ⛔ **not run** |

`screenshots/terminal-capture-static-checks.png` shows only the YAML check – it is **not** proof that the pod ran.

## To finish (needs you)
Run `bash run.sh` on a machine with Minikube and save screenshots in `screenshots/`: `01-pods-running.png`, `02-service.png`, `03-nginx-page.png`; then update the status.

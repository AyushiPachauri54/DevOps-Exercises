# Exercise 3 – Scaling a Flask app with ReplicaSets (Flash Sale)

**Status: 🟡 PARTIAL.** The app endpoints and YAML were tested; image build, ReplicaSet creation, scaling and self-healing on Minikube were **NOT run**.

## Question (original text in [`QUESTION.md`](QUESTION.md))
Build a "Big Sale" Flask app (`/`, `/buy`, `/health`), containerise it, run it as a **ReplicaSet of 3 pods** on single-node Minikube (probes, resources, ClusterIP Service), **scale to 5**, **delete a pod** and watch it return, show pod placement (`kubectl get pods -o wide`), and answer the questions.

## Files
`app.py`, `Dockerfile`, `flashsale-replicaset.yaml` (ReplicaSet + Service), `run.sh`.

## How to run (machine with Minikube)
```bash
bash run.sh
```

## Fixes to the manual (it would not work as written)
1. Dockerfile copied `ex3-flash-sale.py` but started `app:app` → file must be `app.py`.
2. Manual built `flask-app`, the YAML used `flashsale:1.0`, and later commands scaled `flask-app-rs` (does not exist; the RS is `flashsale-rs`). Everything now uses `flashsale:1.0` / `flashsale-rs`.
3. The image must be built inside Minikube's Docker **before** pods can start; added `imagePullPolicy: IfNotPresent`.

## Simple explanation
A **ReplicaSet** keeps N identical pods running. Delete one → a new one is created. Scale → change N. Identical copies share traffic, like opening more checkout counters in a flash sale. `/health` feeds the readiness probe (ready for traffic?) and liveness probe (still alive?). The `pod` field in the JSON shows which pod answered.

## Verification
| Check | Result |
|---|---|
| `/`, `/buy?user=123`, `/buy`, `/health` return correct JSON locally | ✅ really run – [`logs/local-test.txt`](logs/local-test.txt) (pod name shows the sandbox hostname `vm`) |
| ReplicaSet + Service YAML parses | ✅ syntax only |
| gunicorn start, image build, 3 pods, scale 5, delete & recreate, `-o wide` | ⛔ **not run** (no Docker/Minikube; gunicorn not installed here) |

![local test](screenshots/terminal-capture-local-test.png)

## Q&A
1. Initial replicas: **3**. 2. Pods after apply: **3**. 3. Scale to 5: Kubernetes creates **2 more** pods. 4. Delete a pod: the ReplicaSet creates a **replacement**. 5. How is the count kept? A controller loop compares desired vs actual and creates/deletes pods. 6. Nodes: **1**. 7. Placement: all pods on the single node `minikube` (confirm with `kubectl get pods -o wide`).

## To finish (needs you)
`bash run.sh`; screenshots: `01-3-pods.png`, `02-scaled-5.png`, `03-after-delete.png`, `04-pods-wide.png`.

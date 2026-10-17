# Exercise 6 – Real-time monitoring and alerting (Python + Prometheus + Grafana + Jenkins)

**Status: 🔴 BLOCKED – written but NOT executed.** `prometheus_client`, Docker, Prometheus, Grafana and Jenkins are all unavailable where this was prepared. Only syntax checks were done.

## Question (original text in [`QUESTION.md`](QUESTION.md))
As DevOps engineer at ZAPPTTO build a pipeline that: simulates delivery metrics in Python (`delivery_metrics.py`, port 8000 `/metrics`), scrapes them with **Prometheus** (`prometheus.yml`), defines **alert rules** (`alert_rules.yml`), shows a 4-panel **Grafana** dashboard (total, pending, on-the-way, average delivery time), automates it with a **Jenkinsfile**, and then simulates an alert by raising `pending_deliveries`.

## Files (`delivery_monitoring/`)
`delivery_metrics.py`, `prometheus.yml`, `alert_rules.yml`, `Dockerfile` (missing in the manual but required by its Jenkinsfile), `Jenkinsfile`, `run.sh`.

## How to run (Linux/WSL with Docker)
```bash
cd delivery_monitoring && bash run.sh
```
Then: Prometheus http://localhost:9090 (Status → Targets, Alerts) · Grafana http://localhost:3000 (admin/admin) → Data source Prometheus `http://172.17.0.1:9090` → 4 panels:
`total_deliveries`, `pending_deliveries`, `on_the_way_deliveries`, `average_delivery_time_sum / average_delivery_time_count`.
**Simulate alert:** in `delivery_metrics.py` set `pending = random.randint(50, 100)`, restart the script.

## Problems found in the manual (fixed here)
1. Alert file is called `alert_rules.yml` in one place and `alerts_rules.yml` in another → one name used everywhere.
2. Jenkinsfile `docker build` has **no Dockerfile** → added one.
3. Jenkinsfile copies files from a hard-coded `/path/to/your/local/files` → removed; with *Pipeline script from SCM* the files are already in `$WORKSPACE`.
4. Rerunning the pipeline fails because containers already exist → `docker rm -f … || true` added.
5. Added `scrape_interval: 5s` (manual's default is 15 s) so the `for: 15s` alert and dashboard react quickly.
6. **Known limitation:** if Jenkins runs *inside* Docker, `-v $WORKSPACE/…` mounts refer to the **host** path, not the Jenkins container's, so Prometheus may get empty mounts. Fix: mount the Docker socket and use a shared host path, or run the Prometheus/Grafana steps from the host.
7. Manual says the target is `host.docker.internal` in the notes but uses `172.17.0.1` in YAML – `172.17.0.1` is right for Linux/WSL.

## Simple explanation
The Python program is the **exporter**: it keeps numbers (Gauges, plus a Summary for delivery time) and serves them as text at `/metrics`. **Prometheus** pulls (scrapes) that text on a timer and stores it as time series; **alert rules** are queries (`pending_deliveries > 10`) that fire if true for 15 s. **Grafana** only draws charts from Prometheus. **Jenkins** automates build + start of all containers.

## Verification
| Check | Result |
|---|---|
| `delivery_metrics.py` compiles | ✅ |
| `prometheus.yml`, `alert_rules.yml` valid YAML | ✅ syntax only – [`logs/static-checks.txt`](logs/static-checks.txt) (not validated with `promtool`) |
| `prometheus_client` installed here | ❌ so the script was **not run**; no metrics output captured |
| Prometheus targets UP, alerts firing, Grafana dashboard, Jenkins build | ⛔ **not run** |

## To finish (needs you)
`bash run.sh`; screenshots: `01-metrics-endpoint.png`, `02-prometheus-targets.png`, `03-prometheus-alerts-firing.png`, `04-grafana-dashboard.png`, `05-jenkins-build.png`.

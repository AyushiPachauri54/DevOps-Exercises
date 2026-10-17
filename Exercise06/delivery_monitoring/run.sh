#!/bin/bash
# Exercise 6 - run on a host with Docker
set -x
pip3 install prometheus-client
python3 delivery_metrics.py &            # exposes http://localhost:8000/metrics
sleep 3; curl -s localhost:8000/metrics | grep -E "total_deliveries|pending_deliveries|on_the_way|average_delivery_time"
docker run -d --name prometheus --network=host \
  -v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v $PWD/alert_rules.yml:/etc/prometheus/alert_rules.yml prom/prometheus
docker run -d --name grafana -p 3000:3000 grafana/grafana
# Then in the browser: Prometheus http://localhost:9090 (Status>Targets, Alerts)
# Grafana http://localhost:3000 (admin/admin) -> add Prometheus data source http://172.17.0.1:9090 -> build 4 panels

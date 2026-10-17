# The manual's Jenkinsfile runs "docker build -t delivery_metrics ." but gives no Dockerfile - this is it.
FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir prometheus-client
COPY delivery_metrics.py .
EXPOSE 8000
CMD ["python", "-u", "delivery_metrics.py"]

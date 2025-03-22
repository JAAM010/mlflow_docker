#!/bin/bash

echo "******* MLFLOW SERVER LAUNCHER *******"
echo "This script will launch an MLflow server in a Docker container"
echo ""

# Check if Docker is installed and running
echo "🔍 Checking if Docker is running..."
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running or not accessible. Please start Docker and try again."
    exit 1
else
    echo "✅ Docker is running."
fi

echo ""

# Check MLflow-related services using docker-compose
echo "🔍 Checking MLflow services..."
mlflow_services=("mlflow" "postgres" "minio")  # adjust to your actual service names
running=0

for svc in "${mlflow_services[@]}"; do
    if docker compose ps "$svc" 2>/dev/null | grep -q "Up"; then
        ((running++))
    fi
done

echo "➡️  $running out of ${#mlflow_services[@]} MLflow services are running."

if [[ $running -eq 0 ]]; then
    echo "🚀 Starting MLflow services..."
    docker compose up --build -d
elif [[ $running -lt ${#mlflow_services[@]} ]]; then
    echo "⚠️  Partial MLflow services running. Restarting all services..."
    docker compose down
    docker compose up --build -d
else
    echo "✅ All MLflow services are already running."
fi

echo ""
echo "🌐 MLflow server should be available at: http://localhost:8888"
@echo off
echo ******* MLFLOW SERVER LAUNCHER *******
echo This script will launch an MLflow server in a Docker container
echo.

:: Verificar si Docker está corriendo
echo 🔍 Checking if Docker is running...
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not running or not accessible. Please start Docker and try again.
    exit /b 1
) else (
    echo ✅ Docker is running.
)

echo.

:: Verificar si los servicios están corriendo
echo 🔍 Checking MLflow services...

setlocal enabledelayedexpansion
set "services=mlflow postgres minio"
set /a running=0

for %%s in (%services%) do (
    docker compose ps %%s 2>nul | findstr /C:"Up" >nul
    if !errorlevel! == 0 (
        set /a running+=1
    )
)

echo ➡️  !running! out of 3 MLflow services are running.

if !running! == 0 (
    echo 🚀 Starting MLflow services...
    docker compose up --build -d
) else if !running! lss 3 (
    echo ⚠️  Partial MLflow services running. Restarting all services...
    docker compose down
    docker compose up --build -d
) else (
    echo ✅ All MLflow services are already running.
)

echo.
echo 🌐 MLflow server should be available at: http://localhost:8888
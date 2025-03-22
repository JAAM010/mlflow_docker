# MLflow Study with PostgreSQL and MinIO

This repository contains a setup for running an MLflow server using Docker Compose, with PostgreSQL as the backend store and MinIO as the artifact store.

## Features

- **MLflow Server**: Tracks experiments and manages models.
- **PostgreSQL**: Stores MLflow metadata (backend store).
- **MinIO**: Acts as an S3-compatible artifact store for MLflow.

## Prerequisites

Before running this setup, ensure you have the following installed:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)


## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/hrodriguezgi/mlflow_docker
   cd mlflow_docker
   ```

2. Starting mlflow
   ```
   bash run.sh
   ```

3. Once the previous script finishes you should see the next message:
   ```bash
   🌐 MLflow server should be available at: http://localhost:8888
   ```

   It means your **mlflow server** is up and you can launch your experiments.
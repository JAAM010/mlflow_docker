FROM mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu22.04

# Install Python dependencies
RUN pip install mlflow psycopg2-binary boto3

# Install PostgreSQL client (for MLflow to interact with PostgreSQL)
RUN apt-get install -y postgresql-client

# Expose MLflow UI port
EXPOSE 8888

# Start MLflow server with PostgreSQL as backend store
CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "8888", "--serve-artifacts"]

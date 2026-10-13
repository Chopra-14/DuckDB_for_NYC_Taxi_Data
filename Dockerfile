FROM python:3.11-slim

# Install system dependencies (if any)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install dbt and duckdb adapter
RUN pip install --no-cache-dir dbt-core dbt-duckdb

# Set working directory
WORKDIR /app

# Copy project files (excluding data files) into the container
COPY . /app

# Default command (can be overridden in docker-compose)
CMD ["bash"]

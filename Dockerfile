# Use official Python 3.9 slim image as base
FROM python:3.9-slim

# Create working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY service/ ./service/

# Create non-root user and set permissions
RUN useradd --uid 1000 theia && \
    chown -R theia /app

# Switch to non-root user
USER theia

# Expose application port
EXPOSE 8080

# Run Gunicorn WSGI server
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

# # # ---------- BUILDER STAGE ----------
# # FROM python:3.10-slim AS builder
# # WORKDIR /app

# # # Only copy requirements to speed up caching
# # COPY  . .
# # RUN pip install --user --no-cache-dir -r requirements.txt

# # # ---------- RUNTIME STAGE ----------
# # FROM python:3.10-slim AS runtime
# # WORKDIR /app

# # # Copy your local app.py directly
# # COPY app.py .

# # # Copy dependencies from builder
# # COPY --from=builder /app/app.py /app/app.py

# # CMD ["python", "app.py"]

# # ---- Builder Stage ----
# FROM python:3.9-slim AS builder
# WORKDIR /app

# # Copy requirements and install
# COPY requirements.txt .
# RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# # Copy application and big file generator
# COPY app.py .
# COPY make_bigfiles.py .

# # Run the script to generate big files
# RUN python make_bigfiles.py

# # ---- Runtime Stage ----
# FROM python:3.9-slim
# WORKDIR /app

# # Copy installed packages from builder
# COPY --from=builder /install /usr/local

# # Copy app.py and big files from builder
# COPY --from=builder /app/app.py .
# COPY --from=builder /app/bigfile1.bin .
# COPY --from=builder /app/bigfile2.bin .

# # Run the app
# CMD ["python", "app.py"]

# Builder Stage

# # ---- Builder Stage ----
# FROM python:3.9-slim AS builder
# WORKDIR /app

# # Install build tools only in the builder
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends build-essential gcc libjpeg-dev zlib1g-dev

# COPY requirements.txt .
# RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# COPY app.py .

# # ---- Runtime Stage ----
# FROM python:3.9-slim
# WORKDIR /app

# # Copy only installed packages and app code from builder
# COPY --from=builder /install /usr/local
# COPY --from=builder /app/app.py .

# CMD ["python", "app.py"]

# ---- Builder Stage ----
FROM python:3.9-slim AS builder
WORKDIR /app

# Install build dependencies (needed for Pillow)
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential gcc libjpeg-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages into /install
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy app code
COPY app.py .

# ---- Runtime Stage ----
FROM python:3.9-slim
WORKDIR /app

# Copy installed packages and app code
COPY --from=builder /install /usr/local
COPY --from=builder /app/app.py .

# Run Flask app
CMD ["python", "app.py"]

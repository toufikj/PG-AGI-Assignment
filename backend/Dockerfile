# --- Builder Stage ---
FROM python:3.11-slim AS builder

WORKDIR /app

# Prevent apt from prompting for input
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies (only if needed for certain Python libs)
RUN apt-get update && apt-get install -y --no-install-recommends gcc g++ libffi-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies into /install instead of system-wide
RUN pip install --upgrade pip && pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy application code
COPY . .


FROM gcr.io/distroless/python3

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /app /app

ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

EXPOSE 8000

CMD ["-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
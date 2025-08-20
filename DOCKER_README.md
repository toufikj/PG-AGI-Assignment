# Docker Setup Instructions

## Overview

This project consists of a FastAPI backend and a Next.js frontend, both containerized using Docker. The `docker-compose.yml` file orchestrates both services.

## Prerequisites

- Docker
- Docker Compose

## Running the Application

1. Clone the repository
2. Navigate to the project root directory
3. Run the following command to start both services:

```bash
docker-compose up
```

4. To run in detached mode (in the background):

```bash
docker-compose up -d
```

5. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - Backend Health Check: http://localhost:8000/api/health

## Stopping the Application

```bash
docker-compose down
```

## Rebuilding the Images

If you make changes to the code, you'll need to rebuild the Docker images:

```bash
docker-compose build
```

Or to rebuild and start in one command:

```bash
docker-compose up --build
```

## Environment Variables

### Frontend
- `NEXT_PUBLIC_API_URL`: URL of the backend API (set to http://backend:8000 in Docker)

### Backend
- No specific environment variables required for the backend in this setup

## Docker Files

- `backend/Dockerfile`: Containerizes the FastAPI application
- `frontend/Dockerfile`: Containerizes the Next.js application
- `docker-compose.yml`: Orchestrates both services
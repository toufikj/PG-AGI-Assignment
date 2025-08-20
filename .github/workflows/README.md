# GitHub Actions Workflows

This directory contains GitHub Actions workflows for automating the deployment of the application infrastructure and services.

## Workflows

### 1. Terraform Infrastructure Deployment (`terraform-deploy.yml`)

This workflow manages the deployment of the AWS infrastructure using Terraform.

**Triggers:**
- Push to `main` branch that changes files in the `infra/` directory
- Manual trigger via GitHub Actions UI

**Features:**
- Terraform format checking
- Terraform validation
- Terraform plan generation
- Optional Terraform apply (via manual trigger)
- PR comments with plan output

**Required Secrets:**
- `AWS_ACCESS_KEY_ID`: AWS access key ID with permissions to deploy resources
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key corresponding to the access key ID
- `AWS_REGION`: AWS region to deploy to

### 2. Build and Deploy to ECR/ECS (`deploy-to-ecr-ecs.yml`)

This workflow builds Docker images for the frontend and backend, pushes them to ECR, and updates the ECS services.

**Triggers:**
- Push to `main` branch that changes files in the `frontend/` or `backend/` directories
- Manual trigger via GitHub Actions UI

**Features:**
- Builds Docker images for frontend and backend
- Tags and pushes images to ECR
- Updates ECS services with new images
- Waits for services to be stable
- Optional selective deployment of frontend or backend

**Required Secrets:**
- `AWS_ACCESS_KEY_ID`: AWS access key ID with permissions to push to ECR and update ECS
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key corresponding to the access key ID
- `AWS_REGION`: AWS region where resources are deployed

## Setup Instructions

1. Create an IAM user in AWS with the necessary permissions:
   - ECR: Push images
   - ECS: Update services
   - Terraform: Create/update/delete resources

2. Configure GitHub repository secrets:
   - Go to your repository settings
   - Navigate to Secrets > Actions
   - Add the following secrets:
     - `AWS_ACCESS_KEY_ID`: The AWS access key ID
     - `AWS_SECRET_ACCESS_KEY`: The AWS secret access key
     - `AWS_REGION`: The AWS region (e.g., `us-east-1`)

3. For the first deployment:
   - Manually run the `Terraform Infrastructure Deployment` workflow with the `apply` option set to `true`
   - Once the infrastructure is deployed, run the `Build and Deploy to ECR/ECS` workflow

## Notes

- The workflows use AWS access keys for authentication with AWS
- The Terraform workflow includes safeguards to prevent accidental applies
- Both workflows can be triggered manually for testing or one-off deployments
# Terraform Infrastructure for PG-AGI Assignment

This directory contains Terraform configuration files to deploy the frontend and backend applications to AWS using ECS Fargate.

## Infrastructure Components

- **VPC**: A Virtual Private Cloud with one public subnet and one private subnet
- **Internet Gateway**: For the public subnet to access the internet
- **NAT Gateway**: For the private subnet to access the internet
- **Security Groups**: For controlling inbound and outbound traffic
- **ECR Repositories**: For storing Docker images of the frontend and backend applications
- **ECS Cluster**: For running the containerized applications
- **ECS Services**: For managing the frontend and backend tasks
- **Application Load Balancer**: For routing traffic to the appropriate service

## Prerequisites

- AWS CLI configured with appropriate credentials (access key and secret key)
- Terraform installed (version >= 1.0.0)
- Docker installed (for building and pushing images)

## Usage

### Initialize Terraform with Remote State

This project uses a remote state stored in an S3 bucket. To initialize Terraform with the remote state configuration, run:

```bash
# On Linux/Mac
terraform init

# On Windows
.\init_remote_state.ps1
```

The remote state is stored in the `terraform-20-25` S3 bucket with DynamoDB locking enabled.

### Plan the Infrastructure

```bash
terraform plan
```

### Apply the Infrastructure

```bash
terraform apply
```

### Build and Push Docker Images

After applying the Terraform configuration, you'll need to build and push the Docker images to the ECR repositories:

1. Get the ECR repository URLs from the Terraform outputs:

```bash
terraform output frontend_repository_url
terraform output backend_repository_url
```

2. Authenticate Docker with ECR:

```bash
aws ecr get-login-password --region $(terraform output -raw aws_region) | docker login --username AWS --password-stdin $(terraform output -raw frontend_repository_url | cut -d/ -f1)
```

3. Build and push the frontend image:

```bash
cd ../frontend
docker build -t $(terraform output -raw frontend_repository_url):latest .
docker push $(terraform output -raw frontend_repository_url):latest
```

4. Build and push the backend image:

```bash
cd ../backend
docker build -t $(terraform output -raw backend_repository_url):latest .
docker push $(terraform output -raw backend_repository_url):latest
```

### Access the Application

After the ECS services are running, you can access the application using the ALB DNS name:

```bash
terraform output alb_dns_name
```

The frontend will be available at `http://<alb_dns_name>` and the backend API at `http://<alb_dns_name>/api`.

### Clean Up

To destroy the infrastructure when you're done:

```bash
terraform destroy
```

## Variables

You can customize the deployment by modifying the variables in `variables.tf` or by creating a `terraform.tfvars` file.

## Notes

- The frontend is configured to communicate with the backend through the ALB.
- Both services run in the private subnet for security, with the ALB in the public subnet.
- The security groups are configured to allow all TCP traffic inbound, with specific rules for ports 3000 and 8000.
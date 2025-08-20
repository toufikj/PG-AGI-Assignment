# AWS Region
aws_region = "ap-south-1"

# Project Information
project_name = "pg-agi"
environment  = "production"

# VPC Configuration
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
availability_zones   = ["ap-south-1a", "ap-south-1b"]

# Container Configuration
frontend_container_port = 3000
backend_container_port  = 8000

# ECS Task Configuration
frontend_cpu          = 256
frontend_memory       = 512
backend_cpu           = 256
backend_memory        = 512
frontend_desired_count = 1
backend_desired_count  = 1
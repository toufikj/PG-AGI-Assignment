variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "pg-agi"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "frontend_container_port" {
  description = "Port exposed by the frontend container"
  type        = number
  default     = 3000
}

variable "backend_container_port" {
  description = "Port exposed by the backend container"
  type        = number
  default     = 8000
}

variable "frontend_cpu" {
  description = "CPU units for the frontend task"
  type        = number
  default     = 256
}

variable "frontend_memory" {
  description = "Memory for the frontend task in MiB"
  type        = number
  default     = 512
}

variable "backend_cpu" {
  description = "CPU units for the backend task"
  type        = number
  default     = 256
}

variable "backend_memory" {
  description = "Memory for the backend task in MiB"
  type        = number
  default     = 512
}

variable "frontend_desired_count" {
  description = "Desired count of frontend tasks"
  type        = number
  default     = 1
}

variable "backend_desired_count" {
  description = "Desired count of backend tasks"
  type        = number
  default     = 1
}
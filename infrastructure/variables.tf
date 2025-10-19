variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "lab-terraform-ecs"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 80
}

variable "app_count" {
  description = "Number of application instances"
  type        = number
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate CPU units"
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate memory (MB)"
  type        = number
  default     = 512
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
    Workspace   = terraform.workspace
  }
  name_prefix = "${var.project}-${var.environment}"
}

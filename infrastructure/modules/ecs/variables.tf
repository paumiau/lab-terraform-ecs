variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "app_port" {
  description = "Port exposed by the docker image"
  type        = number
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units"
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate instance memory (MB)"
  type        = number
  default     = 512
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

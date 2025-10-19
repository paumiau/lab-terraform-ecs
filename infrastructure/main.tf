# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project            = var.project
  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security-groups"

  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
}

# ECR Module
module "ecr" {
  source = "./modules/ecr"

  project         = var.project
  environment     = var.environment
  repository_name = "app"
}

# ALB Module
module "alb" {
  source = "./modules/alb"

  project           = var.project
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  project            = var.project
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.ecs_tasks_security_group_id
  target_group_arn   = module.alb.target_group_arn
  ecr_repository_url = module.ecr.repository_url
  app_port           = var.app_port
  app_count          = var.app_count
  fargate_cpu        = var.fargate_cpu
  fargate_memory     = var.fargate_memory
  aws_region         = var.aws_region
}

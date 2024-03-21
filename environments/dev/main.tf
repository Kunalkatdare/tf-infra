terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Include VPC & Subnet module
module "vpc" {
  source = "../../modules/vpc"
  # Input variables for the VPC module
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

# ECS Cluster module
module "ecs-cluster" {
  source                    = "../../modules/ecs-cluster"
  ecs_cluster_name          = var.ecs_cluster_name
  capacity_providers        = var.capacity_providers
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
}

# Cloudwatch Log Group module

module "cw-log-group" {
  source                    = "../../modules/cloudwatch"
  cloudwatch_log_group_name = var.cloudwatch_log_group_name

}

# ECR module
module "ecr" {
  source               = "../../modules/ecr"
  ecr_repo_name        = var.ecr_repo_name
  scan_on_push         = var.scan_on_push
  image_tag_mutability = var.image_tag_mutability
  ecr_encryption       = var.ecr_encryption
}


module "security-groups" {
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "../../modules/iam"
}
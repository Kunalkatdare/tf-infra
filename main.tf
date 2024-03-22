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


module "init" {
  source = "./modules/init"
}

# VPC & Subnet module
module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

# Cloudwatch Log Group module
module "cw-log-group" {
  source                    = "./modules/cloudwatch"
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  aws_account_id            = module.init.aws_account_id
  aws_region                = module.init.aws_region
}


module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  db_secret_path     = var.container_secrets
  ecs_sg_id          = module.security-groups.ecs_sg_id
  rds_ingress_port   = var.rds_ingress_port
  rds_storage        = var.rds_storage
  db_identifier      = var.db_identifier
  storage_type       = var.storage_type
  engine             = var.engine
  engine_version     = var.engine_version
  db_name            = var.db_name
  rds_instance_class = var.rds_instance_class
}


module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"
}

module "ecs-cluster" {
  source                    = "./modules/ecs-cluster"
  ecs_cluster_name          = var.ecs_cluster_name
  capacity_providers        = var.capacity_providers
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
}

module "ecs-fargate" {
  source                      = "./modules/ecs-fargate"
  ecs_cluster_name            = module.ecs-cluster.cluster_name
  vpc_id                      = module.vpc.vpc_id
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  alb_sg_id                   = module.security-groups.alb_sg_id
  ecs_task_def_cpu            = var.ecs_task_def_cpu
  ecs_task_def_mem            = var.ecs_task_def_mem
  alb_target_group            = var.alb_target_group
  alb_listener_port           = var.alb_listener_port
  desired_count_tasks         = var.desired_count_tasks
  container_cpu               = var.container_cpu
  container_mem               = var.container_mem
  cloudwatch_log_group_name   = var.cloudwatch_log_group_name
  ecr_image_tag               = var.ecr_image_tag
  tier                        = var.tier
  container_secrets           = var.container_secrets
  project_name                = var.project_name
  branch_name                 = var.branch_name
  ecs_sg_id                   = module.security-groups.ecs_sg_id
}



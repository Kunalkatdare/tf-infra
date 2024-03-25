terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "qa/web-service/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  required_version = "~> 1.7.0"
}
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "my_vpc" {
  tags = {
    Name = "tf-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

module "init" {
  source = "../../modules/init"
}

module "cw-log-group" {
  source                    = "../../modules/cloudwatch"
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  aws_account_id            = module.init.aws_account_id
  aws_region                = module.init.aws_region
}

module "ecs-fargate" {
  source                    = "../../modules/ecs-fargate"
  ecs_cluster_name          = var.ecs_cluster_name
  vpc_id                    = data.aws_vpc.my_vpc.id
  ecs_task_def_cpu          = var.ecs_task_def_cpu
  ecs_task_def_mem          = var.ecs_task_def_mem
  alb_target_group          = var.alb_target_group
  desired_count_tasks       = var.desired_count_tasks
  container_cpu             = var.container_cpu
  container_mem             = var.container_mem
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  ecr_image_tag             = var.ecr_image_tag
  tier                      = var.tier
  container_secrets         = var.container_secrets
  project_name              = var.project_name
  branch_name               = var.branch_name
  container_port            = var.container_port
  host_port                 = var.host_port
  app_health_check_path     = var.app_health_check_path
}

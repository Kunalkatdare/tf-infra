terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "stage/ecs-cluster/terraform.tfstate"
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

module "ecs-cluster" {
  source                    = "../../modules/ecs-cluster"
  ecs_cluster_name          = var.ecs_cluster_name
  capacity_providers        = var.capacity_providers
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "qa/iam/terraform.tfstate"
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


module "iam" {
  source       = "../../modules/iam"
  tier         = var.tier
  project_name = var.project_name
  secret_path  = var.secret_path
}

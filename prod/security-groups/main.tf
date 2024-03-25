terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "prod/security-groups/terraform.tfstate"
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

module "security-groups" {
  source = "../../modules/security-groups"
  vpc_id = data.aws_vpc.my_vpc.id
  tier   = "prod"
}

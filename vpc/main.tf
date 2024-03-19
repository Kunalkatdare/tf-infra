
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr 
  tags = {
    Name = "vpc-tf" 
  }
}

module "subnets" {
  source         = "./subnets"
  vpc_id         = aws_vpc.main.id
  vpc_cidr = var.vpc_cidr
}



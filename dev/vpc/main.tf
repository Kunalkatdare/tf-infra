terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "dev/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true

  }
}
provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

}


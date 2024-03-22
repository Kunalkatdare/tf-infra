terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "dev/rds/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true

  }
}
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "my_vpc" {
  tags = {
    Name = "tf-vpc"
  }
}

module "rds_database" {
  source             = "../../modules/rds"
  db_name            = var.db_name
  db_identifier      = var.db_identifier
  vpc_id             = data.aws_vpc.my_vpc.id
  rds_ingress_port   = var.rds_ingress_port
  db_secret_path     = var.db_secret_path
  rds_storage        = var.rds_storage
  engine             = var.engine
  engine_version     = var.engine_version
  rds_instance_class = var.rds_instance_class
  storage_type       = var.storage_type
  tier               = var.tier
}


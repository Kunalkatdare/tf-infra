terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "qa/security-groups/terraform.tfstate"
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

module "security-groups" {
  source = "../../modules/security-groups"
  vpc_id = data.aws_vpc.my_vpc.id
  tier   = "qa"
}

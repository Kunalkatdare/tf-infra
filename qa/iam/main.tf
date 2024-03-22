terraform {
  backend "s3" {
    bucket         = "terraform-state-kk-devops"
    key            = "qa/iam/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true

  }
}
provider "aws" {
  region = "us-east-1"
}


module "iam" {
  source = "../../modules/iam"
  tier   = "qa"
}

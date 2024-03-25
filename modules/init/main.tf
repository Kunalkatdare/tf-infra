terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  required_version = "~> 1.7.0"
}

data "aws_caller_identity" "current" {}

# Data source to retrieve AWS region
data "aws_region" "current" {}


output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

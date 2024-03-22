data "aws_caller_identity" "current" {}

# Data source to retrieve AWS region
data "aws_region" "current" {}


output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

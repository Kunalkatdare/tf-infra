variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name for the VPC"
}

variable "aws_region" {
  description = "Name of the AWS Region"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group Name"
}

variable "capacity_providers" {
  description = "Capacity Providers for the ECS Cluster"
}

variable "ecr_repo_name" {
  description = "Name of the ECR Repo"
}
variable "image_tag_mutability" {
  description = "Mutability of the Image Tag"
}
variable "scan_on_push" {
  description = "Enable scan on push"
}
variable "ecr_encryption" {
  description = "ECR encryption type"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name for the VPC"
}

variable "aws_region" {
  description = "AWS Region"
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
variable "ecs_task_def_cpu" {
  description = "CPU for ECS task definition"
}
variable "ecs_task_def_mem" {
  description = "Memory for ECS task definition"
}
variable "alb_target_group" {
  description = "ALB Target Group"
}
variable "alb_listener_port" {
  description = "ALB listener port"
}
variable "desired_count_tasks" {
  description = "Desired count of Fargate tasks"
}
variable "container_cpu" {
  description = "CPU units for the container"
}
variable "tier" {
  description = "Environment"
}
variable "container_mem" {
  description = "Memory for the container"
}
variable "ecr_image_tag" {
  description = "Tag for the Docker image in Amazon ECR"
}

variable "container_secrets" {
  description = "Secrets to be passed to the container"
}

variable "project_name" {
  description = "Name of the project"
}

variable "branch_name" {
  description = "Name of the Git branch"
}

variable "rds_ingress_port" {
  description = "RDS Ingress port"
}

variable "rds_storage" {
  description = "RDS Storage"
}
variable "db_name" {
  description = "RDS DB Name"
}

variable "rds_instance_class" {
  description = "RDS Instance Class"
}
variable "db_identifier" {
  description = "RDS DB Name"
}
variable "storage_type" {
  description = "RDS Instance Class"
}
variable "engine" {
  description = "RDS DB Name"
}
variable "engine_version" {
  description = "RDS Instance Class"
}
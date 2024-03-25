variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "ecs_task_def_cpu" {
  description = "CPU for ECS task definition"
  type        = number
}
variable "ecs_task_def_mem" {
  description = "Memory for ECS task definition"
  type        = number
}
variable "alb_target_group" {
  description = "ALB Target Group"
  type        = number
}
variable "desired_count_tasks" {
  description = "Desired count of Fargate tasks"
  type        = number
}
variable "tier" {
  description = "Environment"
  type        = string
}
variable "cloudwatch_log_group_name" {
  description = "Cloudwatch log group name"
  type        = string
}
variable "ecr_image_tag" {
  description = "ECR image path"
  type        = string
}
variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
}
variable "container_mem" {
  description = "Memory for the container"
  type        = number
}
variable "container_secrets" {
  description = "Name of the secret stored in AWS Secrets Manager"
  type        = string
}
variable "branch_name" {
  description = "Name of the Git branch"
  type        = string
}
variable "project_name" {
  description = "Name of the project or application"
  type        = string
}
variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}
variable "host_port" {
  description = "Port exposed by the host"
  type        = number
}
variable "app_health_check_path" {
  description = "application health check path"
  type        = string
}

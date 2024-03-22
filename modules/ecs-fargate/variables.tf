variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
}
variable "vpc_id" {
  description = "VPC ID" 
}
variable "ecs_task_execution_role_arn" {
  description = "ecs_task_execution_role_arn"
}
variable "ecs_task_role_arn" {
  description = "ecs_task_role_arn"
}
variable "alb_sg_id" {
  description = "alb sg id"
}
variable "ecs_sg_id" {
  description = "ecs sg id"
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
variable "tier" {
  description = "Environment"
}
variable "cloudwatch_log_group_name" {
  description = "Cloudwatch log group name"
}
variable "ecr_image_tag" {
  description = "ECR image path"
}
variable "container_cpu" {
  description = "CPU units for the container"
}
variable "container_mem" {
  description = "Memory for the container"
}
variable "container_secrets" {
  description = "Name of the secret stored in AWS Secrets Manager"
}
variable "branch_name" {
  description = "Name of the Git branch"
}
variable "project_name" {
  description = "Name of the project or application"
}

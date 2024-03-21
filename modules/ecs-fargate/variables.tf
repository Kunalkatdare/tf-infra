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
variable "rds_sg_id" {
  description = "rds sg id"
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
variable "alb_name" {
  description = "Name of the ALB"
}
variable "desired_count_tasks" {
  description = "Desired count of Fargate tasks"
}
variable "ecr_image_tag" {
  description = "ECR image path"
}
variable "container_cpu" {

}
variable "container_mem" {
  
}
variable "container_secrets" {
  description = "Name of the secret stored in AWS Secrets Manager"
  default = "prod/node-express/db"
}
variable "branch_name" {
}
variable "project_name" {
}

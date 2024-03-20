variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group Name"
}

variable "capacity_providers" {
  description = "Capacity Providers for the ECS Cluster"
}
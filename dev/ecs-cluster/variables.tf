variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type = string
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group Name"
  type = string
}

variable "capacity_providers" {
  description = "Capacity Providers for the ECS Cluster"
  type = string
}

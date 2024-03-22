resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = var.cloudwatch_log_group_name

      }
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_provider" {
  cluster_name = var.ecs_cluster_name

  capacity_providers = [var.capacity_providers]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = var.capacity_providers
  }
}

output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

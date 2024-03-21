resource "aws_cloudwatch_log_group" "ecs_cluster_log_group" {
  name = var.cloudwatch_log_group_name
}

output "ecs_cluster_log_group" {
  value = aws_cloudwatch_log_group.ecs_cluster_log_group.name
}
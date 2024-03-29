ecs_cluster_name          = "stage-cluster"
cloudwatch_log_group_name = "ecs-stage-cluster-logs"
capacity_providers        = "FARGATE"
tier                      = "stage"
ecs_task_def_cpu          = 1024
ecs_task_def_mem          = 2048
alb_target_group          = 3000
alb_listener_port         = 80
desired_count_tasks       = 2
container_cpu             = 1024
container_mem             = 2048
project_name              = "proxima"
branch_name               = "master"
ecr_image_tag             = "682010357027.dkr.ecr.us-east-1.amazonaws.com/proxima-master:703ee79e4ed64c54c53df0732120eb42f3e273a8"
container_secrets         = "prod/node-express/db"
container_port            = 3000
host_port                 = 3000
app_health_check_path     = "/"

vpc_cidr                  = "10.0.0.0/16"
vpc_name                  = "tf-vpc"
aws_region                = "us-east-1"
ecs_cluster_name          = "qa-cluster"
cloudwatch_log_group_name = "ecs-qa-cluster-logs"
capacity_providers        = "FARGATE"
tier                      = "qa"
ecs_task_def_cpu          = 1024
ecs_task_def_mem          = 2048
alb_target_group          = 3000
alb_listener_port         = 80
desired_count_tasks       = 2
container_cpu             = 1024
container_mem             = 2048
project_name              = "proxima"
branch_name               = "master"
ecr_image_tag             = "682010357027.dkr.ecr.us-east-1.amazonaws.com/proxima-master"
container_secrets         = "prod/node-express/db"
db_identifier             = "postgres-instance"
rds_storage               = 20
storage_type              = "gp2"
engine                    = "postgres"
engine_version            = "16.1"
db_name                   = "mydb"
rds_instance_class            = "db.t3.micro"
rds_ingress_port          = 5432
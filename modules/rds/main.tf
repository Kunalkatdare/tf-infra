terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  required_version = "~> 1.7.0"
}


data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-*"]
  }
}

data "aws_security_group" "ecs_sg" {
  name = "ecs-security-group-${var.tier}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = data.aws_subnets.private_subnets.ids
  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance allowing inbound and outbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = var.rds_ingress_port
    to_port         = var.rds_ingress_port
    protocol        = "tcp"
    security_groups = [data.aws_security_group.ecs_sg.id]
  }

  egress {
    from_port       = var.rds_egress_port
    to_port         = var.rds_egress_port
    protocol        = "tcp"
    security_groups = [data.aws_security_group.ecs_sg.id]
  }
}

data "aws_secretsmanager_secret" "db_secret" {
  name = var.db_secret_path
}
data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_instance" "rds" {
  identifier                   = var.db_identifier
  allocated_storage            = var.rds_storage
  storage_type                 = var.storage_type
  engine                       = var.engine
  backup_retention_period      = 35
  engine_version               = var.engine_version
  db_name                      = var.db_name
  instance_class               = var.rds_instance_class
  username                     = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_USER"]
  password                     = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_PASS"]
  publicly_accessible          = false
  port                         = var.rds_ingress_port
  multi_az                     = true
  storage_encrypted            = true
  deletion_protection          = true
  performance_insights_enabled = true
  db_subnet_group_name         = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids       = [aws_security_group.rds_security_group.id]
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = aws_db_instance.rds.endpoint
}

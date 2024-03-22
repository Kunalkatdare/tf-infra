
data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-*"]
  }
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
  // Ingress rule allowing traffic from anywhere on port 5432 (Postgres)
  ingress {
    from_port       = var.rds_ingress_port
    to_port         = var.rds_ingress_port
    protocol        = "tcp"
    security_groups = [var.ecs_sg_id]
  }

  // Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RDS Security Group"
  }
}

data "aws_secretsmanager_secret" "db_secret" {
  name = var.db_secret_path
}
data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_instance" "rds" {
  identifier             = var.db_identifier
  allocated_storage      = var.rds_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  db_name                = var.db_name
  instance_class         = var.rds_instance_class
  username               = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_USER"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_PASS"]
  publicly_accessible    = false
  skip_final_snapshot    = false
  port                   = var.rds_ingress_port
  multi_az               = true
  storage_encrypted      = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]


  tags = {
    Name = "TF RDS database"
  }
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = aws_db_instance.rds.endpoint
}

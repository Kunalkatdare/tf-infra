
data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-*"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds_subnet_group"
  subnet_ids = data.aws_subnets.private_subnets.ids
  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance allowing inbound and outbound traffic"
  vpc_id = var.vpc_id
  // Ingress rule allowing traffic from anywhere on port 5432 (Postgres)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
      Name= "RDS Security Group"
    }
}

data "aws_secretsmanager_secret" "db_secret" {
  name = var.db_secret_path
}
data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_instance" "rds" {
  identifier            = "postgres-instance"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = "16.1"
  db_name = "mydb"
  instance_class        = "db.t3.micro"
  username              = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_USER"]
  password              = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["DB_PASS"]
  publicly_accessible   = false
  skip_final_snapshot   = true
  port = 5432
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  

  tags = {
    Name = "TF RDS database"
  }
}

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = aws_db_instance.rds.endpoint
}
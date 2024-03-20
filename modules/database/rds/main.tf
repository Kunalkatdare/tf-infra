
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

  // Ingress rule allowing traffic from anywhere on port 3306 (MySQL)
  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "aws_db_instance" "rds" {
  identifier            = "rds-instance"
  allocated_storage     = 5  # Adjust as needed
  storage_type          = "gp2"
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t3.micro"
  username              = "admin" # needs to be changed
  password              = "adminkunal" # needs to be changed
  publicly_accessible   = true  # Set to true if you want the database to be publicly accessible
  skip_final_snapshot   = true
  port = 3306
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
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  required_version = "~> 1.7.0"
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group-${var.tier}"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "rds_sg" {
  name = "rds-security-group"
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group-${var.tier}"
  description = "Security group for ECS tasks"

  vpc_id = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description     = "Allow all outbound traffic"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [data.aws_security_group.rds_sg.id]
  }
  egress {
    description     = "Allow all outbound traffic"
    from_port       = 0
    to_port         = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

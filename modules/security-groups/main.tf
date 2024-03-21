# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "ALB security group"
  description = "Security group for Application Load Balancer"
  
  vpc_id = "vpc-0ad783fd2a58f65d5"
  
  // Allow HTTP traffic from anywhere
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules for ALB
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic to anywhere
  }
  
}


# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "RDS security group"
  description = "Security group for RDS"
  
  vpc_id = "vpc-0ad783fd2a58f65d5"
  
  // Allow inbound traffic from Anywhere
  ingress {
    from_port        = 0
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "alb_sg_name" {
  value = aws_security_group.alb_sg.name
}

output "rds_sg_name" {
  value = aws_security_group.rds_sg.name
}
variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "db_secret_path" {
  description = "The path to the secret containing database credentials."
}

variable "ecs_sg_id" {
  description = "The ID of the security group for ECS."
}

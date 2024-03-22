variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "db_secret_path" {
  description = "The path to the secret containing database credentials."
}

variable "ecs_sg_id" {
  description = "The ID of the security group for ECS."
}
variable "rds_ingress_port" {
  description = "RDS Ingress port"
}

variable "rds_storage" {
  description = "RDS Storage"
}
variable "db_name" {
  description = "RDS DB Name"
}
variable "rds_instance_class" {
  description = "RDS Instance Class"
}

variable "db_identifier" {
  description = "RDS DB Name"
}
variable "storage_type" {
  description = "RDS Instance Class"
}
variable "engine" {
  description = "RDS DB Name"
}
variable "engine_version" {
  description = "RDS Instance Class"
}

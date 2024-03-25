variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "db_secret_path" {
  description = "The path to the secret containing database credentials."
  type        = string
}

variable "rds_ingress_port" {
  description = "RDS Ingress port"
  type        = number
}

variable "rds_egress_port" {
  description = "RDS Egress port"
  type        = number
}

variable "rds_storage" {
  description = "RDS Storage"
  type        = number
}
variable "db_name" {
  description = "RDS DB Name"
  type        = string
}
variable "rds_instance_class" {
  description = "RDS Instance Class"
  type        = string
}
variable "db_identifier" {
  description = "RDS Identifier"
  type        = string
}
variable "storage_type" {
  description = "RDS Storage Type"
  type        = string
}
variable "engine" {
  description = "RDS Engine"
  type        = string
}
variable "engine_version" {
  description = "RDS Engine Version"
  type        = string
}
variable "tier" {
  description = "Tier"
  type        = string
}

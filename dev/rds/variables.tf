variable "db_secret_path" {
  description = "The path to the secret containing database credentials."
}
variable "rds_ingress_port" {
  description = "RDS Ingress port"
}
variable "rds_egress_port" {
  description = "RDS Egress port"
}
variable "tier" {
  description = "Tier"
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
  description = "RDS Identifier"
}
variable "storage_type" {
  description = "RDS Storage Type"
}
variable "engine" {
  description = "RDS Engine"
}
variable "engine_version" {
  description = "RDS Engine Version"
}

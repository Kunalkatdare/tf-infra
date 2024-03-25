variable "tier" {
  description = "Tier"
  type        = string
}
variable "project_name" {
  type        = string
  description = "Project Name"
}
variable "secret_path" {
  type        = string
  description = "Path to container secrets in secrets manager"
}

variable "ecr_repo_name" {
  description = "Name of the ECR Repo"
}
variable "image_tag_mutability" {
  description = "Mutability of the Image Tag"
}
variable "scan_on_push" {
  description = "Enable scan on push"
}
variable "ecr_encryption" {
  description = "ECR encryption type"
}
resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  encryption_configuration {
    encryption_type = var.ecr_encryption
  }
}

output "ecr_repo_name" {
  value = aws_ecr_repository.ecr_repo.name
}
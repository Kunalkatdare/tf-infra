terraform {
  backend "s3" {
    bucket = "terraform-state-kk-devops"
    key = "tf-infra/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
    
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-kk-devops"
  force_destroy = false
  lifecycle {
    prevent_destroy = true
  }

}
resource "aws_s3_bucket_versioning" "tf_s3_versioning" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "lock_table" {

    name = "terraform-state-locking"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
    lifecycle {
    prevent_destroy = true
  }
  
}
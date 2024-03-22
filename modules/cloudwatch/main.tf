resource "aws_cloudwatch_log_group" "ecs_cluster_log_group" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = 180
  kms_key_id        = aws_kms_key.kms_key.arn
}

resource "aws_kms_key" "kms_key" {
  description = "KMS key for encrypting CloudWatch log groups"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "key-policy-for-cloudwatch-logs",
      "Statement" : [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.aws_account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
          "Sid" : "Allow CloudWatch Logs to use the key",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "logs.amazonaws.com"
          },
          "Action" : [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

output "ecs_cluster_log_group" {
  value = aws_cloudwatch_log_group.ecs_cluster_log_group.name
}

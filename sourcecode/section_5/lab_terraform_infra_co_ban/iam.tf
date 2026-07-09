##############################################
# iam.tf
# IAM role + policy least-privilege cho EC2:
# chỉ đọc/viết đúng S3 bucket và DynamoDB table vừa tạo — KHÔNG dùng "*"
##############################################

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name      = "${var.project_name}-ec2-role"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

# Least-privilege: chỉ cấp đúng action cần thiết, chỉ trên đúng ARN của
# bucket S3 và table DynamoDB được tạo trong bài lab này — không dùng
# wildcard "*" cho Resource và không gắn policy AdministratorAccess.
data "aws_iam_policy_document" "app_access" {
  statement {
    sid = "S3ReadWriteAppBucket"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.app_data.arn,
      "${aws_s3_bucket.app_data.arn}/*",
    ]
  }

  statement {
    sid = "DynamoDBReadWriteAppTable"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]
    resources = [
      aws_dynamodb_table.app_table.arn,
    ]
  }
}

resource "aws_iam_policy" "app_access" {
  name        = "${var.project_name}-app-access-policy"
  description = "Least-privilege: doc/viet dung bucket S3 va table DynamoDB cua bai lab nay"
  policy      = data.aws_iam_policy_document.app_access.json

  tags = {
    Name      = "${var.project_name}-app-access-policy"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_app_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.app_access.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

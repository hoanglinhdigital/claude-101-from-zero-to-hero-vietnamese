##############################################
# s3.tf
# 1 S3 bucket - versioning + block public access (best practice)
##############################################

resource "aws_s3_bucket" "app_data" {
  # random_id.suffix đảm bảo tên bucket unique toàn cầu (yêu cầu bắt buộc của S3)
  bucket = "${var.project_name}-data-${random_id.suffix.hex}"

  tags = {
    Name      = "${var.project_name}-data"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Best practice: chặn hoàn toàn public access ở mức bucket, bất kể
# bucket policy/ACL có vô tình cấu hình public hay không.
resource "aws_s3_bucket_public_access_block" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##############################################
# outputs.tf
##############################################

output "ec2_public_ip" {
  description = "Public IP của EC2 instance vừa tạo."
  value       = aws_instance.web.public_ip
}

output "s3_bucket_name" {
  description = "Tên S3 bucket vừa tạo."
  value       = aws_s3_bucket.app_data.bucket
}

output "dynamodb_table_name" {
  description = "Tên DynamoDB table vừa tạo."
  value       = aws_dynamodb_table.app_table.name
}

output "pipeline_name" {
  description = "Tên CodePipeline vừa tạo"
  value       = aws_codepipeline.this.name
}

output "codebuild_project_name" {
  description = "Tên CodeBuild project"
  value       = aws_codebuild_project.this.name
}

output "codedeploy_application_name" {
  description = "Tên CodeDeploy application"
  value       = aws_codedeploy_app.this.name
}

output "codedeploy_deployment_group_name" {
  description = "Tên CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.this.deployment_group_name
}

output "sns_topic_arn" {
  description = "ARN của SNS Topic nhận thông báo trạng thái pipeline"
  value       = aws_sns_topic.pipeline_alert.arn
}

output "artifact_bucket_name" {
  description = "Tên S3 bucket lưu artifact của pipeline"
  value       = aws_s3_bucket.artifact.bucket
}

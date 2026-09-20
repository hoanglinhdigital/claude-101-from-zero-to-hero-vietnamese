variable "project_name" {
  description = "Tên project, dùng làm tiền tố cho toàn bộ resource"
  type        = string
}

variable "environment" {
  description = "Environment: dev / stg / prd"
  type        = string
}

variable "github_owner" {
  description = "Tên tổ chức/user Github chứa repository ứng dụng"
  type        = string
}

variable "github_repo" {
  description = "Tên repository Github (không kèm owner)"
  type        = string
}

variable "github_branch" {
  description = "Branch sẽ trigger CodePipeline mỗi khi có commit mới"
  type        = string
  default     = "main"
}

variable "codestar_connection_arn" {
  description = "ARN của AWS CodeStar Connection (Github) đã được confirm thủ công trên AWS Console"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL của ECR repository chứa image ứng dụng (output từ module storage)"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Tên ECS Cluster (output từ module compute)"
  type        = string
}

variable "ecs_service_name" {
  description = "Tên ECS Service (output từ module compute)"
  type        = string
}

variable "alb_listener_prod_arn" {
  description = "ARN của ALB Listener production (port 443/80) dùng cho CodeDeploy Blue/Green"
  type        = string
}

variable "alb_listener_test_arn" {
  description = "ARN của ALB Listener test (port tạm, vd 8443/8080) dùng cho CodeDeploy Blue/Green"
  type        = string
}

variable "alb_target_group_blue_name" {
  description = "Tên Target Group Blue (đang phục vụ traffic production)"
  type        = string
}

variable "alb_target_group_green_name" {
  description = "Tên Target Group Green (nhận traffic mới trong lúc deploy)"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Tên S3 bucket lưu artifact trung gian giữa các stage của CodePipeline"
  type        = string
}

variable "alert_email" {
  description = "Email nhận thông báo trạng thái pipeline (SNS)"
  type        = string
}

variable "tags" {
  description = "Tag chuẩn áp dụng cho toàn bộ resource"
  type        = map(string)
  default     = {}
}

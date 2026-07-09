##############################################
# main.tf
# Entry point Terraform — Lab hạ tầng cơ bản AWS
# Section 5 - Claude cho DevOps & Cloud Engineer
##############################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Remote state (khuyến nghị cho môi trường team/production).
  # Bỏ comment và thay thông tin bucket/table bên dưới nếu muốn lưu state
  # tập trung trên S3 kèm khoá state bằng DynamoDB. Với bài lab cá nhân,
  # state cục bộ (terraform.tfstate) là đủ dùng.
  #
  # backend "s3" {
  #   bucket         = "ten-bucket-luu-state-cua-ban"
  #   key            = "lab-terraform-infra-co-ban/terraform.tfstate"
  #   region         = "ap-southeast-1"
  #   dynamodb_table = "terraform-state-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.region
}

# Dùng để sinh chuỗi ngẫu nhiên cho tên S3 bucket (yêu cầu unique toàn cầu)
resource "random_id" "suffix" {
  byte_length = 4
}

##############################################
# variables.tf
##############################################

variable "region" {
  description = "AWS region triển khai toàn bộ resource của bài lab."
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "Availability Zone dùng cho subnet public và EC2 instance."
  type        = string
  default     = "ap-southeast-1a"
}

variable "project_name" {
  description = "Tên project, dùng làm prefix cho tên resource và tag Project."
  type        = string
  default     = "claude101-devops-lab"
}

variable "vpc_cidr" {
  description = "CIDR block cho VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block cho subnet public trong VPC."
  type        = string
  default     = "10.20.1.0/24"
}

# KHÔNG đặt default = "0.0.0.0/0" cho biến này — bắt buộc học viên phải tự
# nhập CIDR public IP của mình để tránh vô tình mở port 22 (SSH) cho toàn
# bộ Internet theo mặc định. Xem hướng dẫn lấy IP tại chapter_5.html.
variable "allowed_ssh_cidr" {
  description = "CIDR IP được phép SSH vào EC2 (vd: \"203.0.113.10/32\"). Bắt buộc nhập, không có giá trị mặc định để tránh mở public ngoài ý muốn."
  type        = string

  validation {
    condition     = var.allowed_ssh_cidr != "0.0.0.0/0"
    error_message = "Không được dùng 0.0.0.0/0 cho allowed_ssh_cidr — chỉ cho phép SSH từ CIDR/IP cụ thể của bạn."
  }
}

variable "instance_type" {
  description = "Loại EC2 instance."
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Tên key pair EC2 có sẵn trên AWS để SSH vào instance. Để rỗng (\"\") nếu không cần SSH bằng key pair (vd chỉ dùng Session Manager)."
  type        = string
  default     = ""
}

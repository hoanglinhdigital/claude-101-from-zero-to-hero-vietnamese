##############################################
# ec2.tf
# 1 EC2 instance (t3.micro) trong subnet public
# Security group: port 22 chỉ từ allowed_ssh_cidr, port 80 public
##############################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Cho phep SSH tu allowed_ssh_cidr va HTTP public"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH - chi tu allowed_ssh_cidr, KHONG mo 0.0.0.0/0"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "HTTP public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Cho phep toan bo outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-web-sg"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = var.key_pair_name != "" ? var.key_pair_name : null

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>${var.project_name} - Claude 101 DevOps Lab</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name      = "${var.project_name}-web"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

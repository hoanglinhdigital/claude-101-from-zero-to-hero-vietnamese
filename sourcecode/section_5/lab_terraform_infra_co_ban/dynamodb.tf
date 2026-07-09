##############################################
# dynamodb.tf
# 1 DynamoDB table on-demand billing (PAY_PER_REQUEST)
##############################################

resource "aws_dynamodb_table" "app_table" {
  name         = "${var.project_name}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name      = "${var.project_name}-table"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# backend
resource "aws_cloudwatch_log_group" "backend" {
  kms_key_id        = null
  log_group_class   = "STANDARD"
  name              = "/ecs/task-${var.app_name}-backend"
  retention_in_days = 0
  skip_destroy      = false
  tags              = {}
  tags_all          = {}
}

# frontend
resource "aws_cloudwatch_log_group" "frontend" {
  kms_key_id        = null
  log_group_class   = "STANDARD"
  name              = "/ecs/task-${var.app_name}-frontend"
  retention_in_days = 0
  skip_destroy      = false
  tags              = {}
  tags_all          = {}
}

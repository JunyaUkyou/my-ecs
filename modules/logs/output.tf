output "backend_name" {
  value = aws_cloudwatch_log_group.backend.name
}

output "frontend_name" {
  value = aws_cloudwatch_log_group.frontend.name
}

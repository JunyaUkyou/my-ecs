output "backend_arn" {
  value = aws_lb_target_group.backend.arn
}

output "frontend_arn" {
  value = aws_lb_target_group.frontend.arn
}
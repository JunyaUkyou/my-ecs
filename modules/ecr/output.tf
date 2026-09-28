output "backend" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend" {
  value = aws_ecr_repository.frontend.repository_url
}
data "aws_acm_certificate" "main" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}
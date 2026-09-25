variable "app_name" { type = string }
variable "vpc_id" { type = string }
variable "alb_security_group_name" { type = string }
variable "cidr_block" { type = string }
variable "backend_port" { type = number }
variable "frontend_port" { type = number }

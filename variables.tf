variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのIPv4 CIDRブロック"
  type        = string
}

variable "subnet_cidrs" {
  description = "サブネットのCIDRリスト"
  type        = list(string)
}

variable "availability_zones" {
  description = "使用するAZのリスト"
  type        = list(string)
}

variable "internet_gateway_name" {
  description = "Internet Gateway Name"
  type        = string
}

variable "cidr_block" {
  description = "destination cidr block"
  type        = string
}

variable "app_port_list" {
  description = "0:Backend Port, 1:Frontend Port"
  type        = list(number)
}

variable "alb_security_group_name" {
  description = "ALB Security Group Name"
  type        = string
}

variable "health_check_list" {
  description = "0:Backend, 1:frontend"
  type        = list(string)
}

variable "task_revision" {
  description = "ESR Task Revision"
  type        = number
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

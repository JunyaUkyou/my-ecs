terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
provider "http" {}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source                      = "./modules/subnet"
  vpc_id                      = module.vpc.vpc_id
  availability_zones_public_a = var.availability_zones[0]
  availability_zones_public_c = var.availability_zones[1]
  cidr_block_public_a         = var.subnet_cidrs[0]
  cidr_block_public_c         = var.subnet_cidrs[1]
}

module "security_group" {
  source                  = "./modules/securityGroup"
  app_name                = var.app_name
  vpc_id                  = module.vpc.vpc_id
  alb_security_group_name = var.alb_security_group_name
  cidr_block              = var.cidr_block
  backend_port            = var.app_port_list[0]
  frontend_port           = var.app_port_list[1]
  private_ip_address      = local.my_ip_cidr
}

module "routes" {
  source                = "./modules/routes"
  vpc_id                = module.vpc.vpc_id
  internet_gateway_name = var.internet_gateway_name
  subnet_public_a_id    = module.subnet.public_a_id
  subnet_public_c_id    = module.subnet.public_c_id
  cidr_block            = var.cidr_block
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
}

module "logs" {
  source   = "./modules/logs"
  app_name = var.app_name
}

module "iam" {
  source = "./modules/iam"
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  app_name              = var.app_name
  backend_health_check  = var.health_check_list[0]
  frontend_health_check = var.health_check_list[1]
  backend_port          = var.app_port_list[0]
  frontend_port         = var.app_port_list[1]
  subnet_public_a_id    = module.subnet.public_a_id
  subnet_public_c_id    = module.subnet.public_c_id
  security_group_alb_id = module.security_group.alb_id
  certificate_arn       = module.acm.certificate_arn
}

module "ecr" {
  source   = "./modules/ecr"
  app_name = var.app_name
}

module "ecs" {
  source                     = "./modules/ecs"
  app_name                   = var.app_name
  backend_log                = module.logs.backend_name
  frontend_log               = module.logs.frontend_name
  subnet_public_a_id         = module.subnet.public_a_id
  subnet_public_c_id         = module.subnet.public_c_id
  security_group_ecs_task_id = module.security_group.ecs_task_id
  role_ecs_execution_arn     = module.iam.role_ecs_execution_arn
  ecr_repository_backend     = module.ecr.backend
  ecr_repository_frontend    = module.ecr.frontend
  backend_port               = var.app_port_list[0]
  frontend_port              = var.app_port_list[1]
  aws_region                 = var.aws_region
  lb_target_backend          = module.alb.backend_arn
  lb_target_frontend         = module.alb.frontend_arn

  depends_on = [
    module.alb
  ]
}

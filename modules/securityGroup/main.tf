
# ALB Security Group
resource "aws_security_group" "alb" {
  description = "rules for ALB to receive traffic from the internet"
  egress = [{
    cidr_blocks      = [var.cidr_block]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = [var.cidr_block]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = [var.cidr_block]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = var.alb_security_group_name
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = var.vpc_id
}

# ECS Security Group
resource "aws_security_group" "ecs_task" {
  description = "rules for ECS container of ${var.app_name}"
  egress = [{
    cidr_blocks      = [var.cidr_block]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = var.frontend_port
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb.id]
    self             = false
    to_port          = var.frontend_port
    }, {
    cidr_blocks      = []
    description      = ""
    from_port        = var.backend_port
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb.id]
    self             = false
    to_port          = var.backend_port
  }]
  name                   = "ecs-container-${var.app_name}"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = var.vpc_id
}

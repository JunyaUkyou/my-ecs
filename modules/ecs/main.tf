resource "aws_ecs_cluster" "main" {
  name     = "cluster-${var.app_name}"
  tags     = {}
  tags_all = {}
  configuration {
    execute_command_configuration {
      kms_key_id = null
      logging    = "DEFAULT"
    }
  }
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# aws_ecs_service
resource "aws_ecs_service" "main" {
  availability_zone_rebalancing      = "ENABLED"
  cluster                            = aws_ecs_cluster.main.arn
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 0
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  force_delete                       = null
  force_new_deployment               = null
  health_check_grace_period_seconds  = 300
  # iam_role                           = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type                        = "FARGATE"
  name                               = "service-${var.app_name}"
  platform_version                   = "1.4.0"
  propagate_tags                     = "NONE"
  scheduling_strategy                = "REPLICA"
  tags                               = {}
  tags_all                           = {}
  task_definition                    = aws_ecs_task_definition.main.arn
  triggers                           = {}
  wait_for_steady_state              = null
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  deployment_controller {
    type = "ECS"
  }
  load_balancer {
    container_name   = "backend"
    container_port   = var.backend_port
    elb_name         = null
    target_group_arn = var.lb_target_backend
  }
  load_balancer {
    container_name   = "frontend"
    container_port   = var.frontend_port
    elb_name         = null
    target_group_arn = var.lb_target_frontend
  }
  network_configuration {
    assign_public_ip = true
    security_groups  = [var.security_group_ecs_task_id]
    subnets          = [var.subnet_public_a_id, var.subnet_public_c_id]
  }
}

# Task definition
resource "aws_ecs_task_definition" "main" {
  container_definitions = jsonencode([{
    environment = []
    essential   = true
    image       = "${var.ecr_repository_backend}:latest"
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-create-group  = "true"
        awslogs-group         = var.backend_log
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
      secretOptions = []
    }
    mountPoints = []
    name        = "backend"
    portMappings = [{
      appProtocol   = "http"
      containerPort = var.backend_port
      hostPort      = var.backend_port
      name          = "backend-${var.backend_port}-tcp"
      protocol      = "tcp"
    }]
    systemControls = []
    volumesFrom    = []
    }, {
    environment = []
    essential   = true
    image       = "${var.ecr_repository_frontend}:latest"
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-create-group  = "true"
        awslogs-group         = var.frontend_log
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
      secretOptions = []
    }
    mountPoints = []
    name        = "frontend"
    portMappings = [{
      containerPort = var.frontend_port
      hostPort      = var.frontend_port
      name          = "frontend-${var.frontend_port}-tcp"
      protocol      = "tcp"
    }]
    systemControls = []
    volumesFrom    = []
  }])
  cpu                      = "1024"
  enable_fault_injection   = false
  execution_role_arn       = var.role_ecs_execution_arn
  family                   = "task-${var.app_name}"
  ipc_mode                 = null
  memory                   = "2048"
  network_mode             = "awsvpc"
  pid_mode                 = null
  requires_compatibilities = ["FARGATE"]
  skip_destroy             = null
  tags                     = {}
  tags_all                 = {}
  task_role_arn            = null
  track_latest             = false
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}

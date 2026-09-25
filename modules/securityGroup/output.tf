output "alb_id" {
    value = aws_security_group.alb.id
}

output "ecs_task_id" {
    value = aws_security_group.ecs_task.id
}
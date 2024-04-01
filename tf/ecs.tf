resource "aws_ecs_cluster" "app_cluster" {
  name = "timeoff-management-cluster"
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "timeoff-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<DEFINITION
[
  {
    "name": "timeoff",
    "image": "your_ecr_repo_url/timeoff-management:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "app_service" {
  name            = "timeoff-management-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.app_subnet_public_1.id, aws_subnet.app_subnet_public_2.id]
    assign_public_ip = true
    security_groups = [aws_security_group.app_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "timeoff"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.app_listener_https]
}

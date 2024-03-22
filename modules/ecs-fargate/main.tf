data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_security_group" "alb_sg" {
  name = "alb-security-group-${var.tier}"
}

data "aws_security_group" "ecs_sg" {
  name = "ecs-security-group-${var.tier}"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ECSTaskExecutionRole-${var.tier}"
}
data "aws_iam_role" "ecs_task_role" {
  name = "ECSTaskRole-${var.tier}"
}

data "aws_secretsmanager_secret" "by-name" {
  name = var.container_secrets
}

data "aws_acm_certificate" "acm_cert" {
  domain   = "www.wanderwyse.com"
  statuses = ["ISSUED"]
}

resource "aws_ecs_service" "ecs_node_app" {
  name            = "${var.project_name}-${var.branch_name}-${var.tier}-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.ecs_task_def.arn
  desired_count   = var.desired_count_tasks
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name   = "${var.project_name}-${var.branch_name}-${var.tier}-container"
    container_port   = var.alb_target_group
  }
}



resource "aws_ecs_task_definition" "ecs_task_def" {
  family                   = "${var.project_name}-${var.branch_name}-${var.tier}-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.branch_name}-${var.tier}-container",
      image     = var.ecr_image_tag,
      cpu       = var.container_cpu,
      memory    = var.container_mem,
      essential = true,
      portMappings = [
        {
          containerPort = var.container_port,
          hostPort      = var.host_port,
          protocol      = "tcp"
        }
      ],
      secrets = [
        {
          name      = "DB_USER",
          valueFrom = "${data.aws_secretsmanager_secret.by-name.arn}:DB_USER::"
        },
        {
          name      = "DB_PASS",
          valueFrom = "${data.aws_secretsmanager_secret.by-name.arn}:DB_PASS::"
        },
        {
          name      = "NODE_ENV",
          valueFrom = "${data.aws_secretsmanager_secret.by-name.arn}:NODE_ENV::"
        },
        {
          name      = "DATABASE_URL",
          valueFrom = "${data.aws_secretsmanager_secret.by-name.arn}:DATABASE_URL::"
        },
        {
          name      = "JWT_SECRET",
          valueFrom = "${data.aws_secretsmanager_secret.by-name.arn}:JWT_SECRET::"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "${var.cloudwatch_log_group_name}",
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
  cpu                = var.ecs_task_def_cpu
  memory             = var.ecs_task_def_mem
  execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = data.aws_iam_role.ecs_task_role.arn
}

resource "aws_alb" "alb" {
  name                       = "${var.project_name}-${var.branch_name}-${var.tier}"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [data.aws_security_group.alb_sg.id]
  subnets                    = data.aws_subnets.public.ids
  enable_deletion_protection = false

}


resource "aws_alb_listener" "alb_listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


resource "aws_alb_listener" "alb_listener_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.acm_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

}

resource "aws_lb_listener_rule" "alb_listener_https_rule" {
  listener_arn = aws_alb_listener.alb_listener_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.project_name}-${var.branch_name}-${var.tier}-tg"
  port        = var.alb_target_group
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = var.app_health_check_path
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2

  }
}

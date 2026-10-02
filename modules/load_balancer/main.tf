resource "aws_lb" "main" {
    name               = "alb-${terraform.workspace}"
    internal           = false
    load_balancer_type = "application"
    security_groups    = var.security_group_ids
    subnets            = var.subnet_ids
}


resource "aws_lb_target_group" "main" {
    name     = "tg-${terraform.workspace}"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.main.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }
}

resource "aws_lb_target_group_attachment" "main" {
    target_group_arn = aws_lb_target_group.main.arn
    target_id        = var.worker_instance_id
    port             = 80
}

output "load_balancer_arn" {
    value = aws_lb.main.arn
}

output "target_group_arn" {
    value = aws_lb_target_group.main.arn
}

output "alb_dns_name" {
    value = aws_lb.main.dns_name
}
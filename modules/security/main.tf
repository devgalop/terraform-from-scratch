resource "aws_security_group" "alb" {
    name        = "SB-ALB-${terraform.workspace}"
    description = "Security group for ALB"
    vpc_id      = var.vpc_id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "security_group_id" {
    value = aws_security_group.alb.id
}
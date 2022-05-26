# ALB for the web servers
resource "aws_lb" "public_alb" {
  name               = format("%s-alb", var.vpc_name)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_default_security_group.this.id]
  subnets            = aws_subnet.public.*.id
  enable_http2       = false
  enable_deletion_protection = true

  tags = {
    Name = format("%s-alb", var.vpc_name)
  }
}
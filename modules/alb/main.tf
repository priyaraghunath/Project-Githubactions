resource "aws_lb" "this" {
  name               = "${var.environment}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.environment}-web-alb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.environment}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  target_type = "instance"
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_attachment" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = element(var.instance_ids, count.index)
  port             = 80
}

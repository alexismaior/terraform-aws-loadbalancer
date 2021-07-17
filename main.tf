resource "aws_lb" "lb" {
  name            = "loadbalancer"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400

}

resource "aws_alb_target_group" "tg" {
  name     = "lb-tg-${substr(uuid(), 0, 3)}"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = var.lb_healty_threshold
    unhealthy_threshold = var.lb_unhealty_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}

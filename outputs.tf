output "lb_target_group_arn" {
  value = aws_alb_target_group.tg.arn
}

output "lb_endpoint" {
  value = aws_lb.lb.dns_name
}

output "alb_dns_name" {
  description = "DNS name of the ALB."
  value       = aws_lb.alb.dns_name
}

output "blue_asg_name" {
  description = "Name of the Blue ASG."
  value       = aws_autoscaling_group.blue.name
}

output "green_asg_name" {
  description = "Name of the Green ASG."
  value       = aws_autoscaling_group.green.name
}

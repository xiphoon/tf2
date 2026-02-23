output "load_balancer_dns" {
  description = "DNS name of the created Application Load Balancer."
  value       = aws_lb.app.dns_name
}

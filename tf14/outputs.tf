output "load_balancer_dns" {
  description = "DNS name of the application load balancer."
  value       = module.application.load_balancer_dns
}

output "vpc_id" {
  description = "VPC ID created by the network module."
  value       = module.network.vpc_id
}

output "ssh_sg_id" {
  description = "Security group ID for SSH access."
  value       = aws_security_group.ssh.id
}

output "public_http_sg_id" {
  description = "Security group ID for public HTTP (ALB)."
  value       = aws_security_group.public_http.id
}

output "private_http_sg_id" {
  description = "Security group ID for private HTTP (instances)."
  value       = aws_security_group.private_http.id
}

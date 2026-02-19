output "ssh_security_group_id" {
  description = "ID of the SSH security group"
  value       = aws_security_group.ssh.id
}

output "public_http_security_group_id" {
  description = "ID of the public HTTP security group"
  value       = aws_security_group.public_http.id
}

output "private_http_security_group_id" {
  description = "ID of the private HTTP security group"
  value       = aws_security_group.private_http.id
}

output "public_instance_primary_nic" {
  description = "Primary network interface id of the public instance"
  value       = data.aws_instance.public_instance.primary_network_interface_id
}

output "private_instance_primary_nic" {
  description = "Primary network interface id of the private instance"
  value       = data.aws_instance.private_instance.primary_network_interface_id
}

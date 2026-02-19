output "ssh_security_group_id" { description = "ID of SSH security group" value = aws_security_group.ssh.id }

output "public_http_security_group_id" { description = "ID of public HTTP security group" value = aws_security_group.public_http.id }

output "private_http_security_group_id" { description = "ID of private HTTP security group" value = aws_security_group.private_http.id }

output "public_instance_network_interface_id" { description = "Network interface ID of public instance" value = data.aws_instance.public_instance.network_interface_id }

output "private_instance_network_interface_id" { description = "Network interface ID of private instance" value = data.aws_instance.private_instance.network_interface_id }

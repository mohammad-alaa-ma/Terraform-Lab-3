output "security_group_id" {
  value       = aws_security_group.allow_http_ssh.id
  description = "My security group"
}

output "public_instance_ids" {
  value       = aws_instance.nginx-instance1[*].id
  description = "IDs of public NGINX instances"
}

output "private_instance_ids" {
  value       = aws_instance.apache-instance2[*].id
  description = "IDs of private Apache instances"
}

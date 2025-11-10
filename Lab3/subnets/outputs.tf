output "subnet_ids" {
  value       = aws_subnet.subnet[*].id
  description = "List of all created subnet IDs (public then private)"
}

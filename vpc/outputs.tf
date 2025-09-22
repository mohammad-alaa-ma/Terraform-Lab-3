output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "ID of the created VPC"
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "ID of the Internet Gateway attached to the VPC"
}

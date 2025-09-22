output "public_lb_dns" {
    value = aws_lb.loadbalancers[0].dns_name
    description = "DNS of the public Application Load Balancer"
}

output "private_lb_dns" {
    value = aws_lb.loadbalancers[1].dns_name
    description = "DNS of the private (internal) Application Load Balancer"
}
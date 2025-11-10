# Load Balancer Module

Creates one public and one private Application Load Balancer, listeners, target groups, and attachments.

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `listen_port` | number | `80` | Listener/target group port |
| `listen_protocol` | string | `"HTTP"` | Listener/target group protocol |
| `my_subnets_ids` | list(string) | n/a | Subnet IDs for ALBs |
| `my_sg` | string | n/a | Security group ID for ALBs |
| `my_vpc_id` | string | n/a | VPC ID for target groups |
| `Pub_instances` | list | n/a | Instance IDs for public TG |
| `Private_instances` | list | n/a | Instance IDs for private TG |

## Outputs

| Name | Description |
|------|-------------|
| `public_lb_dns` | DNS of the public ALB |
| `private_lb_dns` | DNS of the private (internal) ALB |



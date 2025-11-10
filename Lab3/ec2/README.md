# EC2 Module

Creates 2 public NGINX EC2 instances and 2 private Apache EC2 instances. Public NGINX proxies to the private ALB.

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `my_vpc_id` | string | n/a | VPC ID |
| `key_name` | string | `"lab"` | EC2 key pair name |
| `RT_cidr_block` | string | `"0.0.0.0/0"` | CIDR for rules |
| `my_subnets_ids` | list(string) | n/a | Subnet IDs (public, then private) |
| `sg-ports` | list(string) | `["80","22","0"]` | [HTTP, SSH, Egress-any] |
| `ec2_type` | string | `"t2.micro"` | Instance type |
| `ec2_ami_filter` | string | `"ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"` | AMI filter |
| `ec2_ami_owner` | string | `"099720109477"` | AMI owner (Canonical) |
| `private_lb_dns` | string | n/a | DNS of private ALB |

## Outputs

| Name | Description |
|------|-------------|
| `my_sg` | Security group ID |
| `Pub_instances_ids` | IDs of public NGINX instances |
| `Private_instances_ids` | IDs of private Apache instances |



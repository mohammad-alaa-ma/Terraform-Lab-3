# Subnets Module

Creates 2 public and 2 private subnets, NAT Gateway, route tables, and associations.

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `subnet_cidr_block` | list(string) | `"10.0.0.0/24","10.0.2.0/24","10.0.1.0/24","10.0.3.0/24"` | CIDRs for subnets |
| `az_names` | list(string) | `"us-east-1a","us-east-1b","us-east-1c","us-east-1d"` | AZs for subnets |
| `public_ip` | list(bool) | `true,false` | Map public IP on launch flags |
| `RT_cidr_block` | string | `"0.0.0.0/0"` | Default route CIDR |
| `my_vpc_id` | string | n/a | VPC ID |
| `my_igw_id` | string | n/a | Internet Gateway ID |

## Outputs

| Name | Description |
|------|-------------|
| `my_subnets` | List of created subnet IDs (public then private) |



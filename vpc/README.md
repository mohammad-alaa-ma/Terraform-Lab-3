# VPC Module

Creates the VPC and Internet Gateway.

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `vpc_cidr_block` | string | `"10.0.0.0/16"` | CIDR block for the VPC |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the created VPC |
| `igw_id` | ID of the Internet Gateway attached to the VPC |



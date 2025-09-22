# AWS Terraform Lab (VPC, Subnets, EC2, ALB)

This project provisions a simple AWS environment with a VPC, public/private subnets, two public NGINX instances, two private Apache instances, and both public and private Application Load Balancers. It is already working; this README only documents the layout and usage.

## Architecture (ASCII diagram)

```
                Internet
                   |
             [ Public ALB ]
                   |
          +--------+--------+
          |                 |
   [Public Subnet 1]  [Public Subnet 2]
          |                 |
      NGINX EC2         NGINX EC2
          \                 /
           \               /
            \             /
             \           /
              \         /
               \       /
                [ Private ALB ]  (internal)
                        |
                +-------+-------+
                |               |
        [Private Subnet 1] [Private Subnet 2]
                |               |
           Apache EC2       Apache EC2

VPC (10.0.0.0/16) with IGW for public subnets and NAT GW for private egress.
```

## Overview
- VPC with Internet Gateway
- 2 public subnets and 2 private subnets (NAT for private egress)
- Security group allowing HTTP(80) and SSH(22)
- 2 public EC2 (NGINX) instances
- 2 private EC2 (Apache) instances
- Public and private ALBs with listeners and target groups
- NGINX on public instances proxies to the private ALB

## Structure
- `main.tf`: Wires together the modules.
- `providers.tf`: AWS provider setup with shared config/credentials from variables.
- `variables.tf` + `values.auto.tfvars`: Region and AWS CLI file paths.
- `vpc/`: VPC and Internet Gateway.
- `subnets/`: Subnets, NAT Gateway, route tables and associations.
- `ec2/`: Security group, AMI lookup, public/private instances, provisioning.
- `load_balancer/`: Public and private ALBs, listeners, target groups, attachments.
- `install_apache.sh`: User data for private Apache instances.
- `all-ips.txt`: Populated at apply time by local-exec provisioners.

## High-level flow
1. `vpc` creates the VPC and IGW.
2. `subnets` creates 2 public and 2 private subnets, NAT GW in a public subnet, and route tables.
3. `ec2`:
   - Security group allows 80/22 inbound and all outbound.
   - 2 public NGINX instances (provisioning installs and starts NGINX; config proxies to the private ALB).
   - 2 private Apache instances installed via `install_apache.sh`.
4. `load_balancer` creates:
   - Public ALB targeting the public NGINX instances.
   - Private ALB targeting the private Apache instances.
5. NGINX proxies to the private ALB DNS, enabling public access to private backend.

## Inputs
Root variables:
- `vpc_region` (string) – set in `values.auto.tfvars`.
- `shared_config_file` (list(string)) – set in `values.auto.tfvars`.
- `shared_credentials_file` (list(string)) – set in `values.auto.tfvars`.

Module defaults:
- `vpc/vpc_cidr_block`: `10.0.0.0/16`
- `subnets/subnet_cidr_block`: `["10.0.0.0/24","10.0.2.0/24","10.0.1.0/24","10.0.3.0/24"]`
- `subnets/az_names`: `["us-east-1a","us-east-1b","us-east-1c","us-east-1d"]`
- `subnets/public_ip`: `[true,false]` (first 2 subnets public)
- `subnets/RT_cidr_block`: `"0.0.0.0/0"`
- `ec2/key_name`: `"lab"`
- `ec2/sg-ports`: `["80","22","0"]`
- `ec2/ec2_type`: `"t2.micro"`
- `ec2/ec2_ami_filter`: Ubuntu 20.04 AMD64
- `ec2/ec2_ami_owner`: `099720109477` (Canonical)
- `load_balancer/listen_port`: `80`
- `load_balancer/listen_protocol`: `HTTP`

## Outputs
- `load_balancer/public_lb_dns`: DNS name of the public ALB.
- `load_balancer/private_lb_dns`: DNS name of the private ALB (internal).
- `ec2/my_sg`: Security group ID.
- `ec2/Pub_instances_ids`: IDs of public instances.
- `ec2/Private_instances_ids`: IDs of private instances.
- `subnets/my_subnets`: List of subnet IDs.
- `vpc/vpc_id`, `vpc/igw_id`: Core network IDs.

## Prerequisites
- Terraform installed
- AWS CLI configured with a profile that matches `providers.tf` (`profile = "default"`) and the paths in `values.auto.tfvars`, e.g.:
  - `shared_config_file = ["/home/alaa/.aws/config"]`
  - `shared_credentials_file = ["/home/alaa/.aws/credentials"]`
- Ensure your key pair named `lab` exists in the selected region (or update `ec2/variables.tf` and PEM path used by the provisioner).

## Usage
```bash
terraform init
terraform plan
terraform apply
```

After apply:
- Check `all-ips.txt` for the collected IPs.
- Access the public ALB via the `public_lb_dns` output.

Destroy when done:
```bash
terraform destroy
```

## Notes
- This README is documentation-only; no functional changes to the Terraform configuration were made.
- Security group opens HTTP and SSH to `0.0.0.0/0`. Restrict for production use.
- NAT Gateway incurs cost; destroy when finished.

# Terraform AWS VPC Lab

This Terraform project sets up a basic AWS infrastructure consisting of a Virtual Private Cloud (VPC) with public and private subnets, an Internet Gateway, NAT Gateway, security groups, and two EC2 instances. One instance serves as a bastion host in the public subnet, and the other runs an Apache web server in the private subnet.

## Architecture Overview

The infrastructure includes:
- **VPC**: Main network with CIDR `10.0.0.0/16`
- **Public Subnet**: `10.0.0.0/24` with Internet Gateway access
- **Private Subnet**: `10.0.1.0/24` with NAT Gateway for outbound traffic
- **Internet Gateway**: Allows public subnet resources to access the internet
- **NAT Gateway**: Enables private subnet resources to initiate outbound connections
- **Security Groups**:
  - Public SG: Allows SSH (22) and HTTP (80) from anywhere
  - Private SG: Allows HTTP (80) from the public security group
- **EC2 Instances**:
  - Public EC2 (Bastion): Accessible via SSH, can be used to access private resources
  - Private EC2 (Apache): Runs Apache web server with a simple "Hello" page

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (version 1.0 or later)
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create VPC, subnets, EC2 instances, and related resources

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `region` | `us-east-1` | AWS region for resource deployment |
| `vpc_cidr` | `10.0.0.0/16` | CIDR block for the VPC |
| `public_subnet_cidr` | `10.0.0.0/24` | CIDR block for the public subnet |
| `private_subnet_cidr` | `10.0.1.0/24` | CIDR block for the private subnet |
| `instance_type` | `t2.micro` | EC2 instance type |
| `ami_id` | `ami-0b09ffb6d8b58ca91` | Amazon Linux 2 AMI ID (us-east-1) |

## Usage

1. **Clone or navigate to the project directory**

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review the execution plan**:
   ```bash
   terraform plan
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply
   ```

5. **Access the resources**:
   - Use the `public_instance_public_ip` output to SSH into the bastion host
   - The private Apache server is accessible via the bastion host

## Outputs

- `public_instance_public_ip`: Public IP address of the bastion EC2 instance
- `private_instance_private_ip`: Private IP address of the Apache EC2 instance

## Cleanup

To destroy all resources created by this configuration:

```bash
terraform destroy
```

## Notes

- This is a basic lab setup for learning Terraform and AWS networking concepts
- The private EC2 instance runs Apache with a simple HTML page
- Security groups are configured for demonstration purposes; adjust as needed for production use
- Ensure your AWS credentials have the necessary permissions before applying

## License

This project is for educational purposes as part of the ITI Terraform Lab.
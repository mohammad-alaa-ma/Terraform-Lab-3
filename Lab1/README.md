# Terraform AWS Lab 1

This Terraform project sets up a basic AWS infrastructure for a lab environment, including a VPC, public subnet, internet gateway, route table, security group, and an EC2 instance running Apache web server.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version 1.0 or later recommended)
- AWS CLI configured with appropriate credentials and default region set to `us-east-1`
- An AWS account with permissions to create VPC, EC2, and related resources

## Architecture Overview

The infrastructure consists of:

- **VPC**: A virtual private cloud with CIDR block `10.0.0.0/16`
- **Public Subnet**: A subnet within the VPC with CIDR block `10.0.0.0/24` in availability zone `us-east-1a`
- **Internet Gateway**: Allows internet access for resources in the public subnet
- **Route Table**: Routes traffic from the subnet to the internet gateway
- **Security Group**: Allows inbound HTTP (port 80) and SSH traffic, with all outbound traffic permitted
- **EC2 Instance**: A `t2.micro` instance running Amazon Linux 2 with Apache HTTP Server installed and configured

## Usage

1. Clone or navigate to this directory.

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. Confirm the apply by typing `yes` when prompted.

## Outputs

After successful deployment, Terraform will output:

- `ec2_ami`: The AMI ID of the created EC2 instance
- `ec2_public_ip`: The public IP address of the EC2 instance

You can access the Apache server by navigating to `http://<ec2_public_ip>` in your web browser.

## Cleanup

To destroy the created resources:

```bash
terraform destroy
```

Confirm the destruction by typing `yes` when prompted.

## Notes

- The EC2 instance uses user data to install and start Apache, displaying a simple "Hello from Terraform Apache EC2" message.
- All resources are tagged with descriptive names for easy identification.
- This is a basic lab setup and may not be suitable for production use without additional security and configuration considerations.

## Contributing

This is a lab project for educational purposes. Feel free to modify and experiment with the configuration.
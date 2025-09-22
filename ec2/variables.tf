###############################################
# Module Inputs
###############################################
variable "vpc_id_input" {
  type        = string
  description = "VPC ID where EC2 instances and SG are created"
}

variable "key_name" {
  type        = string
  description = "Name of the existing EC2 key pair"
  default     = "lab"
}

variable "default_route_cidr" {
  type        = string
  description = "CIDR for ingress/egress rules (use cautiously)"
  default     = "0.0.0.0/0" 
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs: first two public, next two private"
}

variable "sg_ports" {
  type    = list(string)
  description = "[HTTP, SSH, Egress-any] port numbers"
  default = ["80" , "22" , "0"]
}

variable "ec2_type" {
  type        = string
  description = "Instance type for all EC2 instances"
  default     = "t2.micro"
}

variable "ec2_ami_filter" {
  type        = string
  description = "AMI name filter for Ubuntu image"
  default     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}

variable "ec2_ami_owner" {
  type        = string
  description = "AMI owner (Canonical)"
  default     = "099720109477"
}

variable "private_lb_dns" {
  type        = string
  description = "DNS of private load balancer"
}

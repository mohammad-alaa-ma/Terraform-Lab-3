###############################################
# Module Inputs
###############################################
variable "subnet_cidr_block" {
    type        = list(string)
    description = "CIDR blocks for the 4 subnets (2 public + 2 private)"
    default     = ["10.0.0.0/24","10.0.2.0/24", "10.0.1.0/24","10.0.3.0/24"]
}

variable "az_names" {
    type        = list(string)
    description = "Availability Zones corresponding to the subnets order"
    default     = ["us-east-1a" , "us-east-1b", "us-east-1c" , "us-east-1d"]
}

variable "public_ip" {
    type        = list(bool)
    description = "Map public IP on launch flags: [true (public), false (private)]"
    default = [true, false]
}




variable "default_route_cidr" {
    type        = string
    description = "Route table default route CIDR"
    default     = "0.0.0.0/0" 
}

variable "vpc_id_input" {
  type        = string
  description = "VPC ID into which subnets and RTs are created"
}

variable "igw_id_input" {
  type        = string
  description = "Internet Gateway ID used in the public route table"
}


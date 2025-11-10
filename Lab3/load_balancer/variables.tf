###############################################
# Module Inputs
###############################################
variable "listen_port" {
    type = number
    description = "Listener and target group port"
    default = 80
}

variable "listen_protocol" {
    type = string
    description = "Listener and target group protocol"
    default = "HTTP"
}

variable "subnet_ids" {
    type = list(string)
    description = "Subnet IDs used for ALB placement (public & private)"
}


variable "security_group_id" {
    type = string
    description = "Security group ID applied to the ALBs"
}

variable "vpc_id_input" {
    type = string
    description = "VPC ID where target groups are created"
}

variable "public_instance_ids" {
    type = list
    description = "Instance IDs registered to the public target group"
}

variable "private_instance_ids" {
    type = list
    description = "Instance IDs registered to the private target group"
}
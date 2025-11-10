###############################################
# Root Module Wiring
# Purpose: Compose VPC, Subnets, EC2, and ALB modules
###############################################
module "vpc" {
    source = "./vpc"
}

module "subnets" {
    source = "./subnets"
    vpc_id_input = module.vpc.vpc_id
    igw_id_input = module.vpc.igw_id
}

module "my_lb" {
    source = "./load_balancer"
    subnet_ids = module.subnets.subnet_ids
    security_group_id = module.ec2_instances.security_group_id
    vpc_id_input = module.vpc.vpc_id
    public_instance_ids = module.ec2_instances.public_instance_ids
    private_instance_ids = module.ec2_instances.private_instance_ids
}

module "ec2_instances" {
    source = "./ec2"
    vpc_id_input = module.vpc.vpc_id
    subnet_ids = module.subnets.subnet_ids
    private_lb_dns = module.my_lb.private_lb_dns
}

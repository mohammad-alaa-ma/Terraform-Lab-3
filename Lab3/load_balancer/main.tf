###############################################
# Application Load Balancers, Listeners, and Target Groups
# Purpose: Public and Private ALBs with EC2 instance targets
###############################################
resource "aws_lb_target_group" "targetgroups" {
    count       = 2
    name        = count.index == 0 ? "Public-TG" : "Private-TG"
    port        = var.listen_port
    protocol    = var.listen_protocol
    vpc_id      = var.vpc_id_input # ------------------------- input here
    target_type = "instance"

    health_check {
        path = "/"
    }
}

resource "aws_lb" "loadbalancers" {
    count              = 2
    name               = count.index == 0 ? "Public-LB" : "Private-LB" 
    internal           = count.index == 0 ? false : true
    load_balancer_type = "application"
    subnets            = count.index == 0 ? [var.subnet_ids[count.index], var.subnet_ids[count.index+1]] : [var.subnet_ids[count.index+1], var.subnet_ids[count.index+2]]
    security_groups    = [var.security_group_id]
}

resource "aws_lb_listener" "listeners" {
    count = 2
    load_balancer_arn = aws_lb.loadbalancers[count.index].arn
    port              = var.listen_port
    protocol          = var.listen_protocol

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.targetgroups[count.index].arn
    }
}

resource "aws_lb_target_group_attachment" "pub_tg" {
    count = length(var.public_instance_ids)
    target_group_arn = aws_lb_target_group.targetgroups[0].arn
    target_id        = var.public_instance_ids[count.index]
    port             = var.listen_port
}

resource "aws_lb_target_group_attachment" "private_tg" {
    count = length(var.private_instance_ids)
    target_group_arn = aws_lb_target_group.targetgroups[1].arn
    target_id        = var.private_instance_ids[count.index]
    port             = var.listen_port
}
#-----Sec Groups-----
module "ssh_from_internet" {
    source = "../modules/security_groups"

    name        = "ssh_from_internet"
    description = "open port 22 to the internet"

    vpc_id     = module.dns_net.vpc_id

    # inbound rules
    ingress_to_port   = 22
    ingress_from_port = 22
    ingress_protocol  = "tcp"
    ingress_cidr      = var.cidr_1
    
    # outbound rules, from_port to_port are 0(all) by default
    egress_protocol   = "-1" 
    egress_cidr       = "0.0.0.0/0"
}

module "ssh_local" {
    source = "../modules/security_groups"

    name = "ssh_local"
    description = "allow ssh inside subnet"

    vpc_id     = module.dns_net.vpc_id

    ingress_to_port   = 22
    ingress_from_port = 22
    ingress_protocol  = "tcp"
    ingress_cidr      = module.dns_net.subnet_cidr
    
    egress_protocol   = "-1" 
    egress_cidr       = "0.0.0.0/0"
}

module "icmp" {
    source = "../modules/security_groups"
    
    name = "icmp"
    description = "allow icmp(ping) traffic"

    vpc_id     = module.dns_net.vpc_id

    ingress_to_port   = -1
    ingress_from_port = -1
    ingress_protocol  = "icmp"
    ingress_cidr      = "0.0.0.0/0"
    
    egress_to_port    = -1
    egress_from_port  = -1
    egress_protocol   = "icmp" 
    egress_cidr       = "0.0.0.0/0"
}
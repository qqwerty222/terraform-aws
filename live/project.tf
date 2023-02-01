#-----Network-----
module "dns_net" {
    source = "../modules/network"
    availability_zone = var.availability_zone

    vpc_name = "dns_vpc"
    vpc_cidr = "10.0.0.0/16"

    subnet_name = "dns_subnet"
    subnet_cidr = "10.0.1.0/24"
}

#-----EC2-----
module "dns_stack" {
    source = "../modules/ec2"

    list = ["user", "nginx"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.10", "10.0.1.11"]

    key_name          = module.key_pair.key_name
}

module "ansible" {
    source = "../modules/ec2"

    list = ["ansible"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    associate_public_ip_address = true
    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.15"]
   
    key_name = "ansible"
    sec_group_ids = [module.ssh_from_internet.ssh_id]
}

#-----Security-----
module "key_pair" {
    source = "../modules/aws_key_pair"
    
    key_name   = "test-stack"
    public_key = var.public_ssh_test
}

module "ssh_from_internet" {
    source = "../modules/security_groups"

    name        = "ssh_from_internet"
    description = "open port 22 to the internet"

    vpc_id     = module.dns_net.vpc_id

    ingress_to_port   = 22
    ingress_from_port = 22
    ingress_protocol  = "tcp"
    ingress_cidr      = var.cidr_1
    
    egress_to_port    = 0
    egress_from_port  = 0
    egress_protocol   = "-1" 
    egress_cidr       = var.cidr_1

}
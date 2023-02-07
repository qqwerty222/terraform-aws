#-----EC2-----
# each module use same resource but with different parameters 
module "ansible-master" {
    # path to resource
    source = "../modules/ec2"

    # you can specify multiple_names/ip_addresses and ec2 for each will be created
    list = ["ansible"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    associate_public_ip_address = true
    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.10"]
    enable_dns_arec   = true
    
    key_name = "ansible"
    sec_group_ids = [module.icmp.sec_group_id, module.ssh_from_internet.sec_group_id]

    # config for user_data, will be runned while instance init
    provision_conf = data.cloudinit_config.ansible_master.rendered

    # parameters used by connection{} and provision{} in ec2 resource
    private_key_to_provision = file("~/.ssh/ansible.pem")
    source_local = "/home/bohdan/.ssh/dns_stack"
    dest_remote = "/home/ubuntu/.ssh/dns_stack"
}

module "dns" {
    source = "../modules/ec2"

    list = ["dns"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.15"]

    # from output ../modules/aws_key_pair/outputs|key_name
    key_name          = module.dns_key_pair.key_name
    sec_group_ids     = [module.icmp.sec_group_id, module.ssh_local.sec_group_id]
}

module "webserver" {
    source = "../modules/ec2"

    list = ["webserver"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.20"]


    key_name          = module.dns_key_pair.key_name
    sec_group_ids     = [module.icmp.sec_group_id, module.ssh_local.sec_group_id]
}

module "user" {
    source = "../modules/ec2"

    list = ["user", "user2"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.25", "10.0.1.30"]

    key_name          = module.dns_key_pair.key_name
    sec_group_ids     = [module.icmp.sec_group_id, module.ssh_local.sec_group_id]
}



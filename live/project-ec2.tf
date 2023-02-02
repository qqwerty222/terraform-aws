
#-----EC2-----
module "dns_stack" {
    source = "../modules/ec2"

    list = ["user", "nginx"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.10", "10.0.1.11"]

    key_name          = module.dns_key_pair.key_name
    sec_group_ids = [module.icmp.sec_group_id, module.ssh_local.sec_group_id]
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
    enable_dns_arec   = true
    
    # provision_conf = data.template_file.ansible_master.rendered
    user_to_provision = "ubuntu"
    private_key_to_provision = file("~/.ssh/ansible.pem")
    commands = [
                "sudo apt update", 
                "sudo apt install python3-pip ansible -y",
                "python3-pip install ansible"
                ]

    key_name = "ansible"
    sec_group_ids = [module.icmp.sec_group_id, module.ssh_from_internet.sec_group_id]
}

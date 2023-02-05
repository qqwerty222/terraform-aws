#-----EC2-----
module "ansible-master" {
    source = "../modules/ec2"

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

    provision_conf = data.cloudinit_config.ansible_master.rendered

    # user_to_provision = "ubuntu"
    # private_key_to_provision = file("~/.ssh/ansible.pem")
    # commands = [
    #             "sudo apt-get -qq update && sudo apt-get -qq install python3 python3-pip ansible -y"
    #             # "pip -q install ansible"
    #             # "echo '${file("~/.ssh/dns_stack")}' >> ~/.ssh/dns_stack" # find way to make it secure
    #             # "git clone ${ dns_stack_playbook }",
    #             # "set WEBSERVER_IP=${ self.public_ip[0] }",
    #             # "ansible-playbook dns-ngx-ansible/playbook.yml"
    #             ]
}

module "dns" {
    source = "../modules/ec2"

    list = ["dns"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.15"]

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

    list = ["user"]
    instance_type     = "t2.micro"
    ami               = "ami-03e08697c325f02ab"

    availability_zone = var.availability_zone
    subnet_id         = module.dns_net.subnet_id
    private_ip        = ["10.0.1.25"]

    key_name          = module.dns_key_pair.key_name
    sec_group_ids     = [module.icmp.sec_group_id, module.ssh_local.sec_group_id]
}



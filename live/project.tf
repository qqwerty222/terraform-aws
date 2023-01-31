module "dns_net" {
    source = "../modules/network"
    availability_zone = var.availability_zone

    vpc_name = "dns_vpc"
    vpc_cidr = "10.0.0.0/16"

    subnet_name = "dns_subnet"
    subnet_cidr = "10.0.1.0/24"
}

module "sec_group" {
    source = "../modules/security_groups"

    vpc_id = module.dns_net.vpc_id
    cidr_block = module.dns_net.subnet_cidr
}

module "test_stack" {
    source = "../modules/test_stack"
    availability_zone   = var.availability_zone
    
    subnet_id           = module.dns_net.subnet_id

    dns_sec_groups = module.sec_group.dns_id
    ngx_sec_groups = module.sec_group.wserver_id
    user_sec_groups = module.sec_group.ssh_id

    key_name = module.key_pair.key_name
}

module "key_pair" {
    source = "../modules/aws_key_pair"
    
    key_name   = "test-stack"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5BtbKmfgXmOis4HLXX1Ue3wogne7z5wckHXgkbCvg6wUk6UWqBB3WQX6UCEKOUW4VbUGEJsT9YTwRDGSg1EAIPCCelAR2T39XS9+uuM3Hi1ygb5V+KNvSdEMUuLVcV7lPJlMAL6y997WBzQaYAlAAUEPQkC2RoPR0/O5HNbZffXOJZSFacXLc/Q3I8DyVOiz32P7AEfyHW387SU8aekmF4oV9L4B3gnyufQ4qY4VAnLlpej8akp1FGSJTjsN3OXx2ONQkr69ZzxQhzvW1qkJF5aLo2SfEzRt+sJRHwy0d3JCFvP/I/TTrOQJTGzGwMFVp4gcIVpPYR3NVBRfI2Oy0oqbRzYvsqe3EanCFR3Feq26pGS+PlVR9TSgHFO6rrW6KjvpUijdH5ynMPVmzc2K5w0kc578ho2FcgK/R02OVc/WrXn9JY4i3Erw4ZvmHqFeNtGEG6USCNE4Xcl7rz/O4Ba+NRt8QcuEkvtn1wyX4UHpLrANpiRSoOK701n3MxzM= bohdan@PF2FXPPG"
}
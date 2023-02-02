#-----Network-----
module "dns_net" {
    source = "../modules/network"
    availability_zone = var.availability_zone

    vpc_name = "dns_vpc"
    vpc_cidr = "10.0.0.0/16"

    subnet_name = "dns_subnet"
    subnet_cidr = "10.0.1.0/24"
}
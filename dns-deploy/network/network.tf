module "network" {
    source = "../../modules/network"
    availability_zone   = data.consul_keys.aws_config.var.availability_zone

    vpc_name            = data.consul_keys.network.var.vpc_name
    vpc_cidr            = data.consul_keys.network.var.vpc_cidr

    subnet_name         = data.consul_keys.network.var.subnet_name
    subnet_cidr         = data.consul_keys.network.var.subnet_cidr
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/network/subnet/id",   value = module.network.subnet_id },
        { path = "${var.PROJECT_NAME}/network/vpc/id",      value = module.network.vpc_id },
    ]
}

data "consul_keys" "network" {
    key { 
        name = "vpc_name" 
        path = "${var.PROJECT_NAME}/network/vpc/name"
    }

    key { 
        name = "vpc_cidr" 
        path = "${var.PROJECT_NAME}/network/vpc/cidr"
    }

    key {
        name = "subnet_name"
        path = "${var.PROJECT_NAME}/network/subnet/name"
    }

    key {
        name = "subnet_cidr"
        path = "${var.PROJECT_NAME}/network/subnet/cidr"
    }
}

data "consul_keys" "aws_config" {
    key {
        name = "availability_zone"
        path = "${var.PROJECT_NAME}/aws_config/availability_zone"
    }

    key {
        name = "region"
        path = "${var.PROJECT_NAME}/aws_config/region"
    }
}
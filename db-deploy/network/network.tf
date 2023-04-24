module "vpc" {
    source      = "../../modules/network_2/vpc"

    name        = "vpc-db"
    cidr        = data.consul_keys.vpc.var.cidr
}

module "subnets" {
    source      = "../../modules/network_2/subnet"

    vpc_id      = module.vpc.id
    subnets     = jsondecode(data.consul_keys.subnet.var.config)
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/network/vpc/id",          value = module.vpc.id },
        { path = "${var.PROJECT_NAME}/network/subnet/ids",      value = jsonencode(module.subnets.ids) },
    ]
}

data "consul_keys" "vpc" {
    key { 
        name = "id" 
        path = "${var.PROJECT_NAME}/network/vpc/id"
    }

    key { 
        name = "cidr" 
        path = "${var.PROJECT_NAME}/network/vpc/cidr"
    }
}

data "consul_keys" "subnet" {
    key {
        name = "config"
        path = "${var.PROJECT_NAME}/network/subnet/config"
    }
}


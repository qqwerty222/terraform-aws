module "vpc" {
    source      = "../../modules/network_2/vpc"

    name        = jsondecode(data.consul_keys.vpc.var.config)[0]["name"]
    cidr        = jsondecode(data.consul_keys.vpc.var.config)[0]["cidr"]
}

module "db-subnets" {
    source      = "../../modules/network_2/subnet"

    vpc_id      = module.vpc.id
    subnets     = jsondecode(data.consul_keys.subnets.var.db-subnets)
}

module "proxy-subnets" {
    source      = "../../modules/network_2/subnet"

    vpc_id      = module.vpc.id
    subnets     = jsondecode(data.consul_keys.subnets.var.proxy-subnets)
}

module "website-subnets" {
    source      = "../../modules/network_2/subnet"

    vpc_id      = module.vpc.id
    subnets     = jsondecode(data.consul_keys.subnets.var.website-subnets)
}

data "consul_keys" "vpc" {
    key { 
        name = "config" 
        path = "${var.PROJECT_NAME}/network/vpc/config"
    }
}

data "consul_keys" "subnets" {
    key {
        name = "db-subnets"
        path = "${var.PROJECT_NAME}/network/subnets/db-subnets/config"
    }
    key {
        name = "proxy-subnets"
        path = "${var.PROJECT_NAME}/network/subnets/proxy-subnets/config"
    }
    key {
        name = "website-subnets"
        path = "${var.PROJECT_NAME}/network/subnets/website-subnets/config"
    }
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/network/vpc/id",                          value = module.vpc.id },
        { path = "${var.PROJECT_NAME}/network/subnets/db-subnets/ids",          value = jsonencode(module.db-subnets.ids) },
        { path = "${var.PROJECT_NAME}/network/subnets/proxy-subnets/ids",       value = jsonencode(module.proxy-subnets.ids) },
        { path = "${var.PROJECT_NAME}/network/subnets/website-subnets/ids",     value = jsonencode(module.website-subnets.ids) },
    ]
}


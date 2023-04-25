module "subnet_group" {
    source = "../../modules/rds/subnet_group"
    
    name                        = data.consul_keys.subnet_group.var.name
    subnet_ids                  = jsondecode(data.consul_keys.network.var.subnets)
}

module "instance" {
    source = "../../modules/rds/instance"

    name                        = jsondecode(data.consul_keys.db1.var.config)["name"]
    allocated_storage           = jsondecode(data.consul_keys.db1.var.config)["allocated_storage"]
    engine                      = jsondecode(data.consul_keys.db1.var.config)["engine"]
    engine_version              = jsondecode(data.consul_keys.db1.var.config)["engine_version"]
    instance_class              = jsondecode(data.consul_keys.db1.var.config)["instance_class"]

    username                    = var.ADMIN_USERNAME
    password                    = var.ADMIN_PASSWORD

    subnet_group                = module.subnet_group.id
    multi_az                    = jsondecode(data.consul_keys.db1.var.config)["multi_az"]
    security_groups             = [ data.consul_keys.security_groups.var.db_sec_group ]

    depends_on = [
      module.subnet_group
    ]
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/rds/instance/id",             value = module.instance.id },
        { path = "${var.PROJECT_NAME}/rds/instance/address",        value = module.instance.address },
        { path = "${var.PROJECT_NAME}/rds/instance/multi_az",       value = module.instance.multi_az },
        { path = "${var.PROJECT_NAME}/rds/instance/av_zone",        value = module.instance.av_zone },
    ]
}

data "consul_keys" "subnet_group" {
    key { 
        name = "name" 
        path = "${var.PROJECT_NAME}/rds/subnet_group/name"
    }
}

data "consul_keys" "network" {
    key { 
        name = "subnets" 
        path = "${var.PROJECT_NAME}/network/subnet/ids"
    }
}

data "consul_keys" "security_groups" {
    key { 
        name = "db_sec_group" 
        path = "${var.PROJECT_NAME}/security_groups/db_sec_group/id"
    }
}

data "consul_keys" "db1" {
    key { 
        name = "config" 
        path = "${var.PROJECT_NAME}/rds/instance/db1/config"
    }
}


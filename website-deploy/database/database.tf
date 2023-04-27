module "subnet_group" {
    source = "../../modules/rds/subnet_group"
    
    name                        = data.consul_keys.subnet_group.var.name
    subnet_ids                  = jsondecode(data.consul_keys.network.var.db-subnets)
}

module "instance" {
    source = "../../modules/rds/instance"

    name                        = jsondecode(data.consul_keys.db.var.config)["name"]
    allocated_storage           = jsondecode(data.consul_keys.db.var.config)["allocated_storage"]
    engine                      = jsondecode(data.consul_keys.db.var.config)["engine"]
    engine_version              = jsondecode(data.consul_keys.db.var.config)["engine_version"]
    instance_class              = jsondecode(data.consul_keys.db.var.config)["instance_class"]

    username                    = var.ADMIN_USERNAME
    password                    = var.ADMIN_PASSWORD

    subnet_group                = module.subnet_group.id
    multi_az                    = jsondecode(data.consul_keys.db.var.config)["multi_az"]
    security_groups             = [ data.consul_keys.security_groups.var.db]

    depends_on = [
      module.subnet_group
    ]
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/db/instance/id",             value = module.instance.id },
        { path = "${var.PROJECT_NAME}/db/instance/address",        value = module.instance.address },
        { path = "${var.PROJECT_NAME}/db/instance/av_zone",        value = module.instance.av_zone },
    ]
}

data "consul_keys" "db" {
    key { 
        name = "config" 
        path = "${var.PROJECT_NAME}/db/instance/config"
    }
}

data "consul_keys" "subnet_group" {
    key { 
        name = "name" 
        path = "${var.PROJECT_NAME}/db/subnet_group/name"
    }
}

data "consul_keys" "network" {
    key { 
        name = "db-subnets" 
        path = "${var.PROJECT_NAME}/network/subnets/db-subnets/ids"
    }
}

data "consul_keys" "security_groups" {
    key { 
        name = "db" 
        path = "${var.PROJECT_NAME}/security_groups/db/id"
    }
}




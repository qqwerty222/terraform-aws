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
    
    username                    = jsondecode(data.consul_keys.db1.var.config)["username"]
    password                    = var.ADMIN_PASSWORD

    subnet_group                = module.subnet_group.id
    depends_on = [
      module.subnet_group
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

data "consul_keys" "db1" {
    key { 
        name = "config" 
        path = "${var.PROJECT_NAME}/rds/instance/db1/config"
    }
}


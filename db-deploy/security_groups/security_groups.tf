
module "bastion_sec_group" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.bastion_sec_group)
}


module "db_sec_group" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.db_sec_group)
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists  = [
        { path  = "${var.PROJECT_NAME}/security_groups/bastion_sec_group/id",       value = module.bastion_sec_group.id},
        { path  = "${var.PROJECT_NAME}/security_groups/db_sec_group/id",            value = module.db_sec_group.id},
    ]
}

data "consul_keys" "vpc" {
    key { 
        name    = "id" 
        path    = "${var.PROJECT_NAME}/network/vpc/id"
    }
}

data "consul_keys" "security_groups" {
    key {
        name    = "db_sec_group"
        path    = "${var.PROJECT_NAME}/security_groups/db_sec_group/config"
    }

    key {
        name    = "bastion_sec_group"
        path    = "${var.PROJECT_NAME}/security_groups/bastion_sec_group/config"
    }
}




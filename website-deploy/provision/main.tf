module "ansible" {
    source = "../../modules/security_groups"

    vpc_id      = data.consul_keys.vpc.var.id
    parameters  = jsondecode(data.consul_keys.security_groups.var.ansible)
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists  = [
        { path  = "${var.PROJECT_NAME}/security_groups/ansible/id",  value = module.ansible.id},
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
        name    = "ansible"
        path    = "${var.PROJECT_NAME}/security_groups/ansible/config"
    }
}




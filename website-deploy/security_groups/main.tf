module "proxy" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.proxy)
}

module "website" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.website)
}

module "db" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.db)
}

module "datadog" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.datadog)
}


module "ssh" {
    source = "../../modules/security_groups"

    vpc_id                  = data.consul_keys.vpc.var.id
    parameters              = jsondecode(data.consul_keys.security_groups.var.ssh)
}


module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists  = [
        { path  = "${var.PROJECT_NAME}/security_groups/db/id",                  value = module.db.id},
        { path  = "${var.PROJECT_NAME}/security_groups/proxy/id",               value = module.proxy.id},
        { path  = "${var.PROJECT_NAME}/security_groups/website/id",             value = module.website.id},
        { path  = "${var.PROJECT_NAME}/security_groups/datadog/id",                 value = module.datadog.id},

        { path  = "${var.PROJECT_NAME}/security_groups/ssh/id",                 value = module.ssh.id},
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
        name    = "proxy"
        path    = "${var.PROJECT_NAME}/security_groups/proxy/config"
    }

    key {
        name    = "website"
        path    = "${var.PROJECT_NAME}/security_groups/website/config"
    }
    key {
        name    = "db"
        path    = "${var.PROJECT_NAME}/security_groups/db/config"
    }
    key {
        name    = "datadog"
        path    = "${var.PROJECT_NAME}/security_groups/datadog/config"
    }

    key {
        name    = "ssh"
        path    = "${var.PROJECT_NAME}/security_groups/ssh/config"
    }
}




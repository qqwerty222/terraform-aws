module "dns" {
    source = "../../modules/ec2"

    number              = data.consul_keys.dns.var.number
    instance_type       = data.consul_keys.dns.var.instance_type
    ami                 = data.consul_keys.dns.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = [
        data.consul_keys.security_groups.var.ssh_from_internet_id,
        data.consul_keys.security_groups.var.ping
    ]

    instance_name       = "dns"
}

module "webservers" {
    source = "../../modules/ec2"

    number              = data.consul_keys.webservers.var.number
    instance_type       = data.consul_keys.webservers.var.instance_type
    ami                 = data.consul_keys.webservers.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = [
        data.consul_keys.security_groups.var.ssh_from_internet_id,
        data.consul_keys.security_groups.var.ping_id
    ]

    instance_name       = "webserver"
}

module "users" {
    source = "../../modules/ec2"

    number              = data.consul_keys.users.var.number
    instance_type       = data.consul_keys.users.var.instance_type
    ami                 = data.consul_keys.users.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = [
        data.consul_keys.security_groups.var.ssh_from_internet_id,
        data.consul_keys.security_groups.var.ping
    ]

    instance_name       = "user"
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ec2/dns/ids",                  value = module.dns.ids_json},
        { path = "dns-deploy/ec2/dns/private_ips",          value = module.dns.private_ips_json},

        { path = "dns-deploy/ec2/webservers/ids",           value = module.webservers.ids_json},
        { path = "dns-deploy/ec2/webservers/private_ips",   value = module.webservers.private_ips_json},

        { path = "dns-deploy/ec2/users/ids",                value = module.users.ids_json},
        { path = "dns-deploy/ec2/users/private_ips",        value = module.users.private_ips_json},
    ]
}

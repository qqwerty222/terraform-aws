module "dns" {
    source = "../../modules/ec2"

    number              = data.consul_keys.ec2.var.number
    instance_type       = data.consul_keys.ec2.var.instance_type
    ami                 = data.consul_keys.ec2.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = jsondecode(data.consul_keys.security_groups.var.ids)
}

module "webservers" {
    source = "../../modules/ec2"

    number              = data.consul_keys.ec2.var.number
    instance_type       = data.consul_keys.ec2.var.instance_type
    ami                 = data.consul_keys.ec2.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = jsondecode(data.consul_keys.security_groups.var.ids)
}

module "user" {
    source = "../../modules/ec2"

    number              = data.consul_keys.ec2.var.number
    instance_type       = data.consul_keys.ec2.var.instance_type
    ami                 = data.consul_keys.ec2.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = jsondecode(data.consul_keys.security_groups.var.ids)
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ec2/dns/ids", value = module.dns.ids_json},
        { path = "dns-deploy/ec2/dns/private_ips", value = module.dns.private_ips_json},

        { path = "dns-deploy/ec2/webservers/ids", value = module.webservers.ids_json},
        { path = "dns-deploy/ec2/webservers/private_ips", value = module.webservers.private_ips_json},

        { path = "dns-deploy/ec2/users/ids", value = module.users.ids_json},
        { path = "dns-deploy/ec2/users/private_ips", value = module.users.private_ips_json},
    ]
}

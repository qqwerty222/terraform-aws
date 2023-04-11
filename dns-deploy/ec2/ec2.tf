module "dns" {
    source = "../../modules/ec2"

    number              = data.consul_keys.dns.var.number
    instance_type       = data.consul_keys.dns.var.instance_type
    ami                 = data.consul_keys.dns.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id
    public_ip           = data.consul_keys.dns.var.public_ip

    key_name            = data.consul_keys.ssh_key.var.id

    sec_group_ids       = [
        data.consul_keys.security_groups.var.ssh_from_internet_id,
        data.consul_keys.security_groups.var.ping_id
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
    public_ip           = data.consul_keys.webservers.var.public_ip

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
    public_ip           = data.consul_keys.users.var.public_ip

    key_name            = data.consul_keys.ssh_key.var.id

    sec_group_ids       = [
        data.consul_keys.security_groups.var.ssh_from_internet_id,
        data.consul_keys.security_groups.var.ping_id
    ]

    instance_name       = "user"
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ec2/dns/ids",                  value = jsonencode(module.dns.ids)},
        { path = "dns-deploy/ec2/dns/private_ips",          value = jsonencode(module.dns.private_ips)},
        { path = "dns-deploy/ec2/dns/public_ips",    value = jsonencode(module.dns.public_ips)},

        { path = "dns-deploy/ec2/webservers/ids",           value = jsonencode(module.webservers.ids)},
        { path = "dns-deploy/ec2/webservers/private_ips",   value = jsonencode(module.webservers.private_ips)},
        { path = "dns-deploy/ec2/webservers/public_ips",    value = jsonencode(module.webservers.public_ips)},

        { path = "dns-deploy/ec2/users/ids",                value = jsonencode(module.users.ids)},
        { path = "dns-deploy/ec2/users/private_ips",        value = jsonencode(module.users.private_ips)},
        { path = "dns-deploy/ec2/users/public_ips",    value = jsonencode(module.users.public_ips)},
    ]
}

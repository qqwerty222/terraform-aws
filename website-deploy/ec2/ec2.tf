
module "proxy" {
    source = "../../modules/ec2"

    instance_name       = jsondecode(data.consul_keys.ec2_config.var.proxy)["instance_name"]

    number              = jsondecode(data.consul_keys.ec2_config.var.proxy)["number"]
    instance_type       = jsondecode(data.consul_keys.ec2_config.var.proxy)["instance_type"]
    ami                 = jsondecode(data.consul_keys.ec2_config.var.proxy)["ami"]

    availability_zone   = jsondecode(data.consul_keys.ec2_config.var.proxy)["av_zone"]
    public_ip           = jsondecode(data.consul_keys.ec2_config.var.proxy)["public_ip"]
    subnet_id           = jsondecode(data.consul_keys.network.var.proxy-subnets)[0]

    key_name            = jsondecode(data.consul_keys.ec2_config.var.proxy)["key_name"]

    sec_group_ids       = [ data.consul_keys.security_groups.var.proxy ]
}

module "website" {
    source = "../../modules/ec2"

    instance_name       = jsondecode(data.consul_keys.ec2_config.var.website)["instance_name"]

    number              = jsondecode(data.consul_keys.ec2_config.var.website)["number"]
    instance_type       = jsondecode(data.consul_keys.ec2_config.var.website)["instance_type"]
    ami                 = jsondecode(data.consul_keys.ec2_config.var.website)["ami"]

    availability_zone   = jsondecode(data.consul_keys.ec2_config.var.website)["av_zone"]
    public_ip           = jsondecode(data.consul_keys.ec2_config.var.website)["public_ip"]
    subnet_id           = jsondecode(data.consul_keys.network.var.website-subnets)[0]

    key_name            = jsondecode(data.consul_keys.ec2_config.var.website)["key_name"]

    sec_group_ids       = [ data.consul_keys.security_groups.var.website ]
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/ec2/proxy/ids",                   value = jsonencode(module.proxy.ids) },
        { path = "${var.PROJECT_NAME}/ec2/private_ips",                 value = jsonencode(module.proxy.private_ips) },
        { path = "${var.PROJECT_NAME}/ec2/public_ips",                  value = jsonencode(module.proxy.public_ips) },

        { path = "${var.PROJECT_NAME}/ec2/ids",                         value = jsonencode(module.website.ids) },
        { path = "${var.PROJECT_NAME}/ec2/private_ips",                 value = jsonencode(module.website.private_ips) },
        { path = "${var.PROJECT_NAME}/ec2/public_ips",                  value = jsonencode(module.website.public_ips) },
        
        { path = "${var.PROJECT_NAME}/ec2/hosts",                       value = templatefile("./templates/hosts.tpl",{
                                                                            proxy_ips       = module.proxy.public_ips,
                                                                            website_ips     = module.website.public_ips,                   
                                                                        })},
    ]
}

data "consul_keys" "network" {
    key { 
        name = "proxy-subnets" 
        path = "${var.PROJECT_NAME}/network/subnets/proxy-subnets/ids"
    }
    key { 
        name = "website-subnets" 
        path = "${var.PROJECT_NAME}/network/subnets/website-subnets/ids"
    }
}

data "consul_keys" "ec2_config" {
    key { 
        name = "proxy" 
        path = "${var.PROJECT_NAME}/ec2/proxy/config"
    }
    key { 
        name = "website" 
        path = "${var.PROJECT_NAME}/ec2/website/config"
    }
}

data "consul_keys" "security_groups" {
    key { 
        name = "proxy" 
        path = "${var.PROJECT_NAME}/security_groups/proxy/id"
    }
    key { 
        name = "website" 
        path = "${var.PROJECT_NAME}/security_groups/website/id"
    }
}
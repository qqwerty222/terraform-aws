
module "proxy" {
    source = "../../modules/ec2"

    instance_name       = jsondecode(data.consul_keys.ec2_config.var.proxy)["instance_name"]

    number              = jsondecode(data.consul_keys.ec2_config.var.proxy)["number"]
    instance_type       = jsondecode(data.consul_keys.ec2_config.var.proxy)["instance_type"]
    ami                 = jsondecode(data.consul_keys.ec2_config.var.proxy)["ami"]

    availability_zone   = jsondecode(data.consul_keys.ec2_config.var.proxy)["av_zone"]
    public_ip           = jsondecode(data.consul_keys.ec2_config.var.proxy)["public_ip"]
    subnet_id           = jsondecode(data.consul_keys.network.var.proxy-subnets)[0]

    key_name            = data.consul_keys.ssh_keys.var.proxy

    sec_group_ids       = [ 
        data.consul_keys.security_groups.var.datadog,
        data.consul_keys.security_groups.var.proxy,
        
        data.consul_keys.security_groups.var.ssh,  
    ]

    user_data           = data.cloudinit_config.proxy.rendered   
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

    key_name            = data.consul_keys.ssh_keys.var.website

    sec_group_ids       = [ 
        data.consul_keys.security_groups.var.datadog,
        data.consul_keys.security_groups.var.website, 

        data.consul_keys.security_groups.var.ansible,
        data.consul_keys.security_groups.var.ssh, 
    ]

    user_data           = data.cloudinit_config.website.rendered
}

module "db" {
    source = "../../modules/ec2"

    instance_name       = jsondecode(data.consul_keys.ec2_config.var.db)["instance_name"]

    number              = jsondecode(data.consul_keys.ec2_config.var.db)["number"]
    instance_type       = jsondecode(data.consul_keys.ec2_config.var.db)["instance_type"]
    ami                 = jsondecode(data.consul_keys.ec2_config.var.db)["ami"]

    availability_zone   = jsondecode(data.consul_keys.ec2_config.var.db)["av_zone"]
    public_ip           = jsondecode(data.consul_keys.ec2_config.var.db)["public_ip"]
    subnet_id           = jsondecode(data.consul_keys.network.var.db-subnets)[0]

    key_name            = data.consul_keys.ssh_keys.var.proxy

    sec_group_ids       = [ 
        data.consul_keys.security_groups.var.datadog,
        data.consul_keys.security_groups.var.website,  

        data.consul_keys.security_groups.var.ssh, 
    ]

    user_data           = data.cloudinit_config.db.rendered
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/ec2/proxy/ids",                       value = jsonencode(module.proxy.ids) },
        { path = "${var.PROJECT_NAME}/ec2/proxy/private_ips",               value = jsonencode(module.proxy.private_ips) },
        { path = "${var.PROJECT_NAME}/ec2/proxy/public_ips",                value = jsonencode(module.proxy.public_ips) },

        { path = "${var.PROJECT_NAME}/ec2/website/ids",                     value = jsonencode(module.website.ids) },
        { path = "${var.PROJECT_NAME}/ec2/website/private_ips",             value = jsonencode(module.website.private_ips) },
        { path = "${var.PROJECT_NAME}/ec2/website/public_ips",              value = jsonencode(module.website.public_ips) },
        
        { path = "${var.PROJECT_NAME}/ec2/db/ids",                          value = jsonencode(module.website.ids) },
        { path = "${var.PROJECT_NAME}/ec2/db/private_ips",                  value = jsonencode(module.website.private_ips) },
        { path = "${var.PROJECT_NAME}/ec2/db/public_ips",                   value = jsonencode(module.website.public_ips) },

        { path = "${var.PROJECT_NAME}/ec2/hosts",                           value = templatefile("./templates/hosts.tpl",{
                                                                                proxy_ips       = module.proxy.public_ips,
                                                                                website_ips     = module.website.public_ips,                   
                                                                            })},
    ]
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
    key { 
        name = "db" 
        path = "${var.PROJECT_NAME}/ec2/db/config"
    }
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
    key { 
        name = "db-subnets" 
        path = "${var.PROJECT_NAME}/network/subnets/db-subnets/ids"
    }
}

data "consul_keys" "ssh_keys" {
    key { 
        name = "proxy" 
        path = "${var.PROJECT_NAME}/network/ssh_keys/proxy_key/id"
    }
    key { 
        name = "website" 
        path = "${var.PROJECT_NAME}/network/ssh_keys/proxy_key/id"
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
    key { 
        name = "datadog" 
        path = "${var.PROJECT_NAME}/security_groups/datadog/id"
    }

    key { 
        name = "ansible" 
        path = "${var.PROJECT_NAME}/security_groups/ssh/id"
    }    

    key { 
        name = "ssh" 
        path = "${var.PROJECT_NAME}/security_groups/ansible/id"
    }
}


data "cloudinit_config" "proxy" {
    part {
        content_type = "text/cloud-config"

        content = templatefile("./templates/proxy_cloudinit.tpl", {
            dd_api_key              = var.DD_API_KEY
            dd_host_tags            = "service:proxy, region:${var.AWS_REGION}, availability_zone:${jsondecode(data.consul_keys.ec2_config.var.proxy)["av_zone"]}"
        })
    }
}

data "cloudinit_config" "website" {
    part {
        content_type = "text/cloud-config"

        content = templatefile("./templates/website_cloudinit.tpl", {
            dd_api_key      = var.DD_API_KEY
            dd_host_tags    = "service:website, region:${var.AWS_REGION}, availability_zone:${jsondecode(data.consul_keys.ec2_config.var.website)["av_zone"]}"
        })
    }
}

data "cloudinit_config" "db" {
    part {
        content_type = "text/cloud-config"

        content = templatefile("./templates/db_cloudinit.tpl", {
            dd_api_key      = var.DD_API_KEY
            dd_host_tags    = "service:db, region:${var.AWS_REGION}, availability_zone:${jsondecode(data.consul_keys.ec2_config.var.db)["av_zone"]}"
        })
    }
}
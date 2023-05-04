module "ec2_bastion" {
    source = "../../modules/ec2"

    number              = jsondecode(data.consul_keys.ec2_bastion.var.config)["number"]
    instance_type       = jsondecode(data.consul_keys.ec2_bastion.var.config)["instance_type"]
    ami                 = jsondecode(data.consul_keys.ec2_bastion.var.config)["ami"]

    availability_zone   = jsondecode(data.consul_keys.ec2_bastion.var.config)["av_zone"]
    subnet_id           = jsondecode(data.consul_keys.network.var.subnets)[0]
    public_ip           = jsondecode(data.consul_keys.ec2_bastion.var.config)["public_ip"]

    key_name            = jsondecode(data.consul_keys.ec2_bastion.var.config)["key_name"]

    sec_group_ids       = [ data.consul_keys.security_groups.var.bastion_sec_group ]

    user_data           = data.cloudinit_config.ec2_bastion.rendered 

    instance_name       = jsondecode(data.consul_keys.ec2_bastion.var.config)["instance_name"]
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/ec2-bastion/id",                  value = module.ec2_bastion.ids[0] },
        { path = "${var.PROJECT_NAME}/ec2-bastion/private_ip",          value = module.ec2_bastion.private_ips[0] },
        { path = "${var.PROJECT_NAME}/ec2-bastion/public_ip",           value = module.ec2_bastion.public_ips[0] },
    ]
}

data "consul_keys" "network" {
    key { 
        name = "subnets" 
        path = "${var.PROJECT_NAME}/network/subnet/ids"
    }
}

data "consul_keys" "ec2_bastion" {
    key { 
        name = "config" 
        path = "${var.PROJECT_NAME}/ec2-bastion/config"
    }
}

data "consul_keys" "security_groups" {
    key { 
        name = "bastion_sec_group" 
        path = "${var.PROJECT_NAME}/security_groups/bastion_sec_group/id"
    }
}

data "cloudinit_config" "ec2_bastion" {
    part {
        content_type = "text/cloud-config"
        content = templatefile("./templates/proxy_cloudinit.tpl", {})
    }
}
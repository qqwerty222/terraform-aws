module "ec2" {
    source = "../../modules/ec2"

    number              = data.consul_keys.ec2.var.number
    instance_type       = data.consul_keys.ec2.var.instance_type
    ami                 = data.consul_keys.ec2.var.ami

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    subnet_id           = data.consul_keys.network.var.subnet_id

    key_name            = data.consul_keys.ssh_key.var.id
    sec_group_ids       = jsondecode(data.consul_keys.security_groups.var.ids)
}

data "consul_keys" "ec2" {
    key {
        name = "number"
        path = "${var.PROJECT_NAME}/ec2/number"
    }

    key { 
        name = "ami" 
        path = "${var.PROJECT_NAME}/ec2/ami"
    }

    key {
        name = "instance_type" 
        path = "${var.PROJECT_NAME}/ec2/instance_type"
    }
}

data "consul_keys" "network" {
    key {
        name = "subnet_id"
        path = "${var.PROJECT_NAME}/network/subnet/id"
    }
}

data "consul_keys" "ssh_key" {
    key {
        name = "id"
        path = "${var.PROJECT_NAME}/ssh_keys/common/id"
    }
}

data "consul_keys" "security_groups" {
    key {
        name = "ids"
        path = "${var.PROJECT_NAME}/security_groups/ids"
    }
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ec2/ids", value = module.ec2.ids_json},
        { path = "dns-deploy/ec2/ids", value = module.ec2.private_ips_json},
    ]
}

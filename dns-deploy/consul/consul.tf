module "consul_push_sec_groups" {
    source = "../modules/consul_kv"
    
    push_lists = [
        { path = "dns-deploy/security_groups/common/ids", value = module.security_groups_common.ids_string },
    ]
}

module "consul_push_network" {
    source = "../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/network/subnet/id", value = module.network.subnet_id },
        { path = "dns-deploy/network/vpc/id", value = module.network.vpc_id },
    ]
}

module "consul_push_ec2" {
    source = "../modules/consul_kv"

    push_list = [
        {path = "dns-deploy/ec2/"}
    ]
}

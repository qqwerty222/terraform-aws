
module "ssh_key" {
    source  = "../../modules/aws_key_pair"
    
    key = {
        key_name    = "common", 
        pub_key     = data.consul_keys.ssh_key.var.common
    }   
}

data "consul_keys" "ssh_key" {
    key { 
        name = "common" 
        path = "${var.PROJECT_NAME}/ssh_keys/common/pub_key"
    }
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ssh_keys/common/id", value = module.ssh_key.id },
    ]
}
module "ssh_key" {
    source  = "../../modules/aws_key_pair"
    
    key = {
        key_name    = "common", 
        pub_key     = data.aws_secretsmanager_secret.var.pub_key
    }   
}

data "aws_secretsmanager_secret" "pub_key" {
    name = "ssh_dns_pub"
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "dns-deploy/ssh_keys/common/id", value = module.ssh_key.id },
    ]
}
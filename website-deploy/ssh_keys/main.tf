module "proxy_key" {
    source  = "../../modules/aws_key_pair"
    
    key = {
        key_name    = "proxy_key", 
        pub_key     = var.PROXY_PUBLIC_KEY
    }   
}

module "website_key" {
    source  = "../../modules/aws_key_pair"
    
    key = {
        key_name    = "website_key", 
        pub_key     = var.WEBSITE_PUBLIC_KEY
    }   
}

module "consul_push" {
    source = "../../modules/consul_kv"

    push_lists = [
        { path = "${var.PROJECT_NAME}/ssh_keys/db_key/id", value = module.db_key.id },
        { path = "${var.PROJECT_NAME}/ssh_keys/proxy_key/id", value = module.proxy_key.id },
        { path = "${var.PROJECT_NAME}/ssh_keys/website_key/id", value = module.website_key.id },
    ]
}
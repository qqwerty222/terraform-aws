
module "common_key" {
    source = "../modules/aws_key_pair"
    
    key_name   = "common"
    # public_key are sensitive variable, value of which stored in secret.auto.tfvars
    public_key = var.public_ssh_test
}



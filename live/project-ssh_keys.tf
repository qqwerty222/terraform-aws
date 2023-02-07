
#-----SSH Key-----
module "dns_key_pair" {
    source = "../modules/aws_key_pair"
    
    key_name   = "dns_stack"
    # public_key are sensitive variable, value of what stored in secret.auto.tfvars
    public_key = var.public_ssh_test
}



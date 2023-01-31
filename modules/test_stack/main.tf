resource "aws_instance" "dns" {
    ami               = var.ami
    instance_type     = "t2.micro"
    availability_zone = var.availability_zone
    
    subnet_id  = var.subnet_id
    private_ip = var.dns_private_ip
    
    key_name   = var.key_name
    vpc_security_group_ids = [var.dns_sec_groups]    
    tags = {
        Name = "dns"
    }
} 

resource "aws_instance" "ngx" {
    ami               = var.ami
    instance_type     = "t2.micro"
    availability_zone = var.availability_zone
    
    subnet_id  = var.subnet_id
    private_ip = var.ngx_private_ip
    
    key_name   = var.key_name
    vpc_security_group_ids = [var.ngx_sec_groups]

    tags = {
        Name = "ngx"
    }
} 

resource "aws_instance" "user" {
    ami               = var.ami
    instance_type     = "t2.micro"
    availability_zone = var.availability_zone
    
    subnet_id  = var.subnet_id
    private_ip = var.user_private_ip

    key_name   = var.key_name
    vpc_security_group_ids = [var.user_sec_groups]

    tags = {
        Name = "user"
    }
} 




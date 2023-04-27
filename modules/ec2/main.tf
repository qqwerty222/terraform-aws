resource "aws_instance" "common" {
    count = var.number

    ami                         = var.ami
    instance_type               = var.instance_type
    availability_zone           = var.availability_zone

    subnet_id                   = var.subnet_id
    associate_public_ip_address = var.public_ip
    
    key_name                    = var.key_name  
    vpc_security_group_ids      = var.sec_group_ids
    
    user_data                   = var.user_data

    tags = {
        Name = "${var.instance_name}-${count.index + 1}"
    }
}








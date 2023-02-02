resource "aws_instance" "ec2" {
    count = length(var.list)

    ami           = var.ami
    instance_type = var.instance_type
    availability_zone = var.availability_zone

    subnet_id  = var.subnet_id
    private_ip = element(var.private_ip, count.index)
    associate_public_ip_address = var.associate_public_ip_address
    private_dns_name_options {
        enable_resource_name_dns_a_record = var.enable_dns_arec
    }

    key_name   = var.key_name  
    vpc_security_group_ids = var.sec_group_ids
    
    user_data = var.provision_conf

    provisioner "remote-exec" {
        inline = var.commands
    }
    connection {
        type = "ssh"
        user = var.user_to_provision
        host = self.public_ip
        private_key = var.private_key_to_provision
    }

    tags = {
        Name = element(var.list, count.index)
    }
}







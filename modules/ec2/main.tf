resource "aws_instance" "ec2" {
    # count is invoke resources multiple times, it depends from number of names in list
    count = length(var.list)

    ami           = var.ami
    instance_type = var.instance_type
    availability_zone = var.availability_zone

    subnet_id  = var.subnet_id
    # if multiple ec2 is running, you can ask them by index num like in dictionary
    private_ip = element(var.private_ip, count.index)
    associate_public_ip_address = var.associate_public_ip_address
    private_dns_name_options {
        enable_resource_name_dns_a_record = var.enable_dns_arec
    }

    key_name   = var.key_name  
    vpc_security_group_ids = var.sec_group_ids
    
    user_data = var.provision_conf
    
    # provisioner is module that ssh to instance while initialization 
    # in this case it is used to send ssh-key from local machine into remote instance
    provisioner "file" {
        source = var.source_local
        destination = var.dest_remote
        # terraform will continue running, even if provisioner failed  
        on_failure = continue
    }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = var.private_key_to_provision
    }

    # "Created" will be same for all instances
    # "Name" will be assigned depending on position in list of names
    tags = {
        Name    = element(var.list, count.index)
        Created = "Terraform"
    }
}







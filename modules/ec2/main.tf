resource "aws_instance" "common" {
    # count is invoke resources multiple times, it depends from number of names in list
    count = length(var.instances)

    ami                 = var.ami
    instance_type       = var.instance_type
    availability_zone   = var.availability_zone

    subnet_id           = var.subnet_id

    associate_public_ip_address = var.associate_public_ip_address

    private_dns_name_options {
        enable_resource_name_dns_a_record = var.enable_dns_arec
    }

    key_name   = var.key_name  
    vpc_security_group_ids = var.sec_group_ids
    
    user_data = var.user_data
    
}








resource "aws_instance" "ec2" {
    count = length(var.list)

    ami           = var.ami
    instance_type = var.instance_type
    availability_zone = var.availability_zone

    subnet_id  = var.subnet_id
    private_ip = element(var.private_ip, count.index)
    associate_public_ip_address = var.associate_public_ip_address

    key_name   = var.key_name  
    vpc_security_group_ids = var.sec_group_ids

    user_data = var.user_data 

    tags = {
        Name = element(var.list, count.index)
    }
}







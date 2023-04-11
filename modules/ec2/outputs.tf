output "private_ips" {
    value = [ for ec2 in aws_instance.common: ec2.private_ip ]
}

output "public_ips" {
    value = [ for ec2 in aws_instance.common: ec2.public_ip ]
}

output "ids" {
    value = [ for ec2 in aws_instance.common: ec2.id ]
}

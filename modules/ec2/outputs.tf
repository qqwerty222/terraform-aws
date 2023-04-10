output "private_ips_json" {
    value = jsonencode([ for ec2 in aws_instance.common: ec2.private_ip ])
}

output "public_ips_json" {
    value = jsonencode([ for ec2 in aws_instance.common: ec2.private_ip ])
}

output "ids" {
    value = [ for ec2 in aws_instance.common: ec2.id ]
}

output "ids_json" {
    value = jsonencode([for ec2 in aws_instance.common: ec2.id])
}
# return list with (Name: name, Pub_ip: 1.1.1, Pr_ip: 1.1.1) strings for each instance
output "ips" {
    value = [ for ec2 in aws_instance.common:
        { public = ec2.public_ip, private = ec2.private_ip }
    ]
}

output "ips_json" {
    value = jsonencode([ for ec2 in aws_instance.common:
        { public = ec2.public_ip, private = ec2.private_ip }
    ])
}

output "ids" {
    value = [ for ec2 in aws_instance.common: ec2.id ]
}

output "ids_json" {
    value = jsonencode([for ec2 in aws_instance.common: ec2.id])
}
# return list with (Name: name, Pub_ip: 1.1.1, Pr_ip: 1.1.1) strings for each instance
output "ec2_ip" {
    value = [
        for x in aws_instance.ec2:
        "Name: ${x.tags.Name} Public_ip: ${x.public_ip} Private_ip: ${x.private_ip}"
    ]
}

# return list with private_ips
output "private_ips" {
    value = var.private_ip
}

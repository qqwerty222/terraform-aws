output "ec2_public_ip" {
    value = [
        for x in aws_instance.ec2:
        "${x.tags.Name} - ${x.public_ip}"
    ]
}

output "ec2_private_ip" {
    value = [
        for x in aws_instance.ec2:
        "${x.tags.Name} - ${x.private_ip}"
    ]
}

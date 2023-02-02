output "ec2_ip" {
    value = [
        for x in aws_instance.ec2:
        "Name: ${x.tags.Name} Public_ip: ${x.public_ip} Private_ip: ${x.private_ip}"
    ]
}

# output "ec2_public_ip" {
#     value = aws_instance.ec2.public_ip
# }

# output "ec2_private_ips" {
#     value = [
#         for x in aws_instance.ec2:
#         "${x.private_ip}"
#     ]
# }

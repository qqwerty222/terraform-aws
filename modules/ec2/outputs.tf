# return list with (Name: name, Pub_ip: 1.1.1, Pr_ip: 1.1.1) strings for each instance
output "ec2_ip_common" {
    value = [
        for x in aws_instance.ec2:
        "Public_ip: ${x.public_ip} Private_ip: ${x.private_ip}"
    ]
}

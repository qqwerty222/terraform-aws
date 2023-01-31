output "dns_id" {
    value = aws_security_group.dns.id
}

output "wserver_id" {
    value = aws_security_group.wserver.id
}

output "ssh_id" {
    value = aws_security_group.ssh.id
}

# output "common_id" {
#     value = aws_security_group.common.id
# }


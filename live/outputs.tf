output "dns_vpc_id" {
    value = module.dns_net.vpc_id
}

output "dns_subnet_id" {
    value = module.dns_net.subnet_id
}
 
output "ec2_ansible_public_ip" {
    value = module.ansible.ec2_public_ip
}

output "ec2_dns_stack_private_ip" {
    value = module.dns_stack.ec2_private_ip
}


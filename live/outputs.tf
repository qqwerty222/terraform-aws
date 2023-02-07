# outputs that will be shown in cli after terraform apply
output "dns_vpc_id" {
    value = module.dns_net.vpc_id
}

output "dns_subnet_id" {
    value = module.dns_net.subnet_id
}

# outputs below generated from ../modules/ec2/ouptuts|ec2_ip but for different modules
output "ec2_ansible-master_ip" {
    value = module.ansible-master.ec2_ip
}

output "ec2_dns_ip" {
    value = module.dns.ec2_ip
}

output "ec2_user_ip" {
    value = module.user.ec2_ip
}






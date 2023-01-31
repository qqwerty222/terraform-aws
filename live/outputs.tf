output "dns_vpc_id" {
    value = module.dns_net.vpc_id
}

output "dns_subnet_id" {
    value = module.dns_net.subnet_id
}
 
output "ngx_private_ip" {
    value = module.test_stack.ngx_private_ip
}

output "user_private_ip" {
    value = module.test_stack.user_private_ip
}
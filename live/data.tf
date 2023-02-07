# set data source that contains cloud-init script for ec2 user_data
data "cloudinit_config" "ansible_master" {
    part {
        content_type = "text/cloud-config"
        content = templatefile("../cloud-init_scripts/ansible_master.yml", {
            # set variables that will be used ini cloud-init script
                   # set templatefile and variables to it, as value of cloud-init script vars
            hosts: templatefile("../templates/hosts.tpl", { 
                dns_ips       = module.dns.private_ips 
                webserver_ips = module.webserver.private_ips 
                user_ips      = module.user.private_ips  
                })

            gvars_all: templatefile("../templates/gvars_all.tpl", {
                dns_ips        = module.dns.private_ips
                webserver_ips  = module.webserver.private_ips
                cidr_block    = module.dns_net.subnet_cidr
                })
            playbook: var.dns_stack_playbook
        })
    }
}

variable "availability_zone" {
    type    = string
    default = "eu-central-1b"
}

variable "public_ssh_test" {
    type = string
    sensitive = true
}

variable "cidr_1" {
    type = string
    sensitive = true
}

variable "dns_stack_playbook" {
    type = string
    default = "https://github.com/qqwerty222/dns-ngx-ansible.git"
}






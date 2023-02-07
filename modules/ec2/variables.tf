# variables below will be filled in modules ../live/project-ec2
variable "availability_zone" {
    type    = string 
    default = null
}

#-----List-------
# list of names, to run multiple ec2 from one module
variable "list" {
    type = list
    default = null
}

#-----Network-----
variable "subnet_id" {
    type    = string
    default = null
}

# number of private_ips must be equal to num of names  
variable "private_ip" {
    type    = list
    default = null
}

variable "associate_public_ip_address" {
    type    = bool
    default = false
}

variable "enable_dns_arec" {
    type    = bool
    default = false
}

#-----Configuration-----
variable "ami" {
    type    = string
    default = null
}

variable "instance_type" {
    type    = string
    default = null
}

variable "provision_conf" {
    type = string
    default = null
}

variable "private_key_to_provision" {
    type = string
    default = null
    sensitive = true
}

# if ec2 doesn't have public_ip provisioner will connect to your local machine
# useful if you want to debug stack where some ec2 have public_ip and other doesn't
#--- but you cannot use vars there so find another way)))
# variable "ip_to_provision" {
#     type = string
#     default = self.public_ip != "" ? self.public_ip:"127.0.0.1"
# }

variable "source_local" {
    type = string
    default = null
}

variable "dest_remote" {
    type = string
    default = null
}

#-----Security-----
variable "key_name" {
    type = string
    default = null
}

# variable is a list, to make possible assign multiple security groups to ec2
variable "sec_group_ids" {
    type = list
    default = null
}


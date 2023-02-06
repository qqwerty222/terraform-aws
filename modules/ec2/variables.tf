variable "availability_zone" {
    type    = string 
    default = null
}

#-----List-------
variable "list" {
    type = list
    default = null
}

#-----Network-----
variable "subnet_id" {
    type    = string
    default = null
}

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

# variable "ip_to_provision" {
#     type = string
#     default = 
# }

variable "source_local" {
    type = string
    default = null
}

variable "dest_remote" {
    type = string
    default = null
}

# variable "commands" {
#     type = list
#     default = ["echo 'Null'"]
# }

#-----Security-----
variable "key_name" {
    type = string
    default = null
}

variable "sec_group_ids" {
    type = list
    default = null
}


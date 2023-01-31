variable "availability_zone" {
    type    = string 
    default = null
}

variable "ami" {
    type    = string
    default = "ami-03e08697c325f02ab"
}

#-----Network-----
variable "subnet_id" {
    type    = string
    default = null
}

variable "dns_private_ip" {
    type    = string
    default = "10.0.1.10"
}

variable "ngx_private_ip" {
    type    = string
    default = "10.0.1.11"
}

variable "user_private_ip" {
    type    = string
    default = "10.0.1.12"
}

#-----Security-----
variable "key_name" {
    type = string
    default = null
}

variable "dns_sec_groups" {
    type = string
    default = null
}

variable "ngx_sec_groups" {
    type = string
    default = null
}

variable "user_sec_groups" {
    type = string
    default = null
}
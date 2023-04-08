
variable "availability_zone" {
    type    = string 
    default = null
}

variable "instances" {
    type = list
    default = null
    description = "list of names for ec2"
}

#-----Network-----
variable "subnet_id" {
    type    = string
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

variable "user_data" {
    type    = string
    default = null
}

#-----Security-----
variable "key_name" {
    type = string
    default = null
}

variable "sec_group_ids" {
    type = list
    default = null
    description = "list of sec groups assigned to ec2"
}


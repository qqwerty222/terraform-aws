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
    type   = bool
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
    type = string
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
}


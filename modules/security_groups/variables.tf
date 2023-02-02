variable "name" {
    type    = string
    default = null
}

variable "description" {
    type    = string
    default = null
}

variable "vpc_id" {
    type    = string
    default = null
}

#-----InboundRule------
variable "ingress_to_port" {
    type    = number
    default = 0
}

variable "ingress_from_port" {
    type    = number
    default = 0
}

variable "ingress_protocol" {
    type    = string
    default = null
}

variable "ingress_cidr" {
    type    = string
    default = null
}

#-----OutboundRule-----
variable "egress_to_port" {
    type    = number
    default = 0
}

variable "egress_from_port" {
    type    = number
    default = 0
}

variable "egress_protocol" {
    type    = string
    default = null
}

variable "egress_cidr" {
    type    = string
    default = null
}
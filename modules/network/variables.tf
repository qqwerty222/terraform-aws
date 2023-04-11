variable "availability_zone" {
    type        = string
    default     = null
    description = "AWS availability zone to locate vpc in"
}

variable "vpc_name" {
    type        = string
    default     = null
    description = "Name of the vpc"
}

variable "vpc_cidr" {
    type        = string
    default     = null
    description = "CIDR of the vpc, example: 10.0.0.0/16"
}

variable "subnet_name" {
    type        = string 
    default     = null
    description = "Name of the subnet"
}

variable "subnet_cidr" {
    type    = string
    default = null
    description = "CIDR of the subnet, example: 10.0.1.0/24"
}



variable "availability_zone" {
    type    = string
    default = "eu-central-1b"
}

variable "public_ssh_test" {
    type = string
    sensitive = true
}

variable "cidr_1" {
    type      = string
    sensitive = true
}

variable "consul_token" {
    type      = string
    sensitive = true
}






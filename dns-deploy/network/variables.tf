variable "AWS_ACCESS_KEY" {
    type        = string
    sensitive   = true
}

variable "AWS_SECRET_KEY" {
    type        = string
    sensitive   = true
}

variable "PROJECT_NAME" {
    type    = string
    default = null
}

variable "CONSUL_IP" {
    type    = string
    default = null
}

variable "CONSUL_DC" {
    type    = string
    default = null
}

variable "CONSUL_TOKEN" {
    type    = string
    default = null
}
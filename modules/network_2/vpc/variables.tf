variable "name" {
    type        = string
    default     = null
    description = "Name of the vpc"
}

variable "cidr" {
    type        = string
    default     = null
    description = "CIDR of the vpc, example: 10.0.0.0/16"
}

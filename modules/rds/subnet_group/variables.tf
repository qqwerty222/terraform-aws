variable "name" {
    type        = string
    default     = null
    description = "Name of the subnet group"
}

variable "subnet_ids" {
    type        = list
    default     = null
    description = "IDs of subnets in subnet group"
}
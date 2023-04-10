variable "vpc_id" {
    type    = string
    default = null
}
variable "security_groups" {
    type = list(object({
        name            = string
        description     = string

        ingress         = list(object({
            to_port     = number
            from_port   = number
            protocol    = string
            cidr_blocks = list(string)
        }))

        egress          = list(object({
            to_port     = number
            from_port   = number
            protocol    = string
            cidr_blocks = list(string)
        }))
    }))
    description = "List with parameters for each security group"
}



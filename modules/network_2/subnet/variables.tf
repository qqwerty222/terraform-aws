variable "vpc_id" {
    type        = string
    default     = null
    description = "ID of the vpc to associate subnets"
}

variable "subnets" {
    type = list(object({
        name    = string
        cidr    = string
        av_zone = string
    }))
    description = "Example: [ { name = 'subnet-1', cidr = '10.0.1.0/16', av_zone = 'eu-central-1a' }]"
}
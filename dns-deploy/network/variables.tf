variable "AWS_ACCESS_KEY" {
    type        = string
    default     = null
    sensitive   = true
} 

variable "AWS_SECRET_KEY" {
    type        = string
    default     = null
    sensitive   = true
}

variable "AWS_AVAILABILITY_ZONE" {
    type        = string
    default     = null
}

variable "AWS_REGION" {
    type        = string
    default     = null
}

variable "PROJECT_NAME" {
    type        = string
    default     = null
    description = "Name of the project, address to consul KV depends on it"
}

variable "CONSUL_IP" {
    type        = string
    default     = null
    description = "IP address of consul server, where consul KV is running"
}

variable "CONSUL_DC" {
    type        = string
    default     = null
    description = "Consul server datacenter"
}

variable "CONSUL_TOKEN" {
    type        = string
    default     = null
    sensitive   = true
    description = "Access token"
}
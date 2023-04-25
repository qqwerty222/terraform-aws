variable "AWS_ACCESS_KEY" {
    type        = string
    sensitive   = true
    description = "AWS access key of account to use for deploy"
}

variable "AWS_SECRET_KEY" {
    type        = string
    sensitive   = true
    description = "AWS secret key of account to use for deploy"
}

variable "AWS_AVAILABILITY_ZONE" {
    type        = string
    description = "AWS availability zone to locate resources in"
}

variable "AWS_REGION" {
    type        = string
    description = "AWS region to locate resources in"
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

variable "ADMIN_USERNAME" {
    type        = string
    default     = null
    description = "Username for DB admin account"
}

variable "ADMIN_PASSWORD" {
    type        = string
    default     = null
    sensitive   = true
    description = "Password for DB admin account"
}
variable "number" {
    type        = number
    default     = null
    description = "number of instances to deploy"
}

variable "ami" {
    type        = string
    default     = null
}

variable "instance_type" {
    type        = string
    default     = null
    description = "type of ec2 instance, t2.micro at example"
}

variable "availability_zone" {
    type        = string 
    default     = null
}

variable "subnet_id" {
    type        = string
    default     = null
}

variable "key_name" {
    type        = string
    default     = null
    description = "name of ssh key to assign"
}

variable "sec_group_ids" {
    type        = list
    default     = null
    description = "list of sec groups assigned to ec2"
}

variable "user_data" {
    type        = string
    default     = null
    description = "cloud init script to while initialization"
}


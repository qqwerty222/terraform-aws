variable "number" {
    type        = number
    default     = null
    description = "number of instances to deploy"
}

variable "ami" {
    type        = string
    default     = null
    description = "Amazon machine image to use"
}

variable "instance_type" {
    type        = string
    default     = null
    description = "Type of ec2 instance, t2.micro at example"
}

variable "availability_zone" {
    type        = string 
    default     = null
    description = "AWS availability zone to locate instance in"
}

variable "subnet_id" {
    type        = string
    default     = null
    description = "ID of subnet where instance will be located"
}

variable "public_ip" {
    type        = string
    default     = false
    description = "Associate public ip to instance or not (true/false)"
}

variable "key_name" {
    type        = string
    default     = null
    description = "Name of ssh key assign to instance"
}

variable "sec_group_ids" {
    type        = list
    default     = null
    description = "List of sec groups assign to instance"
}

variable "user_data" {
    type        = string
    default     = null
    description = "Cloud-init script to run while initialization"
}

variable "instance_name" {
    type        = string
    default     = null
    description = "Name for instance, count index will be added to it"
}


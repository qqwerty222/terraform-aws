variable "name" {
    type        = string
    default     = null
    description = "Name of the database"
}

variable "allocated_storage" {
    type        = number
    default     = null
    description = "Actual capacity of database in GB"
}

variable "engine" {
    type        = string
    default     = null
    description = "Name of the sql engine, can be: mysql, mariadb, aurora-mysql etc."
}

variable "engine_version" {
    type        = string
    default     = null
    description = "Version of the sql engine"
}

variable "instance_class" {
    type        = string
    default     = null
    description = "Similar to instance_type, example: db.t3.micro"
}

variable "username" {
    type        = string
    default     = null
    description = "Name of the predefined user"
}

variable "password" {
    type        = string
    default     = null
    description = "Password for the predefined user"
}

variable "parameter_group_name" {
    type        = string
    default     = null
    description = "Name of the DB parameter group to associate"
}

variable "subnet_group" {
    type        = string
    default     = null
    description = "Name of the subnet group to associate"
}

variable "publicly_accessible" {
    type        = string
    default     = false
    description = "If true DB will get public ip"
}

variable "security_groups" {
    type        = list
    default     = null
    description = "List of security groups to associate"
}


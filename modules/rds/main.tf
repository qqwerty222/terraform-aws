resource "aws_db_instance" "common" {
    db_name                     = var.name
    allocated_storage           = var.allocated_storage
    engine                      = var.engine
    engine_version              = var.engine_version
    instance_class              = var.instance_class

    manage_master_user_password = var.secrets_manager
    username                    = var.admin_username
    password                    = var.admin_password

    parameter_group_name        = var.parameter_group_name

    publicly_accessible         = var.publicly_accessible
    vpc_security_group_ids      = var.vpc_security_groups
}
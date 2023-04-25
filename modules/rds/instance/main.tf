resource "aws_db_instance" "common" {
    identifier                  = var.name
    allocated_storage           = var.allocated_storage
    engine                      = var.engine
    engine_version              = var.engine_version
    instance_class              = var.instance_class

    username                    = var.username
    password                    = var.password

    parameter_group_name        = var.parameter_group_name
    skip_final_snapshot         = true
    db_subnet_group_name        = var.subnet_group
    multi_az                    = var.multi_az
    publicly_accessible         = var.publicly_accessible
    vpc_security_group_ids      = var.security_groups
}


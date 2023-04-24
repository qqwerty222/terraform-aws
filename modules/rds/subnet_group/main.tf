resource "aws_db_subnet_group" "common" {
    name                        = var.name
    subnet_ids                  = var.subnet_ids
}
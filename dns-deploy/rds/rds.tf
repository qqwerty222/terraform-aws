module "database" {
    source = "../../modules/rds"

    availability_zone   = var.AWS_AVAILABILITY_ZONE
    db_name             = "test-database"
    engine              = "mysql"
    engine_version      = "8.0.32"
    instance_class      = "db.t3.micro"
    
    secrets_manager     = true
    username            = "admin"

}
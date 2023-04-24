module "database" {
    source = "../../modules/rds"

    name                        = "test-database"
    allocated_storage           = 20
    engine                      = "mysql"
    engine_version              = "8.0.32"
    instance_class              = "db.t3.micro"
    
    secrets_manager             = true
    username              = "admin"
}
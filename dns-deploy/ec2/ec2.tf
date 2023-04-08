module "ec2" {
    source = "../modules/ec2"

    instances           = ["dns", "webserver", "user"]
    instance_type       = "t2.micro"
    ami                 = "ami-03e08697c325f02ab"

    availability_zone   = var.availability_zone
    subnet_id           = module.network.subnet_id

    key_name            = module.common_key.name
    sec_group_ids       = module.security_groups_common.ids
}






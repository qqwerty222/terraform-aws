module "security_groups_common" {
    source = "../modules/security_groups"

    security_groups = [
        { 
            name        = "ssh_from_internet",
            description = "sec group to ssh from internet",
            vpc_id      = module.network.vpc_id,

            ingress     = [
                { to_port = 22, from_port = 0, protocol = "tcp", cidr_blocks = [var.cidr_1] }
            ]

            egress      = [
                { to_port = 0, from_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
            ]
        },

        { 
            name        = "icmp"
            description = "allow icmp(ping) traffic from everywhere"
            vpc_id      = module.network.vpc_id

            ingress     = [
                { to_port = "-1", from_port = "-1", protocol = "icmp", cidr_blocks = ["0.0.0.0/0"] }
            ]

            egress      = [
                { to_port = "-1", from_port = "-1", protocol = "icmp", cidr_blocks = ["0.0.0.0/0"] }
            ]
        }
    ]
}

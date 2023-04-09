module "security_groups_common" {
    source = "../../modules/security_groups"

    security_groups = [
        { 
            name        = "ssh_from_internet",
            description = "sec group to ssh from internet",
            vpc_id      = data.consul_keys.network.var.vpc_id,

            ingress     = [
                { to_port = 22, from_port = 0, protocol = "tcp", cidr_blocks = ["78.11.112.118/32", "89.75.84.100/32"] }
            ]

            egress      = [
                { to_port = 0, from_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
            ]
        },

        { 
            name        = "icmp"
            description = "allow icmp(ping) traffic from everywhere"
            vpc_id      = data.consul_keys.network.var.vpc_id,

            ingress     = [
                { to_port = "-1", from_port = "-1", protocol = "icmp", cidr_blocks = ["0.0.0.0/0"] }
            ]

            egress      = [
                { to_port = "-1", from_port = "-1", protocol = "icmp", cidr_blocks = ["0.0.0.0/0"] }
            ]
        }
    ]
}

data "consul_keys" "network" {
    key { 
        name = "vpc_id" 
        path = "${var.PROJECT_NAME}/network/vpc/id"
    }
}

data "consul_keys" "security_groups" {
    key {
        name = "ssh_from_internet"
        path = "${var.PROJECT_NAME}/security_groups/ssh_from_internet"
    }
}

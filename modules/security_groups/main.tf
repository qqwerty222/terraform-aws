
resource "aws_security_group" "sec_group" {

    name                = var.parameters["name"]
    description         = var.parameters["description"]
    
    vpc_id              = var.vpc_id

    dynamic "ingress" {
        for_each = var.parameters["ingress"]
        content {
            to_port     = ingress.value["to_port"]
            from_port   = ingress.value["from_port"]
            protocol    = ingress.value["protocol"]
            cidr_blocks = ingress.value["cidr_blocks"]
        }
    }

    dynamic "egress" {
        for_each = var.parameters["egress"]

        content {
            to_port     = egress.value["to_port"]
            from_port   = egress.value["from_port"]
            protocol    = egress.value["protocol"]
            cidr_blocks = egress.value["cidr_blocks"]
        }
    }
}

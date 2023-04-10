
resource "aws_security_group" "sec_group" {
    count = length(var.security_groups)

    name        = var.security_groups[count.index]["name"]
    description = var.security_groups[count.index]["description"]
    
    vpc_id      = var.vpc_id

    dynamic "ingress" {
        for_each = var.security_groups[count.index]["ingress"]
        content {
            to_port     = ingress.value["to_port"]
            from_port   = ingress.value["from_port"]
            protocol    = ingress.value["protocol"]
            cidr_blocks = ingress.value["cidr_blocks"]
        }
    }

    dynamic "egress" {
        for_each = var.security_groups[count.index]["egress"]

        content {
            to_port     = egress.value["to_port"]
            from_port   = egress.value["from_port"]
            protocol    = egress.value["protocol"]
            cidr_blocks = egress.value["cidr_blocks"]
        }
    }
}


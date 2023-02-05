
resource "aws_security_group" "sec_group" {
    name        = var.name
    description = var.description
    
    vpc_id = var.vpc_id

    ingress {
        to_port     = var.ingress_to_port
        from_port   = var.ingress_from_port
        protocol    = var.ingress_protocol
        cidr_blocks = [var.ingress_cidr]
    }

    egress {
        to_port     = var.egress_to_port
        from_port   = var.egress_from_port
        protocol    = var.egress_protocol
        cidr_blocks = [var.egress_cidr]
    }

    tags = {
        Name    = var.name
        Created = "Terraform"
    }
}


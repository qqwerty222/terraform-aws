resource "aws_security_group" "dns" {
    description = "Open inbound connection to dns port"

    vpc_id = var.vpc_id
    ingress {
        to_port     = 53
        from_port   = 0
        protocol    = "udp"

        cidr_blocks = [var.cidr_block ]
    }
    
    egress {
        to_port     = 0
        from_port   = 0
        protocol    = "-1"
        cidr_blocks = [var.cidr_block]
    }

    tags = {
        Name    = "dns"
        Created = "terraform"
    }
}

resource "aws_security_group" "wserver" {
    description = "Open inbound connection to http port"

    vpc_id = var.vpc_id
    ingress {
        to_port     = 80
        from_port   = 0
        protocol    = "tcp"

        cidr_blocks = [var.cidr_block]
    }
    egress {
        to_port     = 0
        from_port   = 0
        protocol    = "-1"
        cidr_blocks = [var.cidr_block]
    }
    
    tags = {
        Name    = "wserver"
        Created = "terraform"
    }
}

resource "aws_security_group" "ssh" {
    description = "allow ssh connection"
    
    vpc_id = var.vpc_id
    ingress {
        to_port     = 22
        from_port   = 0
        protocol    = "tcp"
        cidr_blocks = [var.cidr_block]
    }
    egress {
        to_port     = 0
        from_port   = 0
        protocol    = "-1"
        cidr_blocks = [var.cidr_block]
    }

    tags = {
        Name    = "ssh"
        Created = "terraform"
    }
}

# resource "aws_security_group" "common" {
#     vpc_id = var.vpc_id

#     egress {
#         to_port     = 0
#         from_port   = 0
#         protocol    = "-1"
#         cidr_blocks = [var.cidr_block]
#     }

#     tags = {
#         Name = "cp"
#         Created = "terraform"
#     }
# }

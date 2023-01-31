resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "main" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = var.subnet_name
    }
}
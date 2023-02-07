resource "aws_vpc" "vpc" {
    cidr_block          = var.vpc_cidr

    tags = {
        Name    = var.vpc_name
        Created = "Terraform"
    }
}

resource "aws_subnet" "subnet" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name    = var.subnet_name
        Created = "Terraform"
    }
}

# there you can specify routes you need, into default vpc route_table
resource "aws_route" "local" {
    route_table_id         = aws_vpc.vpc.main_route_table_id
    gateway_id             = aws_internet_gateway.int_gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "int_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name    = "dns_gateway"
        Created = "Terraform" 
    }
}




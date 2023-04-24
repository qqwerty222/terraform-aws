resource "aws_vpc" "common" {
    cidr_block              = var.cidr
    tags = {
        Name                = var.name
    }
}
resource "aws_internet_gateway" "common" {
    vpc_id                  = aws_vpc.common.id
}

resource "aws_route" "local" {
    route_table_id          = aws_vpc.common.main_route_table_id
    gateway_id              = aws_internet_gateway.common.id
    destination_cidr_block  = "0.0.0.0/0"
}






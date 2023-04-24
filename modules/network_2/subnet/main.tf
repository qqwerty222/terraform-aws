resource "aws_subnet" "common" {
    count   = length(var.subnets)

    vpc_id              = var.vpc_id

    cidr_block          = var.subnets[count.index]["cidr"]
    availability_zone   = var.subnets[count.index]["av_zone"]
    tags = {
        Name            = var.subnets[count.index]["name"]
    }
}
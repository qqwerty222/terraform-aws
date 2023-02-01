output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_id" {
    value = aws_subnet.subnet.id
}

output "subnet_cidr" {
    value = var.subnet_cidr
}

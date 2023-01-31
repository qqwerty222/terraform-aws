output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_id" {
    value = aws_subnet.main.id
}

output "subnet_cidr" {
    value = var.subnet_cidr
}
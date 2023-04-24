output "ids" {
    value = [ for x in aws_subnet.common: x.id ]
}
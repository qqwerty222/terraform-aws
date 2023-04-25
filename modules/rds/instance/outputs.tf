output "id" {
    value = aws_db_instance.common.id
}

output "address" {
    value = aws_db_instance.common.address
}

output "multi_az" {
    value = aws_db_instance.common.multi_az
}

output "av_zone" {
    value = aws_db_instance.common.availability_zone
}
output "id" {
    value = aws_key_pair.common.id
}

# output "ids" {
#     value = [ for key in aws_key_pair.common: key.id ]
# }

# output "ids_json" {
#     value = jsonencode([ for key in aws_key_pair.common: key.id ])
# }
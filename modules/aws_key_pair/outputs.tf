# will be used in ../project-ec2|dns, webserverm user
output "key_name" {
    value = aws_key_pair.test_stack.key_name
}
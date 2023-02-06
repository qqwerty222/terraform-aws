resource "aws_key_pair" "test_stack" {
    key_name   = var.key_name
    public_key = var.public_key

    tags = {
        Created = "Terraform"
    }
}
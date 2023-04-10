resource "aws_key_pair" "common" {
    key_name   = var.key["key_name"]
    public_key = var.key["pub_key"]
}

# resource "aws_key_pair" "common" {
#     count = length(var.key_list)

#     key_name   = var.key_list[count.index]["key_name"]
#     public_key = var.key_list[count.index]["pub_key"]
# }
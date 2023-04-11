variable "key" {
    type        = map(string)
    default     = null
    sensitive   = true
    description = "Map that contain key_name and pub_key. { key_name = orange, pub_key = ssh-rsa12312321 }"
}

# variable "key_list" {
#     type = list(object({
#         key_name = string
#         pub_key  = string
#     }))
#     default     = null
#     sensitive   = true
# }
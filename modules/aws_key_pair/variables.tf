variable "key" {
    type        = map(string)
    default     = null
    sensitive   = true
}

# variable "key_list" {
#     type = list(object({
#         key_name = string
#         pub_key  = string
#     }))
#     default     = null
#     sensitive   = true
# }
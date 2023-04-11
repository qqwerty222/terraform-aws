variable "push_lists" {
    type = list(object({
        path    = string
        value   = string
    }))
    description = "List that contain pathes for values to push in consul KV"
}
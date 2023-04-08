variable "push_lists" {
    type = list(object({
        path    = string
        value   = string
    }))
    description = "List with path/value to push in consul KV"
}
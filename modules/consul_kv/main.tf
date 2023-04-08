resource "consul_keys" "consul_KV_push" {
    dynamic "key" {
        for_each = var.push_lists
        
        content { 
            path    = key.value["path"]
            value   = key.value["value"]
        }
    }
}
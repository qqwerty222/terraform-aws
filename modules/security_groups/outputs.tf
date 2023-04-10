output "ids" {
    value = [
        for sec_group in aws_security_group.sec_group:
        sec_group.id
    ]
}

output "ids_json" {
    value = "[ null%{ for sec_group in aws_security_group.sec_group ~}, \"${sec_group.id}\" %{ endfor ~}]"
}

output "ids_string" {
    value = "{\n%{ for x in aws_security_group.sec_group ~} ${x.name} = ${x.id}, \n%{endfor ~}}"
}


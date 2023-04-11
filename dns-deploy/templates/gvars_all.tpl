dns_ips: %{ for ip in dns_ips ~} ${ip} %{endfor ~}      
webserver_ips: %{ for ip in dns_ips ~} ${ip} %{endfor ~}
cidr_block: ${cidr_block}
dns_ips: %{ for ip in dns_ips ~} ${ip} %{endfor ~}       
\nwebserver_ips: %{ for ip in dns_ips ~} ${ip} %{endfor ~} 
\ncidr_block: ${cidr_block}


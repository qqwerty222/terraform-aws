# we need only one dns_ip, to use as default dns by test user
dns_ips: 
 - ${ dns_ips[0] }      
webserver_ips: 
%{ for ip in dns_ips ~} - ${ip} %{endfor ~}

cidr_block: ${cidr_block}
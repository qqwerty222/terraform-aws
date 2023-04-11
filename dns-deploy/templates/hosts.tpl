[dns_servers]  
%{ for ip in dns_ips ~}
${ip}
%{endfor ~}

[webservers]
%{ for ip in webserver_ips ~}
${ip}
%{endfor ~}

[users]
%{ for ip in user_ips ~}
${ip}
%{endfor ~}
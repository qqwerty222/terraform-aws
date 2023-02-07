[dns_servers]  
%{ for ip in dns_ips ~}
\n${ip}
%{endfor ~}

[webservers]
%{ for ip in webserver_ips ~}
\n${ip}
%{endfor ~}

[users]
%{ for ip in user_ips ~}
\n${ip}
%{endfor ~}